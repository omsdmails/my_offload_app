# main.py

from rpc_server import app
import socket

def get_local_ip():
    """
    يحدد عنوان IP الفعلي لجهازك عبر فتح سوكيت UDP مؤقت.
    """
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        # لا تبعث بيانات فعلية، يكفي الاتصال الوهمي
        s.connect(('8.8.8.8', 80))
        ip = s.getsockname()[0]
    except Exception:
        ip = '127.0.0.1'
    finally:
        s.close()
    return ip

def register_service():
    """
    يقوم بتسجيل خدمة mDNS فقط عند تشغيل التطبيق.
    الاستيراد مؤجل لتجنّب تنفيذ الكود أثناء بناء APK.
    """
    from offload_lib import Zeroconf, ServiceInfo
    ip_address = get_local_ip()
    print(f"[✓] Registering mDNS on {ip_address}:7520")
    zc = Zeroconf()
    info = ServiceInfo(
        "_http._tcp.local.",
        "offload-app._http._tcp.local.",
        addresses=[socket.inet_aton(ip_address)],
        port=7520,
        properties={}
    )
    zc.register_service(info)
    return zc, info

if __name__ == "__main__":
    zc, info = register_service()
    try:
        app.run(host="0.0.0.0", port=7520)
    finally:
        zc.unregister_service(info)
        zc.close()
