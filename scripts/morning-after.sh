#!/usr/bin/env bash
# 早晨验收工具（给不熟悉 git 的人）：bash scripts/morning-after.sh
# 做三件事：①检查 main 是否被动过 ②展示夜航分支的成果 ③你点个头就合并收货
set -uo pipefail
cd "$(dirname "$0")/.."
git fetch origin --tags -q

echo "━━━ 1/4 main 安全检查 ━━━"
L=$(git rev-parse main); R=$(git rev-parse origin/main)
if [ "$L" = "$R" ]; then
  echo "✅ 本地与远端的 main 完全一致（夜航没有碰 main）"
else
  echo "❌ main 有偏差！本地:$L 远端:$R"
  echo "   一键恢复到远端状态:  git checkout main && git reset --hard origin/main"
fi

echo
echo "━━━ 2/4 夜航分支成果 ━━━"
if ! git rev-parse --verify -q origin/night-shift >/dev/null; then
  echo "⚠️ 远端没有 night-shift 分支：夜航可能没跑、没推，或中途断了。"
  echo "   本地分支列表: $(git branch -a | tr '\n' ' ')"
  echo "   看夜航自己的记录: 07-工作区/夜航/ 目录"
  exit 0
fi
echo "【提交列表】"
git log --oneline origin/main..origin/night-shift | sed 's/^/  /'
echo
echo "【改动概览】"
git diff --stat origin/main...origin/night-shift | tail -20

echo
echo "━━━ 3/4 隐私抽查 ━━━"
HITS=$(git grep -I -iE 'sk-[A-Za-z0-9]{16,}|ghp_[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|1[3-9][0-9]{9}' \
  $(git rev-list origin/main..origin/night-shift) -- 2>/dev/null | head -5)
if [ -n "$HITS" ]; then
  echo "❌ 发现疑似密钥/手机号，先别合并："; echo "$HITS"
else
  echo "✅ 夜航新增内容未发现密钥/手机号特征"
fi

echo
echo "━━━ 4/4 是否收货合并到 main？━━━"
read -r -p "满意就输 y 合并并推送（其他任何键=只看不并）: " ans
if [ "$ans" = "y" ] || [ "$ans" = "Y" ]; then
  git tag "backup/nightshift-premerge-$(date +%Y%m%d)" origin/main
  git push origin "backup/nightshift-premerge-$(date +%Y%m%d)" -q
  git checkout main -q && git merge --no-ff origin/night-shift -m "merge: 夜航成果合入（night-shift）" \
    && git push origin main 2>&1 | tail -1 \
    && echo "✅ 已合并推送。合并前的 main 也打了备份标签，后悔随时可回滚。"
else
  echo "👍 未合并。分支还在远端，想看细节:  git diff origin/main...origin/night-shift"
fi
