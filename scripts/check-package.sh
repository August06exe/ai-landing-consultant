#!/usr/bin/env bash
# 交付包完整性自检：bash scripts/check-package.sh <客户文件夹路径>
# 例：bash scripts/check-package.sh "05-客户/2026-09-20-王强"
set -uo pipefail

DIR="${1:?用法: check-package.sh <客户文件夹路径>}"
PKG="$DIR/02-交付包"
HERMES="$PKG/hermes"
fail=0

check() { # check <说明> <路径>
  if [ -e "$2" ]; then echo "✅ $1"; else echo "❌ $1（缺 $2）"; fail=1; fi
}

echo "=== 交付包自检：$DIR ==="
check "客户档案" "$DIR/01-档案与需求.md"
check "交付说明（给老板）" "$PKG/00-交付说明.md"
check "部署执行单（给老板）" "$PKG/01-部署执行单.md"
check "自装配指令（心脏）" "$HERMES/00-自装配指令.md"
check "SOUL.md（人格）" "$HERMES/SOUL.md"
check "AGENTS.md（任务约定）" "$HERMES/AGENTS.md"
check "cron 配置单" "$HERMES/cron.md"
check "进化守则" "$HERMES/进化守则.md"
check "使用卡（给人看的1页）" "$PKG/02-使用卡.md"

# workflows 目录非空
if [ -d "$HERMES/workflows" ] && [ -n "$(ls -A "$HERMES/workflows" 2>/dev/null)" ]; then
  n=$(ls -1 "$HERMES/workflows" | wc -l); echo "✅ 工作流文件（$n 条）"
else
  echo "❌ workflows/ 为空——没有工作流就没有交付"; fail=1
fi

# 六要素抽查：工作流文件里必须有验收演示场景
if [ -d "$HERMES/workflows" ]; then
  for f in "$HERMES/workflows"/*.md; do
    [ -e "$f" ] || continue
    if grep -q "验收演示" "$f"; then echo "✅ 验收场景：$(basename "$f")"; else echo "❌ 缺「验收演示」章节：$(basename "$f")"; fail=1; fi
  done
fi

# ---------- 结构校验（v2.x Phase B：从「文件存在」升级到「文件像样」） ----------
if [ -f "$HERMES/cron.md" ]; then
  if grep -q "失败" "$HERMES/cron.md"; then echo "✅ cron 失败动作栏"; else echo "❌ cron.md 无失败动作——不带失败告警的 cron 不得出包"; fail=1; fi
fi
if [ -f "$HERMES/进化守则.md" ]; then
  grep -q "外部" "$HERMES/进化守则.md" && echo "✅ 守则：外部内容敌意" || { echo "❌ 守则缺「外部内容=敌意」条目"; fail=1; }
  grep -q "成本" "$HERMES/进化守则.md" && echo "✅ 守则：成本自觉" || { echo "❌ 守则缺「成本自觉」条目"; fail=1; }
fi
if [ -f "$HERMES/00-自装配指令.md" ]; then
  grep -q "卡住" "$HERMES/00-自装配指令.md" && echo "✅ 自装配：卡点出口" || { echo "❌ 自装配指令缺「卡住了怎么办」出口"; fail=1; }
  grep -q "完成报告" "$HERMES/00-自装配指令.md" && echo "✅ 自装配：完成报告模板" || { echo "❌ 自装配指令缺「完成报告模板」"; fail=1; }
fi
if [ -d "$HERMES/workflows" ]; then
  for f in "$HERMES/workflows"/*.md; do
    [ -e "$f" ] || continue
    grep -q "版本" "$f" && echo "✅ 版本头：$(basename "$f")" || { echo "❌ 工作流缺版本头：$(basename "$f")"; fail=1; }
    grep -q "兜底\|失败" "$f" && echo "✅ 兜底：$(basename "$f")" || { echo "❌ 工作流缺失败兜底：$(basename "$f")"; fail=1; }
  done
fi
if [ -f "$PKG/02-使用卡.md" ]; then
  grep -q "报障\|出问题" "$PKG/02-使用卡.md" && echo "✅ 使用卡：报障路径" || { echo "❌ 使用卡缺报障路径"; fail=1; }
  grep -q "成本\|费用\|花费\|使用费" "$PKG/02-使用卡.md" && echo "✅ 使用卡：成本条" || { echo "❌ 使用卡缺成本条"; fail=1; }
fi

echo "=== 结果：$([ $fail -eq 0 ] && echo '全部通过，可以进 c5/c6' || echo '有缺项，补齐再交付') ==="
exit $fail
