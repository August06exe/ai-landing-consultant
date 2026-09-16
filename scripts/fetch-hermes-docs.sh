#!/usr/bin/env bash
# 拉取 Hermes Agent 官方全量文档到本地知识库（02-知识库/02-官方文档/）
# 用法：bash scripts/fetch-hermes-docs.sh
set -euo pipefail

DEST="$(cd "$(dirname "$0")/.." && pwd)/02-知识库/02-官方文档"
mkdir -p "$DEST"

echo "[1/2] 下载 llms-full.txt（官方全量文档，约 4.6MB）..."
curl -fsSL --retry 3 -o "$DEST/llms-full.txt" \
  "https://hermes-agent.nousresearch.com/llms-full.txt"

echo "[2/2] 下载 docs-llms-index.txt（分节索引）..."
curl -fsSL --retry 3 -o "$DEST/docs-llms-index.txt" \
  "https://hermes-agent.nousresearch.com/docs/llms.txt"

echo "完成 ✅"
echo "查法：grep -n \"关键词\" \"$DEST/llms-full.txt\" 定位行号，再按行号区间阅读（不要整读）。"
