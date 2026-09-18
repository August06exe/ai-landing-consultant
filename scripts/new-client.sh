#!/usr/bin/env bash
# 新建客户六件套：bash scripts/new-client.sh <真名> [YYYY-MM-DD]
# 例：bash scripts/new-client.sh 王强 2026-09-20
set -euo pipefail

NAME="${1:?用法: new-client.sh <真名> [YYYY-MM-DD]}"
DATE="${2:-$(date +%F)}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIR="$ROOT/05-客户/$DATE-$NAME"
TPL="$ROOT/05-客户/_模板"

[ -e "$DIR" ] && { echo "❌ 已存在: $DIR"; exit 1; }

mkdir -p "$DIR/00-商务" "$DIR/02-交付包/hermes/workflows" "$DIR/04-调研"
cp "$TPL/客户档案与需求.md" "$DIR/01-档案与需求.md"
cp "$TPL/点火日志-模板.md" "$DIR/03-陪跑日志.md"   # 点火日志=陪跑日志的第一条（交付当天填）
touch "$DIR/05-复盘.md"

echo "✅ 客户六件套已建: $DIR"
echo "下一步：把 01-档案与需求.md 里已知信息填上，剩下的交给顾问 agent（c1 需求调研）。"
