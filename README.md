# sinatra_plactice
フィヨルドブートキャンプの「Sinatraを使ってWebアプリケーションの基本を理解する」の提出物のリポジトリです。

## How to use
### データベースを準備する
1. PostgreSQLをインストールする。

```
$ brew install postgresql
```
2. PostgreSQLを起動する。

```
$ brew services start postgresql
```
3. データベースに接続する。

```
$ psql -U <ユーザー名> postgres
```
4. メモ保存用のデータベース`memo_db`を作成する。

```
postgres=# CREATE DATABASE memo_db;
```
5. memo_dbに接続する。

```
postgres=# \c memo_db;
```
6. メモ保存用のテーブル`Memos`を作成する。

```
memo_db=# CREATE TABLE Memos
          (id SERIAL,
           title TEXT,
           contents TEXT,
           PRIMARY KEY (id));
```

### アプリケーションを準備する
1. 作業PCの任意の作業ディレクトリにて`git clone`してください。

```
$ git clone https://github.com/shucream-p/sinatra_practice.git
```
2. `cd sinatra_plactice`でカレントディレクトリを変更してください。
3. Bundlerをインストールしてください。

```
$ gem install bundler
```
4. Bundlerでgemを一括インストールしてください。(Gemfileに記述されたgemが一括インストールされます。)

```
$ bundle install
```
5. Bundler経由でmemoapp.rbを起動してください。

```
$ bundle exec ruby memoapp.rb
```

6. ブラウザで`http://localhost:4567/memos`にアクセスしてください。
