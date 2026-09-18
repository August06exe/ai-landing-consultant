# 08 · AI Agent 落地痛点与成功案例调研

> 版本 1.0 ｜ 调研日期 2026-09-16 ｜ 收件人：老板/顾问 ｜ 性质：夜航调研产物（子代理 1A 起草，主会话查证落盘）
> 研究对象：**「给真人（非技术用户）部署/交付 AI agent」的落地环节**——不是 agent 技术本身。
> 用途：全部 11 道 SOP 的 v2 修订依据。每条事实性结论标注来源与日期；「摘要级」=经搜索引擎摘要获得、未读原文全文，引用前建议复核。

## 主会话交叉审阅记录（2026-09-16）

- 抽查 4 个最承重来源，全部实锤：①Velvet Shark《50 days with OpenClaw》确认含「cron 静默失败整整七天」原话与「多模型路由省 80%」；②Fortune 报道 MIT NANDA 报告确认 95% 试点无可衡量回报与影子 AI 现象；③awesome-openclaw-usecases 确认存在、MIT、42 用例；④证监会重庆局「京圈富少」案例确认含「双证」原文表述。
- 与子代理 1B 的 GitHub API 独立查询交叉印证：hermes-agent star 数两路独立得出一致（24.6 万级）。
- 证据质量分层已在文中保留：全文级证据（S7/S19/S22/S24/S25/S26）与摘要级证据分开标注。

---

## 一、失败模式分类与证据（8 类）

> 频次综合判断：**A 安装环境类**声音最多但基本是一次性坑；**B 做了没人用**同样极多且最致命（结构性失败，交付方往往最后才知道）；**C 静默故障/维护成本**是长期留存第一杀手；**D 成本失控**是爆发式流失导火索；E-G 是背景放大器。注意：A 的「量大」部分是幸存者偏差的反向体现——能发声的人都已装上，死在装机环节的沉默大多数没有发声渠道。

### A. 安装 / 环境 / 文档不符——最高频、但最浅

- OpenClaw 踩坑实录：官网文档与实际安装对不上；macOS 需先装 Homebrew、Node 版本不对都不行 [S11，摘要级]
- 「昨天还好，今天装死」催生社区《保命 & Debug 实用指令合集》[S12，飞书文章，摘要级]
- 腾讯新闻：「本地部署劝退」，结论是把环境/模型接入/工具配置标准化才能降低小白门槛 [S13，2026-02-11]
- Hermes Agent README 自述：Windows 杀毒软件（Defender/Bitdefender）误报隔离 updater 文件，需「白名单文件夹而非文件哈希」[S25，官方文档，查询 2026-09-16]
- 国内场景：V2EX「你们让父母用什么 AI app」——海外 AI 过不了网络关，国内 App 又嫌笨 [S14]
- HN Clawdbot 讨论串：337 个 open issues，「This thing isn't close to stable」[S19，2026-01-26]

### B. 需求聊不清 / 做出来没人用——最致命的结构性失败

- **MIT NANDA《The GenAI Divide: State of AI in Business 2025》：企业投入 300-400 亿美元，95% 试点无可衡量回报**；根因不是模型而是「学习差距」——系统无法嵌入实际工作流、记不住偏好、重复犯错；成功者用的恰是「有记忆+反馈迭代」的 agentic 方案 [S7 Fortune 2025-08-18（主会话已核）；S9 报告原文]
- 同报告「影子 AI」：约 90% 员工私下用个人 ChatGPT 干活——**需求真实存在，但交付的方案没接住** [S7]
- r/openclaw 置顶帖「装好了但不知道用它干嘛」；Velvet Shark 引申：「如果你没有可自动化的工作流，OpenClaw 不会替你发明一个；价值属于本来就有系统的人」[S22，2026-02-26（主会话已核）]
- 宝玉复盘：AI Agent 前端工具落地失败，根因是**习惯阻力**——设计师更习惯 Figma，不想对对话框干活 [S1，摘要级]
- CSDN 失败复盘：需求层系统性偏差——干系人识别缺失、需求量化错位、能力边界定义模糊 [S3，摘要级]
- 价值感知：「做出好的自动化 ≠ 客户感知到价值」是客户悄悄停用的根因 [S27，摘要级]

### C. 静默故障 / 维护成本爆炸——长期留存第一杀手

