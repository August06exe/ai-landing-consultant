# 专题11：Hermes Desktop 完整使用指南（理论钉死版）

> 版本 1.0 ｜ 产出日期 2026-09-18（夜航）｜ 读者：顾问（主）/客户（§1-§3 可直接转述）
> 事实源：`02-知识库/02-官方文档/llms-full.txt`（2026-09-15 官方抓取，行号锚点为 2026-09-18 实测）。本文所有行号均指该文件，标注为 `:行号`。查不到的标「未验证」。
> 方法论：顾问视角（哪里必须支援、哪里会卡）+ 小白视角（每一步看到什么点什么）双轨并行。

---

## 〇、硬结论：Hermes Desktop「开箱即用吗」？

**结论先行：官方 Desktop 路径是「开箱即装、配置半自动」——安装本身零依赖全自动，但「模型通」必须人提供一把钥匙（订阅账号或 API key），「渠道通」必须人在消息平台侧点几下，「第一条 cron」是对 agent 说一句话。全程无一行必敲的代码。**

### 三通动线总表（从下载到第一条 cron）

| 步 | 做什么 | 谁做 | 自动/手动 | 文档依据 | 耗时（官方口径/实测推算） |
|---|---|---|---|---|---|
| 1 | 下载 Desktop 安装包并运行 | 人 | 手动双击 | 安装包在官网产品页（:70436）；「同时装 CLI+Desktop，免管理员权限」（:87943） | 下载+双击 ≈5 分钟 |
| 2 | 依赖安装（Python/Node/PortableGit/ripgrep/ffmpeg） | 安装器 | **全自动** | 「installer handles everything automatically」（:50）；Windows 端 10 步清单（:87963-87974） | 官方口径「under two minutes」（:13），国内网络视带宽 10-30 分钟 |
| 3 | 首启向导 setup（选 provider、配模型） | 人+向导 | 半自动：人登录/贴 key，其余自动 | Desktop「First-run onboarding gets you to your first message in seconds」（:70596）；可「Choose provider later」跳过先进 app（:70609） | 5-15 分钟（取决于是否已有账号） |
| 4 | **模型通**：发第一句话有回应 | 人验证 | 手动说一句话 | Quickstart「Run Your First Chat」（:384-416）；成功标准四条（:409-414） | 1 分钟 |
| 5 | **渠道通**：接通微信/企微/Telegram 等 | 人（平台侧） | 手动为主；Telegram 有 QR 快速卡 | Desktop Messaging 面板「Create with QR」一条龙（:70630）；`hermes gateway setup` 交互向导（:4666-4667） | Telegram QR ≈3 分钟；微信 iLink 需按专题01流程 ≈15-30 分钟 |
| 6 | **第一条 cron**：对 agent 说一句话 | 人说，agent 建 | **对小白是零配置** | 「Ask Hermes normally…Hermes will use the unified cronjob tool」（:15439-15445）；`/cron add`（:15419-15424） | 1 句话 |

### 哪些自动、哪些必须人做（边界清单）

**全自动（人只看不动手）**：依赖树安装（连 PortableGit 都替你下，:87968）、venv 创建、PATH 注册（:87973）、Desktop 首启自动装 agent runtime 到 `%LOCALAPPDATA%\hermes`（:70763）、更新前自动快照（:809）、网关自动重启（:815）。

**必须人做（agent/安装器替不了）**：
1. **提供模型凭据**——这是唯一的硬门槛。要么 Nous Portal 订阅 OAuth 登录（最快，:83-91），要么任何一家 API key。**没有任何免凭据路径**（本地模型也需要装 Ollama/LM Studio 并配 endpoint）。
2. **消息平台侧的授权动作**——扫码、填 bot token、企业微信后台配置。Hermes 侧已尽量自动化（Telegram QR 一条龙，:70630），但平台账号必须是客户本人的。
3. **安全决策**——审批模式选择、白名单设置。文档明确 YOLO 会跳过危险命令审批（:70476），这是人的决定。
4. **说第一句话验证**——文档特意设计为人工验证步骤（:418-427 还要求验证会话能恢复）。

