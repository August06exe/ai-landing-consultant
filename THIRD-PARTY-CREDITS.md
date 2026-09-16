# 第三方内容与致谢（Third-Party Notices）

本项目站在巨人的肩膀上。以下是仓库内引用/收录的第三方内容及各自的许可证。

| 内容 | 来源 | 许可证 | 本仓库中的位置 |
|---|---|---|---|
| **grill-me / grilling**（拷问式需求访谈法） | [mattpocock/skills](https://github.com/mattpocock/skills) | MIT | `01-顾问agent/skills/grill-me/`、`grilling/` |
| **awesome-hermes-skills 清单快照** | [ZeroPointRepo/awesome-hermes-skills](https://github.com/ZeroPointRepo/awesome-hermes-skills) | MIT | `02-知识库/03-参考技能/awesome-hermes-skills-README.md` |
| **byted-deepsearch SKILL.md**（深度调研参考） | [bytedance/agentkit-samples](https://github.com/bytedance/agentkit-samples) | Apache-2.0 | `02-知识库/03-参考技能/byted-deepsearch-SKILL.md` |
| **Hermes Agent**（目标平台） | [NousResearch/hermes-agent](https://github.com/NousResearch/hermes-agent) | MIT | 不直接分发；`scripts/fetch-hermes-docs.sh` 拉取官方文档供本地查询 |

## 未收录（许可证原因）

- **claude-deep-research-skill**（[199-biotechnologies](https://github.com/199-biotechnologies/claude-deep-research-skill)）：无许可证，**不随本仓库分发**。本仓库的 `deep-search` 技能不依赖它即可独立运行；本地装有该管线的用户可自行增强。

## 引用但未收录的灵感来源

- 官方可选技能目录中的 `setup-wizard-generator`（安装向导思想）、`one-three-one-rule`（1-3-1 决策简报格式）——思想已融入本项目的 SOP 与提示词，未复制代码。

> 收录内容版权归原作者所有；各条目 above 的许可证以原仓库为准。发现收录有误请提 Issue。
