# Shadowsocks (shadowsocks-libev)

Docker Compose で [shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev) を起動するための構成。

公式イメージ: [shadowsocks/shadowsocks-libev](https://hub.docker.com/r/shadowsocks/shadowsocks-libev)

## Quick Start

```bash
# 1. 環境変数ファイルを作成し、パスワード等を設定
cp .env.sample .env
vi .env  # SS_PASSWORD を必ず変更すること

# 2. 起動
docker compose up -d

# 3. ログ確認
docker compose logs -f
```

## 停止 / 再起動

```bash
# 停止
docker compose down

# 再起動
docker compose restart
```

## 環境変数

| 変数 | 説明 | デフォルト |
|------|------|-----------|
| `PASSWORD` | サーバーパスワード (**必須**) | - |
| `PORT` | ホスト側の公開ポート | `8388` |
| `METHOD` | 暗号化方式 | `chacha20-ietf-poly1305` |
| `TIMEOUT` | タイムアウト (秒) | `300` |
| `DNS_ADDRS` | DNSサーバー | `8.8.8.8,8.8.4.4` |
| `ARGS` | ss-server 追加引数 | - |

## simple-obfs (難読化プラグイン)

`.env` の `ARGS` で設定:

```bash
# HTTP 難読化
ARGS=--plugin obfs-server --plugin-opts obfs=http;fast-open

# TLS 難読化
ARGS=--plugin obfs-server --plugin-opts obfs=tls;fast-open
```

クライアント側は `obfs-local` + 同じ `obfs` モードを指定すること。

## SS リンク生成

`.env` を読み込んでリンクを生成:

```bash
(set -a && source .env && set +a && python3 generate_ss_link.py)
```

`.env` の `SERVER_LABEL` でリンクに表示名を付けられる。`SERVER` でサーバーIPを指定可能 (デフォルト: `0.0.0.0`)。

## ポートを変更する場合

`.env` の `PORT` を変更するだけでOK:

```bash
PORT=18500
```

ファイアウォール側でも該当ポートを開放すること。
