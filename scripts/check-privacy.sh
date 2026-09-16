#!/usr/bin/env bash
# 隐私全量体检：git 历史 + 当前跟踪文件里有没有客户数据/密钥
# 用法：bash scripts/check-privacy.sh   （随时可跑，推送前建议必跑）
set -uo pipefail
fail=0

echo "=== 体检 1/3：跟踪文件路径 ==="
BAD=$(git ls-files | grep -E \
  -e '^05-客户/' -e '^06-归档/' -e '^07-工作区/' -e '^(.*/)?00-商务/' \
  -e '/04-调研/' -e '/03-陪跑日志\.md$' -e '/05-复盘\.md$' \
  -e '01-顾问agent/skills/deep-research/' \
  | grep -v '^05-客户/_模板/')
[ -n "$BAD" ] && { echo "❌ 跟踪区出现禁区文件:"; echo "$BAD"; fail=1; } || echo "✅ 干净"

echo "=== 体检 2/3：全部历史中是否有禁区文件被提交过 ==="
HIST=$(git log --all --name-only --pretty=format: | sort -u | grep -E \
  -e '^05-客户/' -e '^06-归档/' -e '^07-工作区/' -e '^(.*/)?00-商务/' \
  | grep -v '^05-客户/_模板/')
[ -n "$HIST" ] && { echo "❌ 历史中出现禁区文件（哪怕已删也留在历史里！）:"; echo "$HIST"; fail=1; } || echo "✅ 干净"

echo "=== 体检 3/3：当前跟踪文件内容里的密钥/手机号 ==="
CNT=$(git grep -I -iE \
  -e 'sk-[A-Za-z0-9]{16,}' \
  -e 'ghp_[A-Za-z0-9]{20,}' \
  -e 'github_pat_[A-Za-z0-9_]{20,}' \
  -e 'AKIA[0-9A-Z]{16}' \
  -e 'BEGIN [A-Z ]*PRIVATE KEY' \
  -- . 2>/dev/null | head -10)
PHONE=$(git grep -IE '1[3-9][0-9]{9}' -- . 2>/dev/null | grep -v '1[3-9][0-9]{9}[0-9]' | head -5)
[ -n "$CNT" ] && { echo "❌ 疑似密钥:"; echo "$CNT"; fail=1; } || echo "✅ 无密钥特征"
[ -n "$PHONE" ] && { echo "⚠️ 疑似手机号（人工确认是否掩码）:"; echo "$PHONE"; } || echo "✅ 无手机号特征"

echo "=== 体检结论：$([ $fail -eq 0 ] && echo '通过 ✅（⚠️ 项请人工复核）' || echo '不通过 ❌ 立即处理！') ==="
exit $fail
