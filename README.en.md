<div align="center">

# 🎯 ai-landing-consultant

**A consultant-in-a-box that deploys a dedicated AI agent for a specific user — and ships their first *actually-used* workflow.**

The full methodology of a seasoned deployment consultant, made executable by an agent:
prompt + skills + knowledge base + 11 standard operating procedures.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform: Hermes Agent](https://img.shields.io/badge/当前平台-Hermes%20Agent-blueviolet)](https://github.com/NousResearch/hermes-agent)
[![Methodology: platform-agnostic](https://img.shields.io/badge/方法论-平台无关-informational)](#)

[中文文档](README.md)

</div>

---

## What is this

Not another agent framework — it's the **deployment consultant role itself, packaged**. Self-hosted AI agents are toys for hackers and hieroglyphics for everyone else. This repo turns what a consultant does — intake interviews, solution design, delivery packaging, deployment, verification, follow-up & evolution — into 11 standard procedures that any CLI agent can execute.

The result: for one specific, non-technical user (say, a restaurant owner), deliver an agent that is **theirs** — personality tuned to their business, connected to the chat apps they already use, running several automated workflows daily, and **self-improving inside guardrails**.

> The methodology is platform-agnostic. The current implementation targets [Hermes Agent](https://github.com/NousResearch/hermes-agent) (self-hosted, self-improving skills, native WeChat/Feishu/DingTalk support). PRs to adapt other platforms are welcome.

## Core idea: delivery package = self-assembly kit

Deploy only until "agent is alive + first model connected", then throw the **delivery package** at the blank agent — *it assembles itself into the client's dedicated assistant*: writes its SOUL.md, installs skills, builds workflows, sets up scheduled tasks, then files a completion report. A shipped **Evolution Charter** keeps its future self-improvement inside guardrails.

## What's inside

- **`01-顾问agent/`** — consultant prompt (evidence-driven, ROI-aware, 1-3-1 escalation) + skills: grilling interviews, deep-search, web-crawler
- **`02-知识库/`** — localized deployment knowledge: channel comparison & selection (incl. WeChat iLink pitfalls), Windows deployment, China-accessible model providers, ops triage tables
- **`03-SOP/`** — 11 procedures: delivery line c1–c6 + follow-up line d1–d5
- **`04-运营/`** — service standards, quote & pipeline templates: run this as an actual business if you like

## Quick start

**End user:** give this repo to a computer-savvy friend or any CLI agent; they'll start with the intake questionnaire (`03-SOP/c1-需求调研.md`).
**Aspiring consultant:** read `04-运营/服务标准.md`, wake your agent with `04-运营/启动指令.md`, run your first (free) engagement.
**Knowledge seeker:** read `02-知识库/01-专题/` and/or `bash scripts/fetch-hermes-docs.sh`.

## License & credits

MIT. Built on [Hermes Agent](https://github.com/NousResearch/hermes-agent) (MIT), [mattpocock/skills](https://github.com/mattpocock/skills) (MIT), [awesome-hermes-skills](https://github.com/ZeroPointRepo/awesome-hermes-skills) (MIT), [bytedance/agentkit-samples](https://github.com/bytedance/agentkit-samples) (Apache-2.0). See [THIRD-PARTY-CREDITS.md](THIRD-PARTY-CREDITS.md). Docs are Chinese-first; English i18n is on the roadmap — PRs welcome.
