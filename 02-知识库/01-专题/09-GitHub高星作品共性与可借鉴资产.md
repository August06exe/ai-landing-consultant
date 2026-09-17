# 09 · GitHub 高星作品共性与可借鉴资产

> 版本 1.0 ｜ 调研日期 2026-09-16 ｜ 收件人：老板/顾问 ｜ 性质：夜航调研产物（子代理 1B 起草，主会话查证落盘）
> 数据来源：GitHub REST API 匿名查询 + raw.githubusercontent.com README 原文抓取（当日实查，star 数为单日快照，引用请注明日期）
> 用途：README/Roadmap 更新依据 + Phase 5 自主延展的行动地图

## 主会话交叉审阅记录（2026-09-16）

- 抽查 awesome-openclaw-usecases：仓库存在、MIT、42 用例、usecases/ 目录按类索引——与报告一致。
- 与子代理 1A 交叉印证 hermes-agent star 数（24.6 万级）一致。
- 许可证判定采用保守原则：API 判 NOASSERTION/None/AGPL 的全部列入「不可借鉴」，仅作观察。

---

## 〇、三条自我质询（起草时记录）

1. **证据**：26 仓库 star/许可证来自 2026-09-16 当天 API 实际 JSON 响应（非记忆）；README 结论来自当日原文抓取。4 个仓库仅摘要级，已标注。
2. **反例**：「一键安装是高星标配」存在反例——n8n（20.4 万星）/dify（15.6 万星）靠可视化画布与模板市场立住，安装偏重。说明安装体验不是唯一立住路径，但对「给小白部署 agent」细分是刚需（n8n/dify 用户是开发者，我们的最终用户是完全不懂技术的真人）。
3. **推断**：「立住的关键」是从 README 自述+目录结构反推的归因；「README 无图=首屏弱」未经 A/B 验证；行动建议性价比排序是定性判断。

## 一、高星仓库速览（选摘，star 为 2026-09-16 值）

### A 组：个人 AI agent / 自托管助理（与我们交付物同类）

