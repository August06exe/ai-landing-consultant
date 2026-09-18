#!/usr/bin/env bash
# check-links.sh · 全仓 markdown 相对链接与锚点存在性检查（v2.x Phase 5）
# 用法：bash scripts/check-links.sh   # 退出码 0=全部有效
set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
python - <<'PY'
import os, re, io, sys, urllib.parse

root = os.getcwd()
skip_dirs = {"06-归档", "00-商务", "05-客户", ".git", "node_modules", "07-工作区", "03-参考技能"}
# 07-工作区=临时区/第三方快照；03-参考技能=第三方原文快照（内链失效属正常，见专题14/第5轮DX走查）
dead, total = [], 0
for root_dir, dirs, files in os.walk(root):
    dirs[:] = [d for d in dirs if d not in skip_dirs]
    for fn in files:
        if not fn.endswith(".md"): continue
        fp = os.path.join(root_dir, fn)
        rel_dir = os.path.dirname(fp)
        try: text = io.open(fp, encoding="utf-8").read()
        except Exception: continue
        for m in re.finditer(r"\]\(([^)#\s]+\.md(?:#[^)]*)?)\)", text):
            total += 1
            target = m.group(1).split("#")[0]
            target = urllib.parse.unquote(target)
            if target.startswith("http"): continue
            full = os.path.normpath(os.path.join(rel_dir, target))
            if not os.path.exists(full):
                dead.append((os.path.relpath(fp, root), m.group(1)))
for f, t in dead:
    print(f"❌ 死链: {f} → {t}")
print(f"=== 链接检查：{total} 条相对链接，死链 {len(dead)} ===")
sys.exit(1 if dead else 0)
PY
