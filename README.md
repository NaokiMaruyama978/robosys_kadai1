# robosys_kadai1
[![test](https://github.com/NaokiMaruyama978/robosys_kadai1/actions/workflows/test.yml/badge.svg)](https://github.com/NaokiMaruyama978/robosys_kadai1/actions)

## このリポジトリについて
大学の講義(ロボットシステム学)で作成したものです。  
現在の為替レート情報を取得し日本円をドル・ユーロ・ウォンに変換する   
exchange_rateコマンドを作成しました。

## exchange_rateコマンド 
## 概要
 - 入力された値(日本円)をドルとセント・ユーロとセント・ウォンとチョンに変換します
 - 半角でも全角でも変換されます
 - 対応してない文字や記号、スペースが入力された場合は何も出力されず、プログラムが終了します

# 実行方法
## リポジトリのクローン
GitHub リポジトリからクローンします。

```
$ git clone git@github.com:NaokiMaruyama978/robosys_kadai1.git
```

GitHub アカウントがない場合は HTTPS を使用：
```
$ git clone https://github.com/NaokiMaruyama978/robosys_kadai1.git
```
## ディレクトリに移動
```
$ cd robosys_kadai1
```
## 実行権限の付与
必要に応じて以下のコマンドで実行権限の付与してください。
```
$ chmod +x exchange_rate
```
## Pythonのyfinanceモジュールがインストールされていない場合
以下のコマンドでインストールをして下さい
```
 $ pip3 install yfinance
```
## yfinanceモジュールがインストールされているかの確認方法
以下のコマンドで確認してください
```
$ pip3 show yfinance
```
### インストールされている場合
```
Name: yfinance
Version: 0.2.50
Summary: Download market data from Yahoo! Finance API
.
.
.
Required-by:
```
上記のような表示が出ます
### インストールされていない場合
```
WARNING: Package(s) not found: yfinance
```
上記のような表示が出るか何も表示されません


## 実行例
```
 $ echo 1000 | ./exchange_rate
```
USD 6.61  
EUR 6.26  
KRW 9215.86

## 動作環境  
### 必要なソフトウェア
- Python
  - テスト済みバージョン3.7～3.10
### テスト環境
- Ubuntu 22.04 LTS

## ライセンス
- このリポジトリはBSD-3-Clauseライセンスの下で公開されています。
- 詳細は[LICENSE](https://github.com/NaokiMaruyama978/robosys_kadai1/blob/master/LICENSE)を確認してください。
- © 2024 Naoki Maruyama