| 仓库 | Star | 许可证 | 定位 | 立住的关键 |
|---|---|---|---|---|
| [openclaw/openclaw](https://github.com/openclaw/openclaw) | 389,844 | **NOASSERTION**（README 徽章自称 MIT，存疑→内容不可借鉴） | 任何 OS、任何聊天渠道的个人 AI 助理 | 一行 npm 安装+自动 onboarding 向导+文档站按「目标」导航+ClawHub 技能注册表+基金会治理；**Security 节前置**（入站消息=不可信输入） |
| [NousResearch/hermes-agent](https://github.com/NousResearch/hermes-agent) | 246,086 | MIT（目标平台） | 自我进化的 AI agent | **curl 一键安装**（装齐 uv/Python/Node/ripgrep/ffmpeg/MinGit）+`hermes setup` 向导+`hermes doctor` 自检+`claw migrate` 迁移命令；**Troubleshooting 直接写在 README**（Windows Defender 误报精确到 PowerShell 命令） |
| [HKUDS/nanobot](https://github.com/HKUDS/nanobot) | 48,216 | MIT | 超轻量个人 agent 框架 | pip 安装+10 语言文档站+WebUI |
| [zhayujie/CowAgent](https://github.com/zhayujie/CowAgent) | 46,999 | MIT | 中文超级助理 | **中文市场打法范本**：微信群徽章+Demo 视频置顶+文档站+Enterprise Services 商业化节+Changelog |
| [agentscope-ai/QwenPaw](https://github.com/agentscope-ai/QwenPaw) | 35,032 | Apache-2.0 | 阿里 Qwen 系个人助理 | **7 种安装方式并列**（pip/脚本/Docker/云/桌面 App）+四语种 README+RELEASING.md 双语+e2e/ 测试 |
| [zeroclaw-labs/zeroclaw](https://github.com/zeroclaw-labs/zeroclaw) | 32,854 | Apache-2.0（README 称 MIT OR Apache-2.0 双许可） | Rust 极简 autonomous 助理 | 首屏口号即定位："You own the agent. You own the data. You own the machine it runs on."；防假冒声明 |
| [Mintplex-Labs/anything-llm](https://github.com/Mintplex-Labs/anything-llm) | 66,095 | MIT | 本地知识库+agent 桌面应用 | 一体化桌面安装；**Telemetry & Privacy 独立大节**（为什么收集/退订/逐条列出）——隐私透明化写法范本 |
| SillyTavern / khoj / AstrBot | 33,426 / 37,364 / 40,577 | 均 AGPL-3.0 | —— | **内容不可借鉴**；SillyTavern 的「人格卡字段化」思想可观察 |

### B 组：方法论 / 技能框架 / 教育型（与我们「SOP+技能+知识库」同类）

| 仓库 | Star | 许可证 | 定位 | 立住的关键 |
|---|---|---|---|---|
| [obra/superpowers](https://github.com/obra/superpowers) | 287,515 | MIT | 「给编码 agent 的完整软件开发方法论」 | **方法论技能化最高范本**：16+ 宿主适配安装（含 `.hermes-plugin/`），`hermes plugins install obra/superpowers --enable` 一条命令；skills/+hooks/+evals/+tests/ 完整工程化；README 内置 Commercial Services 节（开源方法论+收费服务双轨）；**"Mandatory workflows, not suggestions"**——与本项目 11 道 SOP 完全同构，证明「方法论即产品」可撑 28.7 万星 |
| [humanlayer/12-factor-agents](https://github.com/humanlayer/12-factor-agents) | 25,882 | 代码 Apache-2.0 / **内容 CC BY-SA 4.0（正文不可复制）** | 构建可靠 LLM 应用的 12 原则 | **「短版前置」文体**：一屏可截图的短版放最前 |
| [microsoft/ai-agents-for-beginners](https://github.com/microsoft/ai-agents-for-beginners) | 74,871 | MIT | 18 课入门课程 | **GitHub Action 自动翻译多语言**（"Automated & Always Up-to-Date"）；每课结构统一（视频/讲义/代码/练习） |
| [dair-ai/Prompt-Engineering-Guide](https://github.com/dair-ai/Prompt-Engineering-Guide) | 78,374 | MIT | 提示词工程指南 | 内容型+配套网站 |
| [titanwings/distilly](https://github.com/titanwings/distilly) | 24,789 | MIT | 「把工作方式蒸馏成可复用技能」 | 概念即品牌；与我们「把顾问经验沉淀为 SOP/技能」同构 |

### C 组：工作流自动化 / 生态（竞品与参照）

| 仓库 | Star | 许可证 | 定位 | 立住的关键 |
|---|---|---|---|---|
| [n8n-io/n8n](https://github.com/n8n-io/n8n) | 204,560 | **NOASSERTION（fair-code，非 OSI 开源）→内容不可借鉴** | 可视化工作流平台 | **9,000+ workflow 模板市场**是增长引擎；**73 行极限 README**：定位→截图→六条加粗要点→Quick Start |
| [langgenius/dify](https://github.com/langgenius/dify) | 155,954 | NOASSERTION（Apache-2.0 附加条件）→不可借鉴 | agentic workflow/RAG 平台 | 云+自托管双轨；Star History 图+贡献者墙 |
| [VoltAgent/awesome-openclaw-skills](https://github.com/VoltAgent/awesome-openclaw-skills) | 52,607 | MIT | 5,300+ 社区技能策展清单 | 数量徽章+分类 TOC+按安装方式分节+Security Notice 前置+配套网站 |
| [hesamsheikh/awesome-openclaw-usecases](https://github.com/hesamsheikh/awesome-openclaw-usecases) | 31,674 | MIT ✅主会话已核 | 42 个真实用例集合 | **「卖用法不卖功能」**：定位句——"Not ~~skills~~, but finding **ways it can improve your life**"（适配瓶颈不是技能，是发现它能改善你生活的方式）；六场景分类；Warning 节提示第三方技能风险 |
| [ZeroPointRepo/awesome-hermes-skills](https://github.com/ZeroPointRepo/awesome-hermes-skills) | 546 | MIT（已收录快照） | Hermes 生态 368+ 技能目录 | "Where Do I Start?" 三步路径+Featured Skill 置顶+Editor's Picks 策展层 |

> 备查（API 实查未入主表）：openai/swarm（MIT）、browser-use（MIT）、mem0（Apache-2.0）、MetaGPT（MIT）、crewAI（MIT）、firecrawl（AGPL 不可借鉴）、openclaw/clawhub（MIT，9,428 星）等。

## 二、共性提炼：8 条铁律 + 2 条反例

1. **安装命令必须在 README 第一屏，且「装完之后干什么」比安装本身更重要**。共同动线：【安装→向导→自检（doctor）→第一句话】；对非技术用户的妥协=把「装什么依赖」全藏进安装器（hermes 连 MinGit 都替你下载）。
2. **Troubleshooting 前置进 README，不藏进 FAQ**。hermes 用整节写杀软误报处理——这是从真实 issue 长出来的；小白流失点不在安装命令，在安装后的第一道墙。
3. **方法论做成「强制技能序列」，不是「参考文档」**。superpowers："Mandatory workflows, not suggestions. The agent checks for relevant skills before any task."——与 11 道 SOP 同构；且示范多宿主适配层。
4. **模板/用例库是增长的第二曲线**。n8n 数模板当卖点；awesome-openclaw-usecases 定位句最值得抄——技能清单解决「能干什么」（供给侧），用例清单解决「跟我有什么关系」（需求侧），**非技术用户只需要后者**。
5. **安全与隐私声明是标配节，不是附录**。openclaw Security 前置；anything-llm 遥测透明化大节。我们有隐私设计但 README 一眼看不到——**藏着卖的卖点不是卖点**。
6. **多语言是工程问题不是翻译问题**。GitHub Action 自动翻译才能 "Always Up-to-date"；中文优先项目反向操作（中文内核+英文 README+微信徽章）同样成立。
7. **文档站承接 README，README 只留「三分钟动线」**。n8n 73 行是极限样本；openclaw 文档节是「目标→入口」表（按用户意图导航，不按模块目录）。
8. **社会证明工具化**。trendshift 徽章、Star History、贡献者墙；zeroclaw/openclaw 的防假冒声明是头部项目新标配。

**反例 1**：重安装 ≠ 高星（n8n/dify）——对开发者工具画布价值>安装摩擦；对非技术最终用户安装摩擦是生死线。**反例 2**：长 README ≠ 差（nanobot 777 行照样高星）——前提是 TOC+分节导航+每节自带结论；无动线才是问题。

## 三、可借鉴资产清单（仅 MIT/Apache-2.0）

| # | 仓库（许可证） | 借鉴什么 | 怎么本地化 |
|---|---|---|---|
| 1 | **obra/superpowers**（MIT） | ①多宿主适配层结构（含 `.hermes-plugin/`）；②README 把技能串成强制工序的写法；③一条命令安装方法论；④"What's Inside" 按类目一句话列技能 | 把 11 道 SOP 打包成 Hermes 插件/技能组；README 加「11 道工序」表格（每道=激活时机+产出物）；仅借鉴结构不复制代码 |
| 2 | **hermes-agent**（MIT，目标平台） | ①Quick Install→After installation→Troubleshooting 动线；②`hermes doctor` 自检思路；③迁移章节结构；④「跳过 API key 收集」痛点节 | KB02 补「安装器已知墙位表」（杀软/Defender/MinGit）；c4 直接引用；验收脚本输出对齐 doctor 风格（逐项 OK/FAIL） |
| 3 | **awesome-openclaw-usecases**（MIT）✅已核 | 用例条目格式：场景一句话+工作流构成+所需技能+预期产出（+踩坑）；42 例按生活领域分类 | 建「行业用例矩阵」：每条=「老板的一句话需求→每日工作流清单→用到的技能/渠道→首月 ROI 观察」；拉面店老王改写成首条 |
| 4 | **awesome-openclaw-skills**（MIT） | 技能分类清单结构（分类 TOC+每条=名称/一句话/安装命令）+动机节+安全须知前置 | 配装清单每条附 `hermes skills install` 命令；按客户行业分组；加第三方技能安全须知节 |
| 5 | **awesome-hermes-skills**（MIT） | "Where Do I Start?" 三步上手叙事+"Featured" 置顶 | README 快速开始 A 路径补「第一小时能看到的成果」；示例案例顶部加导语 |
| 6 | **ai-agents-for-beginners**（MIT） | GitHub Action 自动翻译；课程式「每课包含」统一结构 | 英文文档用 Action 维护；每道 SOP 头部统一「输入/动作/产出/验收」四件套 |
| 7 | **QwenPaw**（Apache-2.0） | ①安装文档完整度：每种方式带「升级=重跑安装器/卸载」；②双语 README 平级；③RELEASING.md；④e2e/ 意识 | c4 补「升级/卸载/回滚」三段（Windows 语境：卸载=删目录+删计划任务）；中文保持正宫 |
| 8 | **zeroclaw**（Apache-2.0） | 首屏一句话主权主张；防假冒节 | 中文口号候选：「客户的数据只住在客户电脑里——开源的是产线，不是客户档案。」放 README 首屏 |
| 9 | **anything-llm**（MIT） | Telemetry & Privacy 独立章节结构 | README 加「隐私设计」短节（三条：真实客户数据不入库/CI 强制拦截/外连仅限官方文档源） |
| 10 | **12-factor-agents**（代码 Apache-2.0，内容 CC BY-SA 不复制） | 「短版前置」文体 | 服务标准.md 加「一屏版」：三层服务包+SLA+超纲三档各一行放头部 |

### THIRD-PARTY-CREDITS.md 建议追加条目（按现有格式）

```
| **superpowers 多宿主技能组织结构**（方法论技能化、强制工序写法、Hermes 插件安装形态） | [obra/superpowers](https://github.com/obra/superpowers) | MIT | 仅借鉴结构与思想，未复制代码；本仓库 03-SOP/ 的技能化打包方式受其启发 |
| **awesome-openclaw-usecases 用例条目格式**（场景/工作流/技能/坑 四段式） | [hesamsheikh/awesome-openclaw-usecases](https://github.com/hesamsheikh/awesome-openclaw-usecases) | MIT | 仅借鉴条目格式；行业用例矩阵采用同构字段 |
| **awesome-openclaw-skills 技能清单分类法**（分类 TOC+安装命令+安全须知） | [VoltAgent/awesome-openclaw-skills](https://github.com/VoltAgent/awesome-openclaw-skills) | MIT | 仅借鉴清单结构 |
| **ai-agents-for-beginners 自动翻译工作流思想** | [microsoft/ai-agents-for-beginners](https://github.com/microsoft/ai-agents-for-beginners) | MIT | 仅借鉴 GitHub Action 多语言维护思路 |
| **QwenPaw 安装文档完整度范式**（安装/升级/卸载/回滚闭环） | [agentscope-ai/QwenPaw](https://github.com/agentscope-ai/QwenPaw) | Apache-2.0 | 仅借鉴文档结构思想 |
| **12-factor-agents「短版前置」文体** | [humanlayer/12-factor-agents](https://github.com/humanlayer/12-factor-agents) | 代码 Apache-2.0 / 内容 CC BY-SA 4.0（正文不复制） | 仅借鉴文体 |
```

**明确不可借鉴（记录在案防止误抄）**：openclaw（NOASSERTION 与徽章 MIT 矛盾→保守处理）、n8n（fair-code）、dify（附加条件）、activepieces（NOASSERTION）、SillyTavern/khoj/AstrBot/firecrawl（AGPL-3.0）、awesome-claude-skills（无许可证）。

## 四、硬核对照表：我们已有 vs 缺失 vs 该抄

| 维度 | 头部做法 | 我们现状 | 缺口 | 该抄谁 |
|---|---|---|---|---|
| **AGENTS.md** | hermes/openclaw/superpowers/QwenPaw 仓库根全员标配 | 无 | **缺失（P0，成本最低收益最高）** | 自写一页：仓库地图+红线（05/06/00 禁读）+常用入口 |
| 安装体验 | 一键脚本+装完自检；升降级卸载闭环 | c4 SOP+验收脚本；一键向导在 Roadmap | **缺失（P0）** | hermes（宿主本体）+QwenPaw 结构 |
| README 首屏 | banner 图+多语言徽章；n8n 三屏内讲完动线 | 有徽章+mermaid 图，**无 banner/截图**，147 行偏长 | **半缺失（P0）** | n8n 首屏结构（观察）+hermes 徽章法 |
| 隐私/安全叙事 | Security 节前置；遥测透明化大节 | 隐私写进 README 一行+SECURITY.md | **半缺失（P1）：主张已有，缺「节级露出」** | anything-llm 章节结构 |
| 模板库 | n8n 9,000+ 模板市场 | 全套交付包模板已有，**未按行业预填** | **半缺失（P1）：不缺模板，缺预填模板** | awesome-openclaw-usecases 条目格式 |
| 案例库 | 42 例用例集 | 拉面店老王 1 例 | **半缺失（P1）：格式可立即扩矩阵** | awesome-openclaw-usecases |
| CHANGELOG | superpowers RELEASE-NOTES 单文件 | 无 | **缺失（P1）** | superpowers 模式起步即可 |
| 测试与 CI | openclaw qa/；superpowers evals/；QwenPaw e2e/ | 隐私门卫 CI 已有；无内容质量 CI | **半缺失（P1）**：加模板结构 lint+链接检查 | superpowers 评测思想 |
| 文档站 | 全员独立 docs 站按「目标」导航 | 无；7 专题 md 交付 | **缺失（P2）** | mkdocs-material 自建+目标式导航思想 |
| 人格库 | SillyTavern 角色卡生态（AGPL 不可抄） | SOUL.md 模板 1 份 | **缺失（P2）**：按行业×语气做预设 | 基于 hermes SOUL.md（MIT）自建 |
| 技能市场 | 5,300+ 清单+网站；ClawHub 注册表 | 配装清单；无市场 | **半缺失（P2）：先做策展清单** | VoltAgent 结构 |
| 社区运营 | 微信群/钉钉群徽章；Discord | 案例投稿 Issue 模板；无社群 | **缺失（P2）** | CowAgent 中文社群徽章打法 |
| 可视化 | Control UI；画布；桌面 App | 无 | 缺失但**优先级最低**——我们交付给 agent 自装配，不需要 UI | 不抄，守住「指令集」范式 |
| 英文文档 | GitHub Action 自动翻译 | README.en.md 骨架 | **半缺失（P3）** | ai-agents-for-beginners 思路 |

## 五、行动建议（按性价比排序，喂给 Phase 5）

1. **【半天】仓库根加 AGENTS.md**：仓库地图、隐私红线、三个快速开始入口、SOP 索引——任何 agent 一进仓库就「上线即用」。
2. **【半天】README 首屏改造**：banner+三条加粗要点+主权口号+隐私设计小节。
3. **【1 天】11 道工序打包成 Hermes 插件/技能组**：参照 superpowers `.hermes-plugin/` 形态——进入 Hermes 生态分发渠道的门票。
4. **【1-2 天】行业用例矩阵启动**：四段式条目，老王拆首条+预填 5 行业；投稿 Issue 模板字段同步。
5. **【1 天】一键部署脚本 v0**：装完自动跑验收脚本逐项 OK/FAIL；文档补「升级/卸载/回滚」三段。
6. **【半天】CHANGELOG.md 起步**：单文件，用户视角写。
7. **【半天】内容质量 CI**：模板八件套结构 lint+链接有效性检查，与隐私门卫并列。
8. **【1 天】配装清单升级为标准策展格式**：分类 TOC+install 命令+安全须知。
9. **【1 天】SOUL.md 人格预设库 v0**：行业×语气 10 个预设，c3 引用。
10. **【P3 缓做】文档站与英文全量化**：等案例库 10+ 条再做，避免空转。

## 六、卡点与局限性

1. open-interpreter 原仓库失联（API 301、搜索无原仓）——按「3 次失败换下一个」记录，不再重试。
2. openclaw 许可证矛盾（API NOASSERTION vs 徽章 MIT）——保守处理为内容不可借鉴；如需可人工下载 LICENSE 核对。
3. 11 个仓库仅摘要级证据（已标注），其「README 亮点」栏不适用。
4. star 数为 2026-09-16 单日快照；hermes/superpowers 处于快速增长期，引用注明日期。
5. 「立住的关键」为 README 自述+结构反推，因果强度有限。

> 变更记录：v1.0 2026-09-16 夜航首次产出（子代理 1B 起草，主会话抽查后落盘）。
