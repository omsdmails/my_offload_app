# rpc_server.py
from flask import Flask, request, jsonify
import your_tasks   # ملف يحتوي الدوال الثقيلة مزوّدة بـ @offload

app = Flask(__name__)

@app.route("/health")
def health():
    return jsonify(status="ok")

@app.route("/run", methods=["POST"])
def run():
    data = request.get_json()
    fn = getattr(your_tasks, data["func"], None)
    if not fn:
        return jsonify(error="Function not found"), 404
    res = fn(*data.get("args", []), **data.get("kwargs", {}))
    return jsonify(result=res)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=7520)
