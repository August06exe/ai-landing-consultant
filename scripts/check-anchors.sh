#!/usr/bin/env bash
# check-anchors.sh · llms-full.txt 行号锚点自动复核（v2.0 WP-B1）
# 用途：外评指出「行号级锚定会随官方文档重抓而腐烂」——本脚本把腐烂检测自动化。
# 原理：提取全仓 `llms-full.txt:NNNN` 断言 →
#   硬校验：行号存在且该行非空
#   软校验：从断言所在 markdown 行提取关键词（引号内词组/英文串），在 llms 对应行 ±3 行内查命中
# 用法：bash scripts/check-anchors.sh [目录...]   # 默认扫 02-知识库/01-专题 03-SOP
# 退出码：0=全部通过；1=有腐烂嫌疑（输出清单，人工复核后修源或标注）

set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LLMS="$ROOT/02-知识库/02-官方文档/llms-full.txt"
DOCS=("02-知识库/01-专题" "03-SOP")
[ $# -gt 0 ] && DOCS=("$@")

[ -f "$LLMS" ] || { echo "❌ 找不到 $LLMS"; exit 1; }
TOTAL_LINES=$(wc -l < "$LLMS")

FAIL=0; HARD_OK=0; SOFT_OK=0; SOFT_SKIP=0; SUSPECTS=0

# python 做逐锚点校验（bash 不适合行级索引）
python - "$LLMS" "${DOCS[@]}" <<'PY'
import sys, re, io, os

llms_path, dirs = sys.argv[1], sys.argv[2:]
llms = io.open(llms_path, encoding="utf-8", errors="replace").read().split("\n")
N = len(llms)

stat = {"total": 0, "hard_ok": 0, "soft_ok": 0, "soft_skip": 0, "suspect": 0}
suspects = []

# 关键词提取：断言行中的引号内容、≥5字中文串、≥4字符英文串
def keywords(line, ref):
    kws = set()
    for q in re.findall(r"[「『\"']([^「」『』\"']{3,30})[」』\"']", line):
        kws.add(q)
    for w in re.findall(r"[A-Za-z_][A-Za-z0-9_.\-]{3,}", line):
        if w.lower() not in {"llms", "full", "txt", "http", "https"}:
            kws.add(w)
    # 锚点行自身也可能带引语；再加引用文本前 60 字中的高频词
    seg = line.replace(ref, "")
    for w in re.findall(r"[\u4e00-\u9fff]{4,10}", seg):
        kws.add(w)
    return list(kws)[:8]

for d in dirs:
    base = os.path.normpath(os.path.join(os.path.dirname(llms_path), "..", "..", d))
    for root, _, files in os.walk(base):
        for fn in files:
            if not fn.endswith(".md"): continue
            fp = os.path.join(root, fn)
            rel = os.path.relpath(fp, os.path.dirname(llms_path) + "/..")
            try:
                text = io.open(fp, encoding="utf-8").read()
            except Exception:
                continue
            lines = text.split("\n")
            # 仅对声明基于 llms-full.txt 的文件启用裸 :NNNN 提取（否则会把行内编号误当锚点）
            declares_llms = "llms-full.txt" in text[:2000]
            for i, line in enumerate(lines, 1):
                if "anchor-ok" in line:
                    continue
                refs = [(m.group(0), int(m.group(1)), int(m.group(2) or m.group(1)))
                        for m in re.finditer(r"llms-full\.txt[:：]\s*(\d+)(?:\s*[-–—~]\s*(\d+))?", line)]
                if not refs and declares_llms:
                    refs = [(m.group(0), int(m.group(1)), int(m.group(2) or m.group(1)))
                            for m in re.finditer(r"(?<![A-Za-z.\\\u4e00-\u9fff0-9])[:：](\d{2,5})(?:\s*[-–—~]\s*(\d{2,5}))?(?=[^\d]|$)", line)]
                for ref, start, end in refs:
                    stat["total"] += 1
                    hard_ok = True; detail = ""
                    if start < 1 or end > N or start > end:
                        hard_ok = False; detail = f"行号越界(总{N}行)"
                    else:
                        window = [llms[j-1].strip() for j in range(start, min(end, N)+1)]
                        if not any(window):
                            hard_ok = False; detail = "目标行全空"
                    if not hard_ok:
                        stat["suspect"] += 1
                        suspects.append((rel, i, ref, detail))
                        continue
                    stat["hard_ok"] += 1
                    kws = keywords(line, ref)
                    if not kws:
                        stat["soft_skip"] += 1
                        continue
                    ctx = "\n".join(llms[max(0, start-4):min(end+3, N)])
                    if any(k in ctx for k in kws):
                        stat["soft_ok"] += 1
                    else:
                        stat["suspect"] += 1
                        suspects.append((rel, i, ref, f"上下文无关键词命中(kw={kws[:3]})"))

hard_fail = sum(1 for r in suspects if r[3].startswith("行号越界") or r[3].startswith("目标行全空"))
out = io.open(os.environ.get("ANCHOR_REPORT", os.devnull), "w", encoding="utf-8")
for rel, i, ref, why in suspects:
    if why.startswith("行号越界") or why.startswith("目标行全空"):
        print(f"❌ 确认腐烂  {rel}:{i}  {ref}  —— {why}")
    else:
        print(f"⚠️  软嫌疑（人工复核）  {rel}:{i}  {ref}  —— {why}")
    out.write(rel + ":" + str(i) + "\t" + ref + "\t" + why + "\n")
print(f"=== 锚点复核：断言 {stat['total']} 条 ｜ 硬校验通过 {stat['hard_ok']} ｜ 软命中 {stat['soft_ok']} ｜ 软跳过 {stat['soft_skip']} ｜ 确认腐烂 {hard_fail} ｜ 软嫌疑 {stat['suspect']-hard_fail} ===")
print("（软嫌疑常见于中文断言×英文原文跨语言引用；人工查证属实后行尾加 <!-- anchor-ok --> 跳过）")
sys.exit(1 if hard_fail else 0)
PY
PY_STATUS=$?
[ $PY_STATUS -ne 0 ] && FAIL=1
echo "=== 结论：$([ $FAIL -eq 0 ] && echo 全部通过 ✅ || echo 有腐烂嫌疑 ❌（人工复核上方清单）) ==="
exit $FAIL
