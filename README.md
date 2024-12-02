# robosys_kadai1
[![test](https://github.com/NaokiMaruyama978/robosys_kadai1/actions/workflows/test.yml/badge.svg)](https://github.com/NaokiMaruyama978/robosys_kadai1/actions)

## このリポジトリについて
大学の講義(ロボットシステム学)で作成したものです。  
日本円をドル・ユーロ・ウォンに変換する
money_rateコマンドを作成しました。

## money_rateコマンド 
## 概要
 - 入力された値(日本円)をドルとセント・ユーロとセント・ウォンとチョンに変換します
 - 半角でも全角でも変換されます
 - 対応してない文字や記号が入力された場合はエラー文と入力例が出ます
 - 何年/何月/何日/何時/何分時点のレートか表示されます

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
以下のコマンドで実行権限の付与してください。
```
$ chmod +x money_rate
```
## Pythonのyfinanceモジュールがインストールされていない場合
以下のコマンドでインストールをして下さい
```
 $ pip3 install yfinance
```
## 実行例
```
 $ echo 1000 | ./money_rate
```
2024年11月30日17時45分 のレートを参照しています  
変換結果: 6 ドル 61 セント  
変換結果: 6 ユーロ 26 セント  
変換結果: 9215 ウォン 86 チョン

## 動作環境  
### 必要なソフトウェア
- Python
  - テスト済みバージョン3.7~3.10
### テスト環境
- Ubuntu 22.04 LTS

## ライセンス
- このリポジトリはBSD-3-Clauseライセンスの下で公開されています。
- 詳細は[LICENSE](https://github.com/NaokiMaruyama978/robosys_kadai1/blob/master/LICENSE)を確認してください。

## Copyright  
© 2024 Naoki Maruyama

