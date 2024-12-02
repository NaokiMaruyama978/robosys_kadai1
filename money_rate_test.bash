#!/bin/bash
# SPDX-FileCopyrightText: 2024 Naoki Maruyama
# SPDX-License-Identifier: BSD-3-Clause


# 入力引数のチェック
if [[ $# -eq 0 ]]; then
    echo "エラー: 円の金額を引数として指定してください。" >&2
    echo "使用例: ./money_rate_test.bash 1000" >&2
    exit 1
fi

# 入力値が数値かどうかを確認
if ! [[ $1 =~ ^[0-9]+$ ]]; then
    echo "エラー: 引数には数字を入力してください。" >&2
    echo "使用例:  ./money_rate_test.bash 1000" >&2
    exit 1
fi

# Pythonのyfinanceモジュールがインストールされているか確認
if ! python3 -c "import yfinance" &> /dev/null; then
    echo "yfinanceがインストールされていません。インストールします"
    pip3 install yfinance
fi


# Pythonスクリプトの実行
./money_rate 1000 "$1"
echo 1000 | ./money_rate  "$1"
# Pythonの実行が成功したか確認
if [[ $? -ne 0 ]]; then
    echo "エラー: Pythonスクリプトの実行に失敗しました。" >&2
    exit 1
fi

echo "テスト完了です。" >&1

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
[ "$?" = 0 ] || ng "$LINENO"
echo "$out" | grep -q "1235 ドル 51セント" || ng "$LINENO"
echo "$out" | grep -q "565 ユーロ 23セント" || ng "$LINENO"
echo "$out" | grep -q "13542 ウォン 25チョン" || ng "$LINENO"

out=$(echo 0 | ./money_rate)
[ "$?" = 0 ] || ng "$LINENO"
echo "$out" | grep -q "0 ドル 0セント" || ng "$LINENO"
echo "$out" | grep -q "0 ユーロ 0セント" || ng "$LINENO"
echo "$out" | grep -q "0 ウォン 0チョン" || ng "$LINENO"

#計算結果小数第3位が5以上だと繰り上げられる
out=$(echo 1 | ./money_rate)
[ "$?" = 0 ] || ng "$LINENO"
echo "$out" | grep -q "1 ドル 24セント" || ng "$LINENO"
echo "$out" | grep -q "0 ユーロ 57セント" || ng "$LINENO"
echo "$out" | grep -q "13 ウォン 54チョン" || ng "$LINENO"

out=$(echo 11 | ./money_rate)
[ "$?" = 0 ] || ng "$LINENO"
echo "$out" | grep -q "13 ドル 59セント" || ng "$LINENO"
echo "$out" | grep -q "6 ユーロ 22セント" || ng "$LINENO"
echo "$out" | grep -q "148 ウォン 96チョン" || ng "$LINENO"

#全角の数字
out=$(echo １０００ | ./money_rate)
[ "$?" = 0 ] || ng "$LINENO"
echo "$out" | grep -q "1235 ドル 51セント" || ng "$LINENO"
echo "$out" | grep -q "565 ユーロ 23セント" || ng "$LINENO"
echo "$out" | grep -q "13542 ウォン 25チョン" || ng "$LINENO"

out=$(echo ０ | ./money_rate)
[ "$?" = 0 ] || ng "$LINENO"
echo "$out" | grep -q "0 ドル 0セント" || ng "$LINENO"
echo "$out" | grep -q "0 ユーロ 0セント" || ng "$LINENO"
echo "$out" | grep -q "0 ウォン 0チョン" || ng "$LINENO"

#計算結果小数第3位が5以上だと繰り上げられる
out=$(echo １ | ./money_rate)
[ "$?" = 0 ] || ng "$LINENO"
echo "$out" | grep -q "1 ドル 24セント" || ng "$LINENO"
echo "$out" | grep -q "0 ユーロ 57セント" || ng "$LINENO"
echo "$out" | grep -q "13 ウォン 54チョン" || ng "$LINENO"

out=$(echo １１ | ./money_rate)
[ "$?" = 0 ] || ng "$LINENO"
echo "$out" | grep -q "13 ドル 59セント" || ng "$LINENO"
echo "$out" | grep -q "6 ユーロ 22セント" || ng "$LINENO"
echo "$out" | grep -q "148 ウォン 96チョン" || ng "$LINENO"

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

["$res" = 0 ] && echo OK

exit $res