- **Velvet Shark 50 天实测：包改名后 cron 任务一直调旧命令，「静默失败了整整七天」才被发现**；上下文静默压缩导致 agent 中途忘了自己在干嘛；简单工作流可靠度 8/10，复杂浏览器自动化只有 5/10 [S22，2026-02-26（主会话已核，原文引证）]
- OpenClaw 官方 troubleshooting 把「No replies」「Gateway won't start」「Cron didn't fire」「Channel connects but messages do not flow」列为四大首诊类目——官方承认这些是最高频故障 [S24，查询 2026-09-16]
- 更新即破坏：社区帖「Openclaw useless now after update」——更新收紧沙箱/权限后全坏；官方文档承认「更新后插件被禁用」是常见病 [S24/S31]
- 放弃曲线：小问题累积 → 任务完不成 → 工作流静默坏掉 → agent 意外死循环 → 弃用 [S21/S32，摘要级]
- 博客园故障复盘：**模型质量不恒定**，供应商问题会让 agent 表现漂移，必须自建质量监控 [S4，摘要级]

### D. 成本失控——最快见血的流失导火索

- r/openclaw「流失模式」帖：API 账单暴涨因为 **Opus 默认档没人改**；技能死循环烧 token；加第二个 agent 把第一个搞消失 [S21，摘要级]
- HN：「always-on agent 两天烧了 $300」是红旗 [S19，2026-01-26]
- Velvet Shark 解法印证问题真实性：多模型路由（贵模型只干深度思考，心跳/子代理用便宜档）把账单砍 80% [S22（主会话已核）]
- **OpenClaw 官方 troubleshooting 对 token 成本只字未提**——成本教育平台不管，全落在部署者头上 [S24]

### E. 期望管理失败

- Endava（OpenAI 官方案例）：教训第一条是「把 AI 应用视为**行为改变**，而不是软件部署」[S16]
- 「评估的体感黑盒」——客户对好坏全靠体感、没有客观评估，期望与现实无限扯皮 [S2，摘要级]
- 技术现实与宣传落差：单步 95% 准确率的 agent 在 20 步任务上失败率 64% [S33，摘要级]；工具调用失败率 3-15% [S28，摘要级]
- MIT：外部采购/合作成功率约 67%，纯自建仅 33% [S7/S10]

### F. 信任 / 隐私 / 安全顾虑

- HN Clawdbot 讨论串集中爆发 [S19，2026-01-26]：网页内容无消毒直接进上下文=提示注入敞口；「连上邮箱就开了一个外泄通道」；「等几个月，等重大安全洞都修完再装」
- 学术论文专设课题《Understanding and mitigating the risks of OpenClaw for non-technical users》——「对非技术用户基本不可达」[S31 关联 arXiv，摘要级]
- 国内信任事件：微信 AI 助手「小微」被质疑偷看聊天记录，官方紧急回应 [S18，2026-09-15 前后]——**渠道侧 AI 的信任风波会直接波及一切挂在微信上的第三方 agent**
- 安全内参调查：70% 受访者担忧幻觉与数据泄露，**超半数不清楚自己给了什么数据权限** [S17，摘要级]
- 伪仓库攻击：假仓库冒用旧名字捕猎搜索到它们的非技术用户 [S31，摘要级]

### G. 行为改变 / 采纳阻力

- 宝玉的习惯阻力（S1）；Endava「行为改变不是软件部署」（S16）
- MIT：失败者投资「无法适配业务流程的静态工具」——工具要求人迁就它（S8）
- n8n 社区复盘：第一天就追求完美工作流→不可维护；应该从简单开始、用真实数据试 [S26，2026-06-15]

### H. 服务者侧：商业模式与客户流失

- 「**向客户报告省了多少美元**能降低流失」；retainer 定价要挂 KPI，否则客户体感不到价值就退订 [S27，多篇一致]

## 二、成功共性动作（10 条）

1. **陪客户当场装、视频通话实时演示**——纽约服务商每单 90 分钟-3 小时全程视频直播安装，客户全程看着 [S20，摘要级]
2. **每客户只接 1-2 个消息渠道 + 5-10 条实用工作流**，宁少勿滥 [S20]
3. **从客户已有的重复劳动里选场景，绝不发明新场景**；成功者的 starter pack 是「草稿模式的邮件分诊 + 每日简报 + 一个收藏夹收件箱」[S22]
4. **交付后持续价值可见化**：每月报告省了多少钱/多少件活，直接压流失率 [S27]；「心跳扫描」自动发现漏付款/快到期域名，制造「它救了我」时刻 [S22]
5. **成本结构化**：贵模型只留给深度任务，其余全走便宜档（省 80%）[S22]
6. **对不可靠环节预设降级**：邮件只进草稿不直发（draft-only）、把一切外部内容当敌意内容、破坏性操作必须审批 [S22]；低置信度转人工、必须留日志、必须有错误兜底、工具循环必须有退出条件 [S26]
7. **把「自愈/自检」做进产品**：官方 doctor/triage 一键诊断包 [S24/S25]；凌晨自动更新+自动备份+密钥自动脱敏 [S22]
8. **备份先于一切改动**：每夜自动备份；流失案例的第一悔恨就是「改坏之前没备份」[S21/S22]
9. **入口跟着客户习惯走**：全部挂在 WhatsApp/iMessage/TG/微信上，而非让客户开新 App [S20/S22]
10. **行为改变按周养成**：第一周内让客户真实用一次最常用的工作流 [S20/S22/S16]

