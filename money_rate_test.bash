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
    pip install yfinance
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
