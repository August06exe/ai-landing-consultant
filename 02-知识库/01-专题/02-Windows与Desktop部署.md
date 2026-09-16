# 专题02：Windows 与 Desktop 部署要点（第一单主战场）

> 基于 `02-知识库/02-官方文档/llms-full.txt`（2026-09-15 抓取）。目标环境：客户 Windows 10/11 + 官方 Desktop。

## 安装路径（推荐顺序）

1. **首选：官方 Desktop 安装包**（hermes-agent.nousresearch.com 下载，macOS/Windows/Linux），**同时装好 CLI + Desktop**，免管理员权限（:21-24, :254-256）。对小白客户这是唯一该给的路径。
2. 纯 CLI（不推荐给客户）：`curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash`（WSL2/Git Bash 环境）。
3. 安装位置：Windows 下装在 `%LOCALAPPDATA%\hermes\hermes-agent`（:492）；配置家目录 `~/.hermes/`（Windows 即 `%USERPROFILE%\.hermes`）。

## Windows 原生运行机制（顾问必懂，出问题能定位）

- **Shell 策略**：Hermes 的终端工具通过 **Git Bash** 执行命令（与 Claude Code 同策略）。bash.exe 解析顺序：`HERMES_GIT_BASH_PATH` 环境变量 → `%LOCALAPPDATA%\hermes\git\usr\bin\bash.exe`（安装器带的 PortableGit）→ 旧版布局 → 系统 Git → PATH 上任何 bash（:87701-87713）。
- **UTF-8**：入口处强制切 CP_UTF8(65001) 并重配 stdio，中文/Unicode 不会乱码崩（:87717-87724）。
- **功能矩阵**（:87682-87699）：CLI、TUI、15+渠道网关、cron、浏览器工具、MCP、本地模型（Ollama/LM Studio）、Web 仪表盘 **全部原生可用**；唯独仪表盘的 `/chat` 内嵌终端标签页不支持（需 POSIX PTY），会显示「用 WSL2」横幅——**不影响客户使用，提前告知即可**。
- 开机自启：`schtasks`（:87697）。

## Desktop 更新的坑（陪跑期高频故障）

- `hermes update` 在 Windows 上**拒绝运行**如果有进程锁住 hermes.exe——最常见就是 Desktop app 开着、别的终端开着 hermes REPL、网关在跑。提示语是「Close Hermes Desktop, exit any open hermes REPLs…」（:940-958）。
- 依赖同步中途死在 access-denied 会把安装卡在两个版本之间；这个保护 `--force` 绕不开，只有 `hermes update --force-venv` 显式豁免（:958）。
- Desktop 更新是 stage-and-swap：新包验证通过才替换，失败则旧版保持可启动（:814-815）；更新后网关自动重启（:815）。
- **本地改动不会自动恢复**：Desktop 更新走 `--keep-stash`，客户自己改过的源码会进 git stash 停放，更新日志会打印恢复命令（:880）。顾问远程协助更新时记得看 stash。
- 可用配置关闭被动更新检查；`hermes update --check` 仍可用（:803）。

## 给小白客户的方案取向

- **模型接入首推 Nous Portal**：一次 OAuth 同时搞定模型 + 工具类 provider（TTS、web 等多把钥匙），官方明说这是 Windows 用户最顺的路径——否则 Firecrawl/FAL/Browser Use/OpenAI 一把把配 key 是「最高的摩擦点」（:69454）。订阅用户还有 10% off token 计费（:6471）。
- 客户无网络条件装不动 → 退路：国内镜像/中转 + custom endpoint（见专题03）。
- 交付演示路径固定化：Desktop 打开 → 微信扫码 → 手机发第一条消息 → 得到回复。全程不碰命令行。

## 顾问自查清单（Windows 单）

- [ ] Windows 版本 ≥10，磁盘空间充足
- [ ] 网络能到达 GitHub / 模型 API（装不上十有八九是这个）
- [ ] Desktop 安装包来源是官网
- [ ] 首次 `hermes setup` 走通（模型有回应）
- [ ] 网关自启已配置（schtasks）
- [ ] 仪表盘 /chat 标签页不可用已向客户说明
- [ ] 已向客户演示「如何自己重启电脑后确认 Hermes 还活着」