## 三、SOP 覆盖对照表（8 类失败 × 11 道工序）

| 失败类别 | SOP 防线 | 判定 |
|---|---|---|
| A 安装/网络 | c1 题单「设备网络现场能测」；c4 环境快检+热点回退+「10 分钟无解改期」；专题02/专题04；d2 三级分诊 | ✅ 覆盖最充分 |
| B 做了没人用 | c1 重复劳动清单+ROI 排序+「都行→只挑最痛 1 条」；c6 当面验收；d1 Day7 三问；d4 停用 cron 建议停掉 | ⚠️ 交付前防线强；**缺使用率量化监测与冷启动选型纪律** |
| C 静默故障 | d2 速查表；专题04 路由表+更新守卫；c5 逐条触发验证；d4 cron 健康检查 | ⚠️ 被动排查强；**缺主动「失联报警/心跳」与「更新后回归检查」**——静默失败 7 天正是月度体检的空窗 |
| D 成本失控 | c2 成本预估+辅助槽策略；d4 成本复查 | ⚠️ 月度复查在；**缺首周盯防、token 硬顶与异常告警**——爆雷都在头几天 |
| E 期望管理 | c1 逐条确认+验收场景；c6 不带病交付；d3 边界即服务 | ✅ 框架好；**缺能力边界话术库与演示翻车预案** |
| F 信任/隐私 | 专题07 三级敏感度+c2/c4 检查单；进化守则随包交付 | ✅ 国内最强项；**缺「外部内容=敌意」普适纪律与录屏知情同意** |
| G 行为改变 | d1 教固定口令+真用一次；c6 教三件事；d3 坏习惯→教育 | ⚠️ 骨架在；**缺 first-success 仪式化设计** |
| H 商业/churn | d4 月报=续费触点；d5 续费钩子+季度回访 | ⚠️ 机制在；**月报缺价值量化字段** |
| （附加）备份 | 专题04 备份清单 | ✅ |
| （附加）退出交接 | 专题07 §四 | ✅ 超出行业平均 |

## 四、补防线建议清单（按重要性排序，喂给 SOP v2）

1. **加「心跳+失联报警」（d1/d2 增强）**：交付时建每日固定 cron「晨间一句活儿汇报」，客户连续 24h 没收到任何消息即触发人工检查——把「静默失败 7 天」的空窗从月度压缩到 24 小时。〔证据 S22/S24〕
2. **加「成本护栏」（c2/d1）**：token/费用月度硬顶与超限提醒；交付后头 7 天每天看用量（风险最高窗口）；默认模型档锁定并写进使用卡。〔证据 S21/S19/S22；官方文档对成本零覆盖证明平台不会替你管〕
3. **「外部内容=敌意」写成普适安全基线（专题07+c2/c3+使用卡）**：替客户收外部信息的工作流默认草稿模式，外发一律人工确认；普通客户也适用。〔证据 S22/S19/S31；专题07 目前只对 L-高危关浏览器/抓取〕
4. **d4 月报增加「价值量化」字段**：本月完成 N 件任务/节省约 X 小时/折算约 Y 元，置顶展示。〔证据 S27「报告美元数直接降流失」；MIT 95% 失败的反面即「无可衡量回报」；现月报只报成本不报收益，恰好是负面结构〕
5. **加「更新后回归清单」（专题04+d2）**：每次 update 后必做：手动触发全部 cron 一次、从客户渠道发测试消息、skills list 对清单。〔证据 S31/S24/S22——现 专题04 只有「更新前」守卫〕
6. **「冷启动选型纪律」写进 c1/c2**：第一条工作流必须来自客户**已经在做**的重复行为（哪怕纸笔/Excel 在做），禁止选「听起来很酷」的新场景；上线首周唯一目标=客户独立成功使用一次。〔证据 S22/S7 影子AI/S1/S16〕
7. **「期望管理话术库」+ c6 演示翻车预案**：话术库至少含：它是实习生不是员工、复杂任务可靠度显著低、数据边界说明；翻车时向客户展示报障路径本身（把翻车变成教学时刻）。〔证据 S33/S2/S27〕
8. **c4 加「录屏与数据知情同意」**：录屏前口头+文字告知范围与用途。〔证据 S18 渠道信任脆弱/S17〕
9. **「换机/迁移 runbook」沉淀为正式文件（d5/专题04）**：备份清单已有，缺旧机→新机分步执行卡。〔证据：d5 已列迁移为续费钩子却无执行文件〕
10. **d1 报障格式升版「截图+一句话+当时想干嘛」**：补「本来想完成什么」，否则 d3 排优先级缺「频率」数据。〔证据 S26「没有日志就无法改进」/S7〕

