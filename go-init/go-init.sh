#!/bin/bash

# goを初期化したいディレクトリのフルパスを指定
WORKING_DIR= # フルパス
# go.modに記載するモジュールパス
MODULE_PATH= # リポジトリのパス 例: github.com/<ユーザー名>/<リポジトリ名>/<...path>

START_DIR=$(pwd)

echo "[作業ディレクトリ]" "$WORKING_DIR"
echo "[スクリプトのあるディレクトリ]" "$START_DIR"

# 初期化
cd "$WORKING_DIR" && go mod init "$MODULE_PATH"

# main.goを指定箇所へコピー
cp "$START_DIR"/stab/main.go "$WORKING_DIR"/main.go

# サンプルのテストをコピー
cp -r "$START_DIR"/stab/domain "$WORKING_DIR"

# パッケージ関連インストール
cd "$WORKING_DIR" && go mod tidy

# 動作確認
cd "$WORKING_DIR" && echo "### サンプルテスト実施 ###" && go test ./...
cd "$WORKING_DIR" && echo "### main.go を動かす ###" && go run .