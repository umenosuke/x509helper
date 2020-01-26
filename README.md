# 証明書作成スクリプト

## これは何

- CAの作成
- サーバー用秘密鍵及び証明書作成
- クライアント用秘密鍵及び証明書作成

を行うスクリプト

## 使い方

### 初期化

```
cp config_sample.sh config.sh
vi config.sh #必要な箇所を修正
```

### CAの作成

```
sudo ./gen_ca.sh
```

### サーバー用秘密鍵及び証明書作成

```
sudo ./gen_server.sh '<サーバー名>' '<SAN>'
#SAN = "IP:192.0.2.1" or "DNS:example.com"
```

### クライアント用秘密鍵及び証明書作成

```
sudo ./gen_client.sh '<クライアント名>'
```
