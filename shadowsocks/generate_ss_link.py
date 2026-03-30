#!/usr/bin/env python3
"""Generate a Shadowsocks (SS) link from environment variables."""

import base64
import os
import subprocess
import sys
import urllib.parse
import urllib.request


def get_public_ip(timeout: int = 5) -> str:
    try:
        with urllib.request.urlopen("https://ipinfo.io/ip", timeout=timeout) as resp:
            return resp.read().decode().strip()
    except Exception:
        print("Warning: failed to get public IP (timeout or network error), using 0.0.0.0", file=sys.stderr)
        return "0.0.0.0"


def generate_ss_link(
    server: str,
    port: int,
    password: str,
    method: str,
    name: str = "",
    plugin: str = "",
    plugin_opts: str = "",
) -> str:
    userinfo = base64.urlsafe_b64encode(f"{method}:{password}".encode()).decode().rstrip("=")
    link = f"ss://{userinfo}@{server}:{port}"
    if plugin:
        plugin_str = urllib.parse.quote(plugin, safe="")
        if plugin_opts:
            plugin_str += urllib.parse.quote(f";{plugin_opts}", safe="")
        link += "/?plugin=" + plugin_str
    if name:
        link += "#" + urllib.parse.quote(name, safe="")
    return link


def main() -> None:
    password = os.environ.get("PASSWORD", "")
    if not password:
        print("Error: PASSWORD is not set", file=sys.stderr)
        sys.exit(1)

    server = get_public_ip()
    port = int(os.environ.get("HOST_PORT", "8388"))
    method = os.environ.get("METHOD", "chacha20-ietf-poly1305")
    name = os.environ.get("SERVER_LABEL", "")

    plugin = ""
    plugin_opts = ""
    args = os.environ.get("ARGS", "")
    if "--plugin" in args:
        parts = args.split()
        server_plugin = ""
        raw_opts = ""
        for i, p in enumerate(parts):
            if p == "--plugin" and i + 1 < len(parts):
                server_plugin = parts[i + 1]
            if p == "--plugin-opts" and i + 1 < len(parts):
                raw_opts = parts[i + 1]

        # obfs-server -> client side is simple-obfs
        if server_plugin == "obfs-server":
            plugin = "simple-obfs"
            obfs_host = "www.baidu.com"
            obfs_uri = "/s?ie=utf-8&f=8&rsv_bp=1&rsv_idx=1&tn=baidu&wd=what%20is%20qwen"
            for opt in raw_opts.split(";"):
                if opt.startswith("obfs="):
                    obfs_mode = opt  # obfs=http or obfs=tls
                    plugin_opts = f"{obfs_mode};obfs-host={obfs_host};obfs-uri={obfs_uri}"
                    break
        else:
            plugin = server_plugin
            plugin_opts = raw_opts

    link = generate_ss_link(server, port, password, method, name, plugin, plugin_opts)
    print(link)

    try:
        ans = input("\nQRコードをターミナルに表示しますか？ [y/N]: ").strip().lower()
    except (EOFError, KeyboardInterrupt):
        ans = ""
    if ans == "y":
        print_qr(link)


def ensure_qrcode() -> None:
    try:
        import qrcode  # noqa: F401
    except ImportError:
        print("Installing qrcode...", file=sys.stderr)
        subprocess.check_call([sys.executable, "-m", "pip", "install", "qrcode"], stdout=subprocess.DEVNULL)


def print_qr(data: str) -> None:
    ensure_qrcode()
    import qrcode

    qr = qrcode.QRCode(border=1)
    qr.add_data(data)
    qr.make()

    BLACK = "\033[40m  \033[0m"
    WHITE = "\033[47m  \033[0m"

    matrix = qr.get_matrix()
    print()
    for row in matrix:
        print("".join(BLACK if cell else WHITE for cell in row))
    print()


if __name__ == "__main__":
    main()
