"""AI Landing Consultant · Hermes 插件薄壳。

把仓库 skills-tap/ 下的 11 道工序 SKILL.md 注册为
`ai-landing-consultant:<skill>` 命名空间的技能。
结构与机制参照 obra/superpowers（MIT）；本文件为原创实现。
技能本体在 skills-tap/sop-*/SKILL.md，是唯一事实源。
"""

from pathlib import Path

PLUGIN_ROOT = Path(__file__).resolve().parent
SKILLS_DIR = PLUGIN_ROOT.parent / "skills-tap"


def register(ctx):
    """按 Hermes 插件契约注册全部工序技能。"""
    if not SKILLS_DIR.is_dir():
        # 打包/安装形态差异导致目录缺失时不阻塞插件加载——技能本体仍可通过
        # skills tap 或手动复制使用（见 skills-tap/README.md）。
        return
    for skill_dir in sorted(SKILLS_DIR.iterdir()):
        skill_file = skill_dir / "SKILL.md"
        if skill_dir.is_dir() and skill_file.is_file():
            ctx.register_skill(skill_dir.name, skill_file)
