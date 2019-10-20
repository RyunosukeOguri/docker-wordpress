## Install 手順

### 1.クローンする

```
$ git clone git@github.com:RyunosukeOguri/docker-wordpress.git
```

### 2.環境変数の修正

1. `.env.sample` 内に記載されている `your_project_name` を任意の名前に置換する

2. sample をコピーする

```
$ cp .env.sample .env
```

3. `.env` 内の `APP_PORT`, `APP_LOCAL_DOMAIN` 等は自分の好きなポート番号で構いませんし env は個々の環境で変えてしまって大丈夫です。

### 3.Docker 起動(初回イメージが自動で pull されます)

```
$ docker-compose up -d
```

### 4.サイトを開く

```
$ open http://0.0.0.0:10011
```
