#!/bin/bash
# SPDX-FileCopyrightText: 2024 Naoki Maruyama
# SPDX-License-Identifier: BSD-3-Clause

ng () {
	echo ${1}行目が違うよ
	res=1
}

# 固定レートを設定
export TEST_RATE_JPYUSD=1.23551
export TEST_RATE_JPYEUR=0.56523
export TEST_RATE_JPYKRW=13.54225

# yfinanceモジュールがインストールされているか確認
python3 -c "import yfinance" &> /dev/null

if [[ $? -ne 0 ]]; then
    echo "yfinanceがインストールされていません。インストールします..."
    pip3 install yfinance
fi

res=0
###正常な入力###
##半角の数字##
out=$(echo 1000 | ./exchange_rate)
result="USD 1235.51
EUR 565.23
KRW 13542.25"
[ "${out}" = "${result}" ] || ng "$LINENO"

out=$(echo 0 | ./exchange_rate)
result="USD 0.0
EUR 0.0
KRW 0.0"
[ "${out}" = "${result}" ] || ng "$LINENO"

#計算結果小数第3位が5以上だと繰り上げられる
out=$(echo 1 | ./exchange_rate)
result="USD 1.24
EUR 0.57
KRW 13.54"
[ "${out}" = "${result}" ] || ng "$LINENO"

out=$(echo 11 | ./exchange_rate)
result="USD 13.59
EUR 6.22
KRW 148.96"
[ "${out}" = "${result}" ] || ng "$LINENO"

#小数以下0の入力
out=$(echo 1.000 | ./exchange_rate)
result="USD 1.24
EUR 0.57
KRW 13.54"
[ "${out}" = "${result}" ] || ng "$LINENO"

##全角の数字##
out=$(echo １０００ | ./exchange_rate)
result="USD 1235.51
EUR 565.23
KRW 13542.25"
[ "${out}" = "${result}" ] || ng "$LINENO"

out=$(echo ０ | ./exchange_rate)
result="USD 0.0
EUR 0.0
KRW 0.0"
[ "${out}" = "${result}" ] || ng "$LINENO"

#計算結果小数第3位が5以上だと繰り上げられる
out=$(echo １ | ./exchange_rate)
result="USD 1.24
EUR 0.57
KRW 13.54"
[ "${out}" = "${result}" ] || ng "$LINENO"

out=$(echo １１ | ./exchange_rate)
result="USD 13.59
EUR 6.22
KRW 148.96"
[ "${out}" = "${result}" ] || ng "$LINENO"


####異常な入力###
#文字
out=$(echo あ | ./exchange_rate)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

#空白
out=$(echo | ./exchange_rate)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

#マイナスの値
out=$(echo -1 | ./exchange_rate)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

#小数の入力(円の値を入力してほしいので小数はプログラムの趣旨的に異常な入力)
out=$(echo 1.1 | ./exchange_rate)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

#全角の小数以下が0の入力
out=$(echo １．０００ | ./exchange_rate)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

#記号と数字
out=$(echo [10] | ./exchange_rate)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(echo {10} | ./exchange_rate)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "$res" = 0 ] && echo "OK"

exit $res