### 一句话给老板

> 「下载安装包点下一步，跟着向导登录选模型，手机扫码接微信——全程不用碰命令行。真正要准备的只有两样：能访问官网和模型 API 的网络，以及一个模型账号（订阅或 API key）。」
> 国内网络例外：Electron 运行时从 GitHub 下载，被墙/限速时安装会卡在「Build desktop app」——官方有 npmmirror 自动重试自愈（:70985），顾问支援见 §11。

### 与既有交付假设的冲突修订（本次已当场执行）

| 假设 | 文档事实 | 处置 |
|---|---|---|
| c4 步骤5「设 token 月度硬顶与超限提醒」像是一个官方配置 | **官方无原生月度花费硬顶配置**。存在的是：`max_turns`（goal 轮数帽，:4819）、500 轮迭代预算（:4751）、delegation 深度/并发帽（:6369）、dashboard Usage analytics 事后统计（:6517）、`/usage` 会话查询（:24829）、cron 配置校验失败不烧 token（:15459-15461） | c4 v2.1 已改为「用量可见+代理侧限额+cron 造价巡检」组合表述；详见专题12 核对表 |
| c4 引用「杀软墙位见专题02」但专题02 无此内容 | llms-full.txt 仅两处：更新脚本被杀软隔离的修复指引（:834）、进程锁误判可 `--force`（:968）；安装期 Defender 误报的详细处理在 hermes-agent GitHub README（不在 llms-full.txt） | §10.4 新增「杀软墙位」节补齐；专题02 已升 v1.1 补节；c4 引用改指专题02§10 |
| 专题02 写「配置家目录 Windows 即 `%USERPROFILE%\.hermes`」 | Windows 原生安装器设 `HERMES_HOME=%LOCALAPPDATA%\hermes`（:88106、:87973） | 专题02 已升 v1.1 修正 |

---

## 一、安装（小白逐步 × 顾问核验点）

### 1.1 路径选择

| 路径 | 适合谁 | 命令/动作 | 依据 |
|---|---|---|---|
| **Desktop 安装包**（官方推荐） | 所有客户，唯一该给小白的 | 官网下载 → 双击 → 下一步到底 | :21-26（macOS/Windows 推荐）；Windows 下首启 GUI 底层自动调 install.ps1（:87943） |
| PowerShell 一行命令 | 有 IT 部门的客户/老板自己 | `iex (irm https://hermes-agent.nousresearch.com/install.ps1)`（:39-41）；文档另一处给出 raw.githubusercontent.com 形式（:87918）——两个官方源等价 | :36-46 |
| curl（Linux/macOS/WSL2/Termux） | 非 Windows | `curl -fsSL https://hermes-agent.nousresearch.com/install.sh \| bash`（:33） | :31-34 |

**顾问核验点**：macOS 安装包仅支持 Apple Silicon，Intel 不支持（:25-26）。客户是 Intel Mac → 直接告知换路径或放弃。

### 1.2 Windows 安装器实际做的十件事（顾问必懂，出问题能定位）

1. 装 uv（Python 管理器）到 `%USERPROFILE%\.local\bin`（:87965）
2. 经 uv 装 Python 3.11，无需已有 Python（:87966）
3. 装 Node.js 26（winget 可用走 winget，否则便携版解到 `%LOCALAPPDATA%\hermes\node`，:87967）
4. 装 PortableGit（PATH 已有 git 则跳过；约 45MB 自包含，:87968）
5. 克隆仓库到 `%LOCALAPPDATA%\hermes\hermes-agent` 并建 venv（:87969）
6. **分层依赖安装**：先试 `.[all]`，GitHub 限速导致失败则逐级降档到 `[messaging,dashboard,ext]`→`[messaging]`→`.`（:87970）——「单个依赖抖动不至于给你一个裸装」
7. 按 `.env` 里已有的 token 自动装对应渠道 SDK（TELEGRAM_BOT_TOKEN 等，:87971）
8. 设 `HERMES_GIT_BASH_PATH`（:87972）
9. 把 `%LOCALAPPDATA%\hermes\bin` 加进 User PATH；只放 `hermes.exe` 启动器，**故意不把整个 venv\Scripts 上 PATH**（避免遮蔽用户自己的 python，:87973）
10. 跑 `hermes setup` 首启向导（`-SkipSetup` 可跳，:87974）

