#!/bin/bash
# SPDX-FileCopyrightText: 2024 Naoki Maruyama
# SPDX-License-Identifier: BSD-3-Clause


# Pythonのyfinanceモジュールがインストールされているか確認
#if ! python3 -c "import yfinance" &> /dev/null; then
#    echo "yfinanceがインストールされていません。インストールします"
#    pip3 install yfinance
#fi

#######################################################あ

ng () {
	echo ${1}行目が違うよ
	res=1
}

# 固定レートを設定
export TEST_RATE_JPYUSD=X=1.23551
export TEST_RATE_JPYEUR=X=0.56523
export TEST_RATE_JPYKRW=X=13.54225

res=0
#正常な入力
#半角の数字
out=$(echo 1000 | ./money_rate)
result="1235ドル 51セント
565ユーロ 23セント
13542ウォン 25チョン"
[ "${out}" = "${result}" ] || ng "$LINENO"

out=$(echo 0 | ./money_rate)
result="0ドル 0セント
0ユーロ 0セント
0ウォン 0チョン"
[ "${out}" = "${result}" ] || ng "$LINENO"

#計算結果小数第3位が5以上だと繰り上げられる
out=$(echo 1 | ./money_rate)
result="1ドル 24セント
0ユーロ 57セント
13ウォン 54チョン"
[ "${out}" = "${result}" ] || ng "$LINENO"

out=$(echo 11 | ./money_rate)
result="13ドル 59セント
6ユーロ 22セント
148ウォン 96チョン"
[ "${out}" = "${result}" ] || ng "$LINENO"

#全角の数字
out=$(echo １０００ | ./money_rate)
result="1235ドル 51セント
565ユーロ 23セント
13542ウォン 25チョン"
[ "${out}" = "${result}" ] || ng "$LINENO"

out=$(echo ０ | ./money_rate)
result="0ドル 0セント
0ユーロ 0セント
0ウォン 0チョン"
[ "${out}" = "${result}" ] || ng "$LINENO"

#計算結果小数第3位が5以上だと繰り上げられる
out=$(echo １ | ./money_rate)
result="1ドル 24セント
0ユーロ 57セント
13ウォン 54チョン"
[ "${out}" = "${result}" ] || ng "$LINENO"

out=$(echo １１ | ./money_rate)
result="13ドル 59セント
6ユーロ 22セント
148ウォン 96チョン"
[ "${out}" = "${result}" ] || ng "$LINENO"

#異常な入力
#文字
out=$(echo あ | ./money_rate)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

#空白
out=$(echo | ./money_rate)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

#マイナスの値
out=$(echo -1 | ./money_rate)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

#小数の入力(円の値を入力してほしいので小数はプログラムの趣旨的に異常な入力)
out=$(echo 1.1 | ./money_rate)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "$res" = 0 ] && echo "OK"

exit $res
