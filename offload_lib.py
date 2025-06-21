import psutil, requests, socket, time, os
from functools import wraps

try:
    from zeroconf import Zeroconf, ServiceBrowser, ServiceInfo
except ImportError:
    Zeroconf = None
    ServiceBrowser = None
    ServiceInfo = None

# thresholds
MAX_CPU = 0.7   # 70%
MIN_MEM = 200   # MB

class PeerListener:
    def __init__(self):
        self.peers = []

    def add_service(self, zc, type, name):
        info = zc.get_service_info(type, name)
        if info:
            ip = socket.inet_ntoa(info.addresses[0])
            port = info.port
            self.peers.append(f"http://{ip}:{port}/run")

def discover_peers(timeout=1):
    # ⛔ تعطيل إذا كنا داخل عملية بناء
    if os.environ.get("IS_ANDROID_BUILD") == "1" or Zeroconf is None:
        return []

    zc = Zeroconf()
    listener = PeerListener()
    ServiceBrowser(zc, "_http._tcp.local.", listener)
    time.sleep(timeout)
    zc.close()
    return listener.peers

def try_offload(url, payload):
    for _ in range(3):
        try:
            r = requests.post(url, json=payload, timeout=5)
            r.raise_for_status()
            return r.json()["result"]
        except:
            time.sleep(0.5)
    raise RuntimeError("All offload attempts failed")

def offload(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        cpu = psutil.cpu_percent() / 100.0
        mem = psutil.virtual_memory().available / (1024**2)
        if cpu > MAX_CPU or mem < MIN_MEM:
            peers = discover_peers()
            for peer in peers:
                try:
                    payload = {"func": func.__name__, "args": args, "kwargs": kwargs}
                    return try_offload(peer, payload)
                except:
                    continue
        return func(*args, **kwargs)
    return wrapper