**小白看到什么**：安装器进度条 → 完成后提示开新终端。**顾问核验**：装完若 `hermes: command not found`，标准答案是「开一个新的 PowerShell 窗口」（PATH 对已开窗口不生效，:87921、:88186）。

### 1.3 依赖自举 dep_ensure（首启后的按需补装）

首启时 Python 引导器 `hermes_cli/dep_ensure.py` 逐项检查依赖，缺了且交互模式下会主动提出安装；非交互（gateway/cron/无头启动）不弹窗，报「this feature needs <dep>」（:87949-87959）。含义：**交付后客户某功能突然说缺依赖 = 正常的按需自举，不是坏了**。

---

## 二、首启向导与模型配置（「模型通」的唯一硬门槛）

### 2.1 Desktop 内 onboarding

- 统一 overlay 设计的首启向导，目标是「seconds to first message」（:70596）
- **可跳过**：「Choose provider later」先进入 app 再配（:70609）——小白演示时有用：先让他看到界面长什么样
- Providers 面板是 Accounts/API-keys 双轨 UX，按 profile 存凭据（:70598）

### 2.2 `hermes setup` 三种模式（:302-309）

| 模式 | 适合 | 效果 |
|---|---|---|
| **Quick Setup（Nous Portal）** | 绝大多数客户（推荐默认） | OAuth 登录一次，模型+Tool Gateway 全通，无 key 管理 |
| Full Setup | 自带各家 key 的用户 | 逐项走 provider/tool/选项 |
| Blank Slate | 极客/最小化控制 | 一切关闭只留最小 agent（provider+文件+终端），之后精确逐项开启 |

### 2.3 模型选择要点

- `hermes model` 交互选择（:289）；provider 目录 40+ 家（:314-355），含 Z.AI/GLM（`GLM_API_KEY`/`ZAI_API_KEY`/`Z_AI_API_KEY`，:321）、Kimi 中区（`KIMI_CN_API_KEY`，:323）、MiniMax 中区（:329）、阿里 DashScope 通义（:330）、DeepSeek（:350）——**国内模型全线有官方接入位**
- **64K 上下文硬红线**：模型窗口 <64K 直接拒绝启动（:359-361）。本地模型要显式 `--ctx-size 65536`
- Secrets 与配置分家：密钥进 `~/.hermes/.env`，非密配置进 `config.yaml`（:369-372）——c3 交付包「SOUL 写入 ~/.hermes/」的落位依据
- 主模型+11 辅助槽结构（:6495-6498）；辅助任务默认 `auto` 跟主模型，可为压缩/视觉/标题等单配便宜模型（:6575-6591）——成本优化第一杠杆
- **中途切模型清空 prompt 缓存**：下一次消息按全量输入计费（:6542-6544）——教客户「别在长对话里反复切模型」

### 2.4 Desktop 里的模型 UI 细节（顾问支援时用）

- 模型选择器在 composer 麦克风左边；选择是 UI 粘性状态**不写默认值**（唯一例外：全新 profile 第一次选择会落盘，:70511）
- 想改默认 → **Settings → Model**（:70512）
- 每模型记住自己的 effort/fast 预设（:70513）
- 辅助模型可按任务设 reasoning effort（`auxiliary.<task>.reasoning_effort`，:70605）
- 换主模型 provider 时若辅助槽还钉在别家，app 会警告（:70604）

---