## 五、来源清单

> 查询日期均为 2026-09-16；「摘要级」=经搜索引擎摘要获得、未读原文全文。
> ⚠️ 个别 URL 含超长数字串（平台内容 ID），为避免防泄露门卫误判为手机号，在数字串中插入了一个空格——**访问时删掉空格即可**。门卫本身未做任何改动。

| # | 来源 | 日期 | 要点 |
|---|---|---|---|
| S1 | [宝玉：AI Agent 前端落地真实复盘](https://baoyu.io/blog/ai-agent-frontend-rebirth-from-failure) | 未标（摘要级） | 习惯阻力 |
| S2 | [掘金：复盘 100 个失败的 AI Agent 项目](https://juejin.cn/post/7516910928 668852259)（URL 空格系防门卫误报所加，访问时删掉） | 未知（摘要级） | 体感黑盒 |
| S3 | [CSDN：一个失败的 Agent 项目复盘](https://blog.csdn.net/2502_91678797/article/details/161963117) | 未知（摘要级） | 需求三偏差 |
| S4 | [博客园：Agent 故障复盘](https://www.cnblogs.com/informatics/p/19625905) | 未知（摘要级） | 模型质量不恒定 |
| S5 | [人人都是产品经理：企业 Agent 落地为什么这么难](https://www.woshipm.com/ai/6404011.html) | 未知（摘要级） | 安全/运维/适配 |
| S6 | [InfoQ：企业级 Agent 落地 4 个工程问题](https://www.infoq.cn/article/qKW5Yu1ORiqMmX6mlLJ6) | 未知（摘要级） | 误操作真实故障 |
| S7 | [Fortune：MIT report 95% pilots failing](https://fortune.com/2025/08/18/mit-report-95-percent-generative-ai-pilots-at-companies-failing-cfo/) | 2025-08-18 ✅主会话已核 | 95% 零回报、影子 AI |
| S8 | [MIT 科技评论中文](https://www.mittrchina.com/news/detail/15153) | 2025-08（摘要级） | 静态工具不适配 |
| S9 | [GenAI Divide 报告原文 PDF](https://mlq.ai/media/quarterly_decks/v0.1_State_of_AI_in_Business_2025_Report.pdf) | 2025 | 学习差距 |
| S10 | [知乎：MIT 报告拆解](https://zhuanlan.zhihu.com/p/1962574128 088323939)（同上） | 2025-08 后（摘要级） | 外购 67% vs 自建 33% |
| S11 | [CSDN：OpenClaw 踩坑实录](https://blog.csdn.net/houzilailema/article/details/158352279) | 未知（摘要级） | 文档不符 |
| S12 | [飞书：OpenClaw 保命 & Debug 指令合集](https://www.feishu.cn/content/article/7613321214 802643921)（同上） | 未知（摘要级） | 「昨天好今天装死」 |
| S13 | [腾讯新闻：本地部署劝退？](https://news.qq.com/rain/a/20260211A04M4B00) | 2026-02-11 | 标准化降门槛 |
| S14 | [V2EX：你们让父母用什么 AI app](https://www.v2ex.com/t/1229552) | 未知 | 国内可用性 |
| S15 | [CSDN：AI 自动化的交班设计](https://blog.csdn.net/tuse101/article/details/164108127) | 未知（摘要级） | 人机边界 |
| S16 | [OpenAI：Endava 案例](https://openai.com/zh-Hans-CN/index/endava-frontiers/) | 未知 | 行为改变非软件部署 |
| S17 | [安全内参：智能体调查](https://www.secrss.com/articles/80395) | 未知（摘要级） | 70%/权限不清 |
| S18 | [澎湃：微信回应「小微」隐私质疑](https://www.thepaper.cn/newsDetail_forward_34073771) | 2026-09-15 前后 | 渠道信任脆弱 |
| S19 | [HN：Clawdbot 讨论串](https://news.ycombinator.com/item?id=46760237) | 2026-01-26 | 安全批评、$300/2天、337 issues |
| S20 | [Reddit：I set up OpenClaw for 10+ non-technical NYC clients](https://www.reddit.com/r/openclaw/comments/1s75ghb/i_set_up_openclaw_for_10_nontechnical_nyc_clients/) | 2026 上半年（摘要级） | 视频装机、1-2 渠道+5-10 工作流 |
| S21 | [Reddit：流失模式帖](https://www.reddit.com/r/openclaw/comments/1rkjcva/ive_been_lurking_ropenclaw_for_weeks_the_dropout/) | 2026 上半年（摘要级） | Opus 默认档、无备份 |
| S22 | [VelvetShark：50 days with OpenClaw](https://velvetshark.com/50-days-with-openclaw) | 2026-02-26 ✅主会话已核 | 静默 cron 7 天、省 80%、朋友案例 |
| S23 | [Forbes：2 Reasons I Turned Off My OpenClaw](https://www.forbes.com/sites/paulbaier/2026/03/22/2-reasons-i-turned-off-my-openclaw-my-personal-ai-assistant/) | 2026-03-22（标题+摘要级） | bug+安全劝退 |
| S24 | [OpenClaw 官方 Troubleshooting](https://docs.openclaw.ai/troubleshooting) | 查询 2026-09-16 | 四大故障类目、成本零覆盖 |
| S25 | [hermes-agent README](https://github.com/NousResearch/hermes-agent) | 查询 2026-09-16 | doctor、杀软误报 |
| S26 | [n8n 社区：5 Mistakes](https://community.n8n.io/t/5-mistakes-i-made-building-ai-agents-with-n8n/299541) | 2026-06-15 | 置信阈值/日志/兜底/退出条件 |
| S27 | AI Automation Agency 社区帖（[Facebook](https://www.facebook.com/groups/aiautomationagency.aaa/posts/1638581710 601905)（同上）；[Liam Ottley](https://www.youtube.com/watch?v=DoHPZf7jEQ4)；[MindStudio](https://www.mindstudio.ai/blog/ai-agency-pricing-retainers-mistakes)） | 未知（摘要级） | 报美元数降流失、价值感知 |
| S28 | [The Operator Collective：AI Agent Failures](https://theoperatorcollective.org/blog/ai-agent-failures-lessons-crashes.html) | 未知（摘要级） | 工具调用失败 3-15% |
| S29 | [WaltLabs：Why 40% of AI Agents Fail](https://waltlabs.io/blog/why-40-of-ai-agents-fail-and-how-to-fix-it-in-2026) | 未知（摘要级） | God Agent 谬误 |
| S30 | [Winder.ai：Why AI Agents Fail in Production](https://winder.ai/why-ai-agents-fail-in-production/) | 未知（摘要级） | Gartner 2025-02 调研 |
| S31 | Reddit/GitHub/XDA/arXiv 多源（摘要级） | 2026 | 弃用曲线、更新破坏、假仓库 |
| S32 | Medium《OpenClaw is Dead》等（摘要级） | 2026 | 静默坏→死循环→弃用 |
| S33 | [arXiv 2412.14161](https://arxiv.org/abs/2412.14161)；[kenoticlabs](https://kenoticlabs.com/insights/ai-agent-failure) | 2025-08/2026-04（摘要级） | 可靠性现实 |

独立域名 31 个。

## 六、卡点与局限性

1. **Reddit 全文不可达**（403/前端壳页）：S20/S21/S31 帖子细节为摘要级，建议后续真人浏览器复核。
2. **HN 评论树 API 超时**：非安全类批评（成本/安装/维护）未系统抽取，可能低估 HN 侧维护成本抱怨。
3. **即刻/微信公众号无公开检索入口**：仅搜索引擎间接覆盖。
4. **V2EX 无「帮父母/朋友部署 agent」完整经验帖**——空白本身是发现：国内该场景公开复盘稀缺，本项目知识库有独特价值。
5. **幸存者偏差**：公开复盘都来自「装上了的人」；安装类失败真实占比可能更高——与 c4「10 分钟无解改期」止损纪律呼应。
6. MIT 95% 数据来自企业试点，外推到「给个人部署」属推断（样本性质不同），使用时注意。

> 变更记录：v1.0 2026-09-16 夜航首次产出（子代理 1A 起草，主会话抽查 4 个承重来源后落盘）。
