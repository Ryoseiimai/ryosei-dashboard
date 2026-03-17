#!/bin/bash
# ダッシュボード更新 & GitHub Pages自動デプロイスクリプト
# 使い方: bash update_and_push.sh

REPO_DIR="C:/Users/admin/Desktop/RYOSEIWORLD_AI_Team/ryosei-dashboard"
SOURCE_DIR="C:/Users/admin/Desktop/RYOSEIWORLD_AI_Team/AI_Organization"

cd "$REPO_DIR" || { echo "ERROR: リポジトリディレクトリが見つからない"; exit 1; }

# AI_Organizationから最新のJSONとHTMLをコピー
echo "=== 最新ファイルをコピー中 ==="
cp "$SOURCE_DIR/dashboard_data.json" "$REPO_DIR/" 2>/dev/null && echo "  dashboard_data.json 更新"
cp "$SOURCE_DIR/finance_data.json" "$REPO_DIR/" 2>/dev/null && echo "  finance_data.json 更新"
cp "$SOURCE_DIR/dashboard.html" "$REPO_DIR/" 2>/dev/null && echo "  dashboard.html 更新"
cp "$SOURCE_DIR/finance.html" "$REPO_DIR/" 2>/dev/null && echo "  finance.html 更新"
cp "$SOURCE_DIR/issues_log.html" "$REPO_DIR/" 2>/dev/null && echo "  issues_log.html 更新"
cp "$SOURCE_DIR/chat_log.html" "$REPO_DIR/" 2>/dev/null && echo "  chat_log.html 更新"

# 変更がなければ終了
if git diff --quiet && git diff --cached --quiet; then
    echo "=== 変更なし。pushスキップ ==="
    exit 0
fi

# git add → commit → push
echo "=== Git push 中 ==="
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
git add -A
git commit -m "Dashboard update: $TIMESTAMP"
git push origin main

echo "=== 完了 ==="
echo "URL: https://ryoseiimai.github.io/ryosei-dashboard/"
