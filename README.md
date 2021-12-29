# sinatra_plactice
フィヨルドブートキャンプの「Sinatraを使ってWebアプリケーションの基本を理解する」の提出物のリポジトリです。

## How to use
1. 作業PCの任意の作業ディレクトリにて`git clone`してください。

```
$ git clone https://github.com/shucream-p/sinatra_practice.git
```
1. `cd sinatra_plactice`でカレントディレクトリを変更してください。
1. Bundlerをインストールしてください。

```
$ gem install bundler
```
1. Bundlerでgemを一括インストールしてください。(Gemfileに記述されたgemが一括インストールされます。)

```
$ bundle install
```
1. Bundler経由でmemoapp.rbを起動してください。

```
$ bundler exec ruby memoapp.rb
```