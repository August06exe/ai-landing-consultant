# 第三方内容与致谢（Third-Party Notices）

本项目站在巨人的肩膀上。以下是仓库内引用/收录的第三方内容及各自的许可证。

| 内容 | 来源 | 许可证 | 本仓库中的位置 |
|---|---|---|---|
| **grill-me / grilling**（拷问式需求访谈法） | [mattpocock/skills](https://github.com/mattpocock/skills) | MIT | `01-顾问agent/skills/grill-me/`、`grilling/` |
| **awesome-hermes-skills 清单快照** | [ZeroPointRepo/awesome-hermes-skills](https://github.com/ZeroPointRepo/awesome-hermes-skills) | MIT | `02-知识库/03-参考技能/awesome-hermes-skills-README.md` |
| **byted-deepsearch SKILL.md**（深度调研参考） | [bytedance/agentkit-samples](https://github.com/bytedance/agentkit-samples) | Apache-2.0 | `02-知识库/03-参考技能/byted-deepsearch-SKILL.md` |
| **Hermes Agent**（目标平台） | [NousResearch/hermes-agent](https://github.com/NousResearch/hermes-agent) | MIT | 不直接分发；`scripts/fetch-hermes-docs.sh` 拉取官方文档供本地查询 |

## 思想与结构借鉴（2026-09-16 夜航调研新增，均未复制代码/内容）

| 借鉴了什么 | 来源 | 许可证 | 说明 |
|---|---|---|---|
| **superpowers 多宿主技能组织结构**（方法论技能化、强制工序写法、Hermes 插件安装形态） | [obra/superpowers](https://github.com/obra/superpowers) | MIT | 仅借鉴结构与思想；本仓库 03-SOP/ 的技能化打包方式受其启发（详见 `02-知识库/01-专题/09`） |
| **awesome-openclaw-usecases 用例条目格式**（场景/工作流/技能/坑 四段式） | [hesamsheikh/awesome-openclaw-usecases](https://github.com/hesamsheikh/awesome-openclaw-usecases) | MIT | 仅借鉴条目格式；案例库与配方库采用同构字段 |
| **awesome-openclaw-skills 技能清单分类法**（分类 TOC+安装命令+安全须知） | [VoltAgent/awesome-openclaw-skills](https://github.com/VoltAgent/awesome-openclaw-skills) | MIT | 仅借鉴清单结构 |
| **ai-agents-for-beginners 自动翻译工作流思想** | [microsoft/ai-agents-for-beginners](https://github.com/microsoft/ai-agents-for-beginners) | MIT | 仅借鉴 GitHub Action 多语言维护思路（Roadmap 英文全量化用） |
| **QwenPaw 安装文档完整度范式**（安装/升级/卸载/回滚闭环） | [agentscope-ai/QwenPaw](https://github.com/agentscope-ai/QwenPaw) | Apache-2.0 | 仅借鉴文档结构思想（c4 部署引导参照） |
| **12-factor-agents「短版前置」文体** | [humanlayer/12-factor-agents](https://github.com/humanlayer/12-factor-agents) | 代码 Apache-2.0 / 内容 CC BY-SA 4.0（正文不复制） | 仅借鉴文体 |
| **anything-llm 隐私透明化章节结构** | [Mintplex-Labs/anything-llm](https://github.com/Mintplex-Labs/anything-llm) | MIT | 仅借鉴「隐私设计」节的对外叙事结构 |
| **zeroclaw 数据主权口号写法** | [zeroclaw-labs/zeroclaw](https://github.com/zeroclaw-labs/zeroclaw) | Apache-2.0（README 称 MIT OR Apache-2.0） | 仅借鉴首屏主张写法；本项目口号为原创中文表述 |

## 未收录（许可证原因）

- **claude-deep-research-skill**（[199-biotechnologies](https://github.com/199-biotechnologies/claude-deep-research-skill)）：无许可证，**不随本仓库分发**。本仓库的 `deep-search` 技能不依赖它即可独立运行；本地装有该管线的用户可自行增强。

## 引用但未收录的灵感来源

- 官方可选技能目录中的 `setup-wizard-generator`（安装向导思想）、`one-three-one-rule`（1-3-1 决策简报格式）——思想已融入本项目的 SOP 与提示词，未复制代码。

> 收录内容版权归原作者所有；各条目 above 的许可证以原仓库为准。发现收录有误请提 Issue。