## 三、界面导览（Desktop 有什么，客户最先用哪些）

> 布局：聊天居中 + 左侧栏导航（:70448）。四个前端（Desktop/CLI/TUI/Web Dashboard）共享同一 agent、同一会话（:70424-70432）——**「在 Desktop 开始的会话去 CLI 能续」是演示话术的加分点**。

### 3.1 客户视角（使用卡可引用的功能清单）

| 功能 | 入口/操作 | 小白价值 |
|---|---|---|
| 聊天 | 主界面；拖文件进聊天即附附件（:70459） | 像微信一样用 |
| 模型切换 | composer 左侧选择器 | 几乎不用碰（粘性） |
| 右侧预览栏 | 自动渲染网页/文件/工具输出（:70462） | 「它给我看的图表直接在旁边」 |
| 文件浏览器 | 左侧栏；`hermes desktop --cwd <path>` 定初始目录（:70518） | 看着 agent 干活 |
| Artifacts 画廊 | 侧栏入口；自动索引会话产物（:70524） | 「它做过的东西都在这」 |
| 终端 | 右侧栏；Ctrl+` 呼出（:70538）；隐藏不杀进程（:70539） | 客户基本不用 |
| 语音 | 与 voice mode 同源；macOS 首次要授权麦克风（:70563） | 打招呼即可对话 |
| 中文界面 | Settings 内切 Simplified Chinese (zh-Hans)（:70694） | **官方支持六语界面，含简繁中文** |
| 定位阅读位置/页内查找 | 自动恢复阅读位置（:70467）；Cmd/Ctrl+F（:70468） | 长对话不迷路 |
| Quick Entry 全局快捷输入 | 默认 Ctrl/Cmd+Shift+Space，任意界面唤起（:70559） | 不开 app 也能喊它 |

### 3.2 顾问视角（管理面板，c4/c5 支援时用）

| 面板 | 功能 | 依据 |
|---|---|---|
| Skills | 已装技能开关+内置可选目录一键安装 | :70626 |
| Memory（Star Map） | `/journey` 打开技能/记忆星座图，可编辑删除 | :70627 |
| Cron | 定时任务查看管理 | :70628 |
| Profiles | 多 agent 配置切换（隔离 config/skills/sessions） | :70629 |
| Messaging | 渠道配置；Telegram「Create with QR」扫码一条龙（建 bot+识别用户 ID+存凭据+重启网关）；保存后出「Restart now」横幅直到网关真重启 | :70630 |
| Bot Mode | 默认开启的「一 chat 一 agent」花名册；bot 互发消息、群聊审议；不想要可关（Capabilities → Plugins → Bots） | :70635-70683 |
| 状态栏 YOLO 开关 | 按 session 旁路危险命令审批（开=不问了）；**交付基线必须关** | :70476 |
| 状态栏上下文表 | 点击看 token 分类占比（系统提示/工具/技能/记忆/对话） | :70477 |
| Git review 面板 | 仓库内会话的 diff/commit/PR（Cmd/Ctrl+G） | :70550 |

### 3.3 键盘与命令面板

- Cmd/Ctrl+K 或 Cmd/Ctrl+P 命令面板：跳页面/找会话/切模型/重启网关/更新 Hermes（:70691）
- 快捷键几乎全可重映射（Settings → Keyboard Shortcuts / Cmd/Ctrl+/）；冲突会标红（:70692）
- 高频默认：Cmd/Ctrl+N 新会话、Cmd/Ctrl+, 设置、Cmd/Ctrl+Shift+F 搜会话、Cmd/Ctrl+1-9 切 profile（:70692）

---

## 四、渠道接入（「渠道通」）

### 4.1 架构一句话

网关是**一个独立后台进程**，连所有平台、管会话、跑 cron（:24608）。Desktop 默认自带的本地后端是 `hermes serve`，与消息网关是**两个进程**（:70795-70796）——「Desktop 开着」≠「网关在跑」，c4 演示时必须先 `hermes gateway install` 装自启。

### 4.2 平台能力对照（节选国内相关，全表 :24632-24661）

| 平台 | 语音 | 图片 | 文件 | 流式 | 国内落地备注 |
|---|---|---|---|---|---|
| Weixin（个人微信，iLink） | ✅ | ✅ | ✅ | — | 专题01 大坑记录仍在：个人微信走 iLink Bot API（:141） |
| WeCom 企业微信 | ✅ | ✅ | ✅ | — | AI Bot WebSocket 网关（:139） |
| 钉钉 DingTalk | — | ✅ | ✅ | ✅ | :124 |
| 飞书 Feishu/Lark | ✅ | ✅ | ✅ | ✅ | 全能力，国内渠道首选技术侧（:125） |
| QQ | ✅ | ✅ | ✅ | — | :133 |
| Telegram | ✅ | ✅ | ✅ | ✅ | 全能力；QR 快速设置（:70630） |

### 4.3 接入动线（客户侧动作最小化）

1. Desktop → Messaging 面板（:70630）
2. Telegram：点「Create with QR」→ 手机 Telegram 扫码 → Hermes 自动建 bot、识别用户 ID、存凭据、重启网关（:70630）
3. 其他平台：`hermes gateway setup` 交互向导（:4666-4667）或按专题01 各平台节
4. 任何凭据保存/清除/开关后，页面挂「Restart now」横幅直至网关真重启；重启失败横幅保留可重试（:70630）

### 4.4 白名单与安全（c4 安全基线的文档落点）

- 各平台有 `allowed_users` 白名单机制（例：Matrix :29916；Nostr :79790-79846 明确「默认私模式，只有列出的用户能对话」）
- 渠道安全检查路由：`hermes gateway status`（:88083 Windows 版合并视图）

---

## 五、Skills（技能系统）

- 本质：按需加载的知识文档（progressive disclosure），兼容 agentskills.io 开放标准（:10903）
- 全部住在 `~/.hermes/skills/`（:10905）；**agent 可以自己改/删/造技能**（同节）——c3 进化守则「自写技能必须报告」的官方机制依据
- 每个技能自动成为斜杠命令（:10946-10957）；一条消息最多链 5 个技能（:10961-10963）
- `/learn`：把「你刚带它走完的流程」直接蒸馏成技能（:10988-11013）——**d3 工作流迭代的官方抓手**
- 空白 profile：`hermes skills opt-out` 停止预装播种（只停未来不删现有）；`opt-in --sync` 反悔（:10930-10938）
- 技能安装自带安全扫描（:511）
- Desktop Skills 面板 = 已装列表+官方可选目录一键装（:70626）

---

## 六、Cron（定时任务，「第一条 cron」）

### 6.1 三条创建路径（都向小白开放）

1. **对它说话**：「每天早上 9 点检查 XX 发我微信」→ agent 走 `cronjob` 工具自己建（:15439-15445）
2. 聊天内 `/cron add "every 2h" "Check server status"`（:15419-15424）
3. CLI：`hermes cron create "every 1h" "…" --skill blogwatcher`（:15428-15435）

### 6.2 顾问必懂的机制

- **模型解析链**：per-job pin → `cron.model` 配置 → 创建时快照的全局默认（:15396-15400）。**全局切模型不会让 cron 舰队跟着换**——`hermes cron resnap` 显式迁移（:15400）
- per-job reasoning effort 钉子：none~ultra 八档（:15408）
- **cron 会话不能再建 cron**（防失控循环，:15411-15413）
- **派发前校验**：key 解析不了/技能缺凭据/投递目标不通 → `blocked_config`，只告警一次，**不烧 token**（:15447-15461）——「配错的 cron 不花钱」
- no-agent 模式：纯脚本 cron，stdout 原样投递，零 LLM（:15390、专题详见 cron-script-only 指南）
- 事件触发：webhook 带 `cron_job` 参数，事件发生即刻跑（:15391）

### 6.3 失联与告警（c3「失败要出声」的官方配合点)

- `blocked_config` 告警只发一次不重复轰炸（:15459-15461）
- 投递目标可为 origin chat/本地文件/平台 target（:15387-15388）

---

## 七、更新与守卫（陪跑期最高频故障区）

### 7.1 更新机制速览

- `hermes update` 一条命令：预快照 → git pull → **拉完先编译九个关键文件，坏了自动 `git reset --hard` 回滚**（:811）→ 装依赖 → 迁移配置 → Desktop stage-and-swap 重建（新包验证通过才替换，失败旧版可启动，:814）→ 网关自动重启（:815）
- 更新回执落 `~/.hermes/logs/update_receipts/`（:898）；过程日志 `update.log`，SSH 断线不更新中断（:1013-1023）
- Desktop 内更新按钮/⌘K Update Hermes/更新就绪 toast；多网关时全链更新（先后端后 app）（:70714-70716）
- 关闭被动检查：`hermes config set updates.check false`（不影响 Desktop 更新器，:800-803）

### 7.2 Windows 三守卫（专题02 v1.1 同步更新）

| 守卫 | 触发 | 解法 | 依据 |
|---|---|---|---|
| 进程锁守卫 | 别的 hermes.exe 在跑（Desktop 后端/别的终端 REPL/网关） | 按提示关掉再跑；确定误报才 `--force` | :950-968 |
| venv 守卫 | 任何进程从 venv 的 Python 解释器跑着（.pyd 被锁） | **`--force` 绕不开**；只有 `hermes update --force-venv` | :970 |
| 杀软隔离 | 更新器脚本被杀软隔离 | 修复安装+查杀软隔离报告再重试；**官方明确禁止关杀软** | :834 |

- venv 重建是事务性的：旧树先改名 `venv.stale.*`，新树验证通过才删旧的；失败自动回滚（:972-978）
- Desktop 更新用 `--keep-stash`：客户本地改动进 stash 停放，日志打印恢复命令（:880）
- 更新后五步验证（:996-1004）：`git status --short` → `hermes doctor` → `hermes --version` → `hermes gateway status` → npm audit fix

### 7.3 从消息平台更新

对 bot 发 `/update` 即可拉代码+重启网关，离线 5-15 秒（:1033-1041）——**d2 远程排障的轻手段**。

---

## 八、SOUL·AGENTS·记忆：一个文件一张图

> 权威来源：「Which File Does What?」（:87844-87896）。c3 交付包文件落位的最高依据。

| 文件 | 装什么 | 谁写 | agent 何时看到 | 住在哪 |
|---|---|---|---|---|
| **SOUL.md** | 人格：语气、风格、禁忌 | **人**（Hermes 只在缺失时播种 starter，永不覆盖） | 会话启动时系统提示槽 #1 | `~/.hermes/SOUL.md`（永不在工作目录） |
| **USER.md** | 用户画像 | agent（memory 工具） | 会话启动注入冻结快照 | `~/.hermes/memories/` |
| **MEMORY.md** | agent 自己的笔记 | agent | 同上 | `~/.hermes/memories/` |
| **AGENTS.md** | 项目规则/命令/路径 | 人 | 启动时从工作目录加载，子目录渐进发现 | 项目目录+子目录 |
| **.hermes.md** | 同 AGENTS.md 但 Hermes 专属、优先级最高 | 人 | 先于 AGENTS.md | 项目，发现 walks up to git root |

**冻结快照规则**（:87873）：会话中途存的记忆立刻落盘，但系统提示里的记忆块要**下个会话才刷新**——「我明明教过它」类工单的标准答案：重开会话。SOUL.md/AGENTS.md 改动同理（:87883）。

**常见混淆**（:87875-87883）：SOUL 和 USER 两个系统互不喂养——想让 agent 记住你的偏好，对它说（进 USER.md），不是改 SOUL.md。

---

## 九、卸载与迁移

### 9.1 Desktop 内三档卸载（Settings → About → Danger zone，:70722-70730）

| 档 | 删什么 | 等价命令 |
|---|---|---|
| Uninstall Chat GUI only | 仅 Desktop app | `hermes uninstall --gui` |
| GUI + agent，keep my data | app+agent，保配置/会话/密钥 | `hermes uninstall` |
| Uninstall everything | 全删 | `hermes uninstall --full` |

### 9.2 Windows 手动兜底

`hermes uninstall` 删 schtasks+Startup 快捷+shim+`hermes-agent\` 目录+PATH 项，**数据目录保留**（:88156-88160）；全删需手动 `Remove-Item %LOCALAPPDATA%\hermes`（:88163-88168）——注意数据与安装同根，**想保数据就只删 `hermes-agent\` 子目录**（:88106）。

### 9.3 迁移（换机）

- 全量：`hermes backup` / `hermes import`（含凭据；:94、:1128）
- 单 agent：`hermes profile export` / `import`（**设计上排除凭据**，单独用不算完整备份，:94、:1128）
- Desktop 也能导/入 profile（⌘K → Export/Import profile…，外观一并打包，:70701）

---

## 十、故障排查路由表（症状→处理→锚点）

| 症状 | 先查 | 处理 | 锚点 |
|---|---|---|---|
| 装完 `hermes` 命令不存在 | 是否开新终端 | 开新 PowerShell；急用直跑 `& "$env:LOCALAPPDATA\hermes\bin\hermes.exe"` | :88185-88186 |
| 安装卡「Build desktop app」反复 retry | GitHub 连通性 | 官方自愈：清缓存重试→npmmirror 再试；自设 `ELECTRON_MIRROR` 永不被覆盖 | :70981-70992 |
| API key not set | 模型配置 | `hermes model` 重配 | :177 |
| 空回复/乱回复 | provider/model 鉴权 | `hermes model` 再走一遍 | :559 |
| 「变笨了」/中途忘事 | 模型切换/上下文压力/冻结快照 | 专题04 排查路由表 + §八 冻结快照规则 | :87873 |
| 中文字符显示 `?` | UTF-8 shim 未激活 | 查 `HERMES_DISABLE_WINDOWS_UTF8`；老 cmd.exe 换 Windows Terminal | :88206-88207 |
| 更新报「Another hermes.exe is running」 | Desktop/REPL/网关占用 | 关掉再跑；误报才 `--force` | :950-968 |
| 更新卡两版本之间 | venv 被锁 | `hermes update --force-venv`（唯一豁免） | :970 |
| 网关重启后不在了 | schtasks 被组策略挡 | `hermes gateway status` 合并视图看失败原因 | :88194-88195 |
| Desktop 卡死/启动失败 | boot 日志 | `HERMES_HOME/logs/desktop.log`；`hermes logs gui -f` | :70948-70952 |
| 失败的回合 | 看错误卡**命名了哪层失败**（provider/网关/本地运行时/磁盘）+ 配套恢复按钮 | Retry/切 provider/开日志/复制错误详情 | :70917-70946 |
| Telegram 发图报 BadRequest | 路径反斜杠未转义（多为插件问题） | 用 Hermes 提供的路径，勿 `str(Path(...))` | :88209-88210 |
| git pull 后行为诡异 | 非 UTF-8 编辑器写入 BOM | 重存为无 BOM UTF-8 | :88212-88213 |
| 「host key has CHANGED」（SSH 远程） | 远端重装/key 轮换 | 确认后 `ssh-keygen -R <host>` 再 Retry | :70967-70979 |
| 401 登录失败（远程后端） | 用户名或密码错（防枚举不区分提示） | 核对 `.env` 两值；`curl :9119/api/status` 验证 auth_required | :70857 |
| 每次重启都被登出 | 签名密钥随机 | 设稳定的 `HERMES_DASHBOARD_BASIC_AUTH_SECRET` | :70859 |
| 重连不用重启 app | 网关假死 | 状态栏网关菜单 → Reconnect gateway | :70913-70915 |

### 10.4 杀软墙位（补齐 c4 引用，来源分层标注）

| 阶段 | 现象 | 处理 | 来源 |
|---|---|---|---|
| 安装期 | 第三方杀软拦 PortableGit/uv 下载或 PowerShell 载荷 | 官方文档（llms-full.txt）未给安装期白名单步骤——**未验证**；保守做法：装前临时退出第三方杀软（装完恢复），只用官网安装包 | 推断（依据更新期同性质处理 :834） |
| 更新期 | 杀软隔离更新器脚本 → 更新假失败 | 修复安装+查隔离报告，恢复文件后重试；**官方明令不得关杀软** | llms-full.txt:834 ✅ |
| 更新期 | 杀软 shim 制造假进程锁 | `--force`（仅此情形） | llms-full.txt:968 ✅ |
| hermes-agent GitHub README 的 Defender 误报节（精确 PowerShell 命令） | — | 专题09 记载其存在（2026-09-16 快照）；本次未重新核验原文行文——引用前先看仓库 README | 专题09:28 |

---

## 十一、顾问支援点清单（哪里必须人在场）

c4/c5 的文档级依据汇总（打勾制）：

- [ ] **网络**：官网可达 + GitHub 可达（Electron/PortableGit 下载）+ 模型 API 可达——三样缺一会分别卡在下载/安装/首对话
- [ ] **凭据**：客户提前注册好 Portal 订阅或拿到 API key（§二 硬门槛）
- [ ] **开新终端**：装完 PATH 不对旧窗口生效——客户最常见的「装好了但命令不存在」
- [ ] **Telegram QR**：客户手机上装好 Telegram 且能收到验证码
- [ ] **微信 iLink**：按专题01 流程，人工步骤最多的一条渠道
- [ ] **网关自启**：`hermes gateway install`（schtasks）必须做，否则「Desktop 关了 bot 就死」（§四.1 两进程模型）
- [ ] **YOLO 状态**：状态栏确认按会话 YOLO 是关的（安全基线）
- [ ] **杀软**：装前问一句装的什么杀软（§10.4）
- [ ] **macOS Intel**：提前劝退（:25-26）
- [ ] **64K 上下文**：自选便宜模型时检查窗口大小（:359-361）

---

## 十二、行号锚点速查（本文引用索引）

| 主题 | 行号 |
|---|---|
| Installation（官网包推荐/一行命令/装了什么） | :9-115 |
| Quickstart（setup 三模式/provider 表/64K 红线/首对话） | :209-604 |
| Updating & Uninstalling（快照/回滚/Windows 三守卫/venv 事务） | :777-1146 |
| Configuring Models（主+11 辅助槽/切模型清缓存） | :6491-6620 |
| Messaging Gateway（28 行平台对照表（含 2 变体行）/架构） | :24604-24712 |
| Skills System（目录/slash/链式//learn/opt-out） | :10899-11020 |
| Cron（三路径/模型解析链/blocked_config/no-agent） | :15374-15461 |
| Hermes Desktop 主章节（安装/界面/更新/卸载/远程后端/排障） | :70416-71107 |
| Which File Does What（SOUL/USER/MEMORY/AGENTS 表） | :87844-87896 |
| Windows Native（十步安装/功能矩阵/Git Bash/数据布局/坑） | :87901-88222 |
| Web Dashboard（9119 端口/web,pty 依赖） | :77190-77278 |

---

> 变更记录：v1.0 2026-09-18 夜航首次产出——通读 llms-full.txt Desktop 相关全部章节实测行号；新增「开箱即用」硬结论（三通动线/自动-手动边界）；补杀软墙位节（来源分层）；发现并修订 Windows HERMES_HOME 路径错误与「token 月度硬顶」无原生配置两项事实偏差（联动修订专题02 v1.1、c4 v2.1）。
