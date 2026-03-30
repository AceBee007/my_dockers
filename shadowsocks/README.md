# Shadowsocks (shadowsocks-libev)

Docker Compose で [shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev) を起動するための構成。

公式イメージ: [shadowsocks/shadowsocks-libev](https://hub.docker.com/r/shadowsocks/shadowsocks-libev)

## Quick Start

```bash
# 1. 環境変数ファイルを作成し、パスワード等を設定
cp .env.sample .env
vim .env  # PASSWORD を必ず変更すること

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

| 変数           | 説明                          | デフォルト           |
| -------------- | ----------------------------- | -------------------- |
| `PASSWORD`     | サーバーパスワード (**必須**) | -                    |
| `SERVER_ADDR`  | サーバーリッスンアドレス      | `0.0.0.0`            |
| `SERVER_PORT`  | サーバーリッスンポート        | `8388`               |
| `HOST_PORT`    | ホスト側(Docker)の公開ポート  | `SERVER_PORT` と同じ |
| `METHOD`       | 暗号化方式                    | `aes-256-gcm`        |
| `TIMEOUT`      | タイムアウト (秒)             | `300`                |
| `DNS_ADDRS`    | DNSサーバー                   | `8.8.8.8,8.8.4.4`    |
| `SERVER_LABEL` | SS リンクの表示名 (任意)      | -                    |
| `ARGS`         | ss-server 追加引数            | -                    |

## SS リンク生成

```bash
./gen_link.sh
```

サーバーの公開IPは `ipinfo.io` から自動取得される。`.env` の `SERVER_LABEL` でリンクに表示名を付けられる。

## ポートを変更する場合

`.env` の `SERVER_PORT` と `HOST_PORT` を変更する:

```bash
SERVER_PORT="18500"
HOST_PORT="18500"
```

ファイアウォール側でも該当ポートを開放すること。
