#!/usr/bin/env bash
# check-numbers.sh · 门面数字一致性断言（2026-09-18 顾问审校轮新增）
# 用途：发布前验证 README/宣传文案中的数字声明与仓库实测一致——「真实数字锚点」的机器保镖。
# 用法：bash scripts/check-numbers.sh
# 退出码：0=全部一致；1=有断言失败（输出哪条不符）

set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

FAIL=0
ok()   { echo "✅ $1"; }
bad()  { echo "❌ $1"; FAIL=1; }

# ---------- 实测计数 ----------
N_TOPICS=$(ls 02-知识库/01-专题/[0-9]*.md 2>/dev/null | wc -l)
N_CASES=$(ls -d 02-知识库/04-案例库/示例-*/ 2>/dev/null | wc -l)
N_ADVISORS=$(ls -d 01-顾问agent/skills/*-advisor 2>/dev/null | wc -l)
N_SKILLS=$(ls -d 01-顾问agent/skills/*/ 2>/dev/null | grep -vc deep-research)  # deep-research 本地自用不入库
N_SOPS=$(ls 03-SOP/c[0-9]*.md 03-SOP/d[0-9]*.md 2>/dev/null | wc -l)
N_RECIPES=$(ls 02-知识库/05-配方库/[0-9]*.md 2>/dev/null | wc -l)
if [ -f 02-知识库/02-官方文档/llms-full.txt ]; then
  N_PLATFORMS=$(awk 'NR>=24634 && NR<=24661 && /^\|/ {c++} END {print c+0}' 02-知识库/02-官方文档/llms-full.txt)
else
  N_PLATFORMS=""   # llms-full.txt 为本地资产（fetch-hermes-docs.sh 拉取），CI 环境无 → 跳过该项
fi

echo "=== 仓库实测：专题=$N_TOPICS 案例=$N_CASES 领域技能=$N_ADVISORS 入库技能=$N_SKILLS 工序=$N_SOPS 配方=$N_RECIPES ==="

# ---------- 声明断言 ----------
[ "$N_TOPICS" -eq 15 ]    && ok "专题 15"    || bad "专题数实测 $N_TOPICS ≠ 声明 15（改 README/文案或补专题后同步）"
[ "$N_CASES" -eq 6 ]      && ok "案例 6"      || bad "案例数实测 $N_CASES ≠ 声明 6"
[ "$N_ADVISORS" -eq 4 ]   && ok "领域技能 4"  || bad "领域技能实测 $N_ADVISORS ≠ 声明 4"
[ "$N_SKILLS" -eq 8 ]     && ok "入库技能 8"  || bad "入库技能实测 $N_SKILLS ≠ 声明 8"
[ "$N_SOPS" -eq 11 ]      && ok "工序 11"     || bad "工序实测 $N_SOPS ≠ 声明 11"
[ "$N_RECIPES" -eq 3 ]    && ok "配方 3"      || bad "配方实测 $N_RECIPES ≠ 声明 3"
if [ -z "$N_PLATFORMS" ]; then
  echo "⏭️  平台对照跳过（llms-full.txt 为本地资产，CI 环境不存在；本地运行时复验）"
elif [ "$N_PLATFORMS" -eq 28 ]; then
  ok "平台对照 28 行"
else
  bad "平台对照实测 $N_PLATFORMS 行 ≠ 基准 28（llms 重抓会漂移——先复核锚点再改声明）"
fi

# ---------- 文件中的数字出现检查（防旧数字回流） ----------
echo "=== 文档声明扫描 ==="
check_absent() { # 文件 错误数字模式 说明
  if grep -q "$2" "$1" 2>/dev/null; then bad "$1 含旧口径「$3」→ 改为当前口径"; else ok "$1 无旧口径「$3」"; fi
}
check_absent README.md        "十二份专题\|12 份落地专题\|×12\|八件套\|示例案例×4\|案例 ×4" "旧专题/案例口径"
check_absent README.en.md     "12 field guides\|×12\|Sample cases ×4\|4 cases"   "old case count"
check_absent README.en.md     "12 field guides\|×12\|eight-piece"     "12 field guides"
check_absent README.ja.md     "贡献者募集份\|手法論\|方案設計"          "中文残留"
check_absent docs/index.html  "十二份专题"                              "12 份专题"
check_absent "04-运营/宣传素材/launch文案-20260918.md" "12 份落地专题\|12 field guides\|四个行业案例\|Four fictional" "旧案例口径"
check_absent docs/index.html  "4 个完整示例案例" "旧案例口径"

# ---------- 内部锚点 lint（zh/en README 的 ](#…) 是否可解析） ----------
anchor_exists() { # 文件 锚点
  local f="$1" a="$2"
  # GitHub slug 规则（本项目用到子集）：小写化、空格→-、去标点（中英标点均剥）
  grep -q "^#.*" "$f" || return 1
  python - "$f" "$a" <<'PY' 2>/dev/null || return 1
import sys, re, unicodedata
f, want = sys.argv[1], sys.argv[2].lower()
slugs = set()
for line in open(f, encoding="utf-8"):
    if line.startswith("#"):
        t = re.sub(r"^#+\s*", "", line).strip()
        s = t.lower()
        s = "".join(c for c in s if not unicodedata.category(c).startswith("P"))
        s = re.sub(r"\s+", "-", s)
        slugs.add(s)
sys.exit(0 if want in slugs else 1)
PY
}
for f in README.md README.en.md; do
  for a in $(grep -o "](#[^)]*)" "$f" | sed "s/](#//;s/)//"); do
    if anchor_exists "$f" "$a"; then ok "$f 锚点 #$a"; else bad "$f 锚点断链：#$a"; fi
  done
done

echo "=== 结论：$([ $FAIL -eq 0 ] && echo 全部通过 ✅ || echo 有失败项 ❌) ==="
exit $FAIL
