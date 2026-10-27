# openGym Docker 部署指南

> 第三方部署指南 · 非 openGym 官方仓库。官方项目：[DuarteSantos8/openGym](https://github.com/DuarteSantos8/openGym)
> 内容来自官方文档（2026-10-27）。项目迭代快，请以[官方文档](https://github.com/DuarteSantos8/openGym/blob/main/docs/SELF_HOSTING.md)为准。

[![⚡ Docker 部署](https://img.shields.io/badge/%E2%9A%A1_Docker_%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#docker部署推荐用百度搭子)

## Docker 部署（推荐：用百度搭子）

> [!TIP]
> 不想把训练数据交给订阅制 App？让百度搭子把 openGym 跑在你自己的机器上，数据全在本地。

⚠️ 需要 Docker 与 Compose v2。默认只能用 http://localhost:8080 访问；要用手机加 Passkey 登录，必须给自己的域名配 HTTPS（反向代理或隧道）。训练动图版权归 gymvisual，仅授权在 openGym 内使用。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/opengym-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子拉取预构建镜像，用 docker compose 启动 api 与 web 两个容器，起来后打开 localhost:8080，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Docker；未安装时按对话提示安装。）



## openGym 是什么？

openGym 是开源的16.6k stars，AGPL-3.0，自托管健身与体重记录，5,600+ 动作带动图，含 Apple Watch 与安卓 App（协议：AGPL-3.0，<img src="https://img.shields.io/github/stars/DuarteSantos8/openGym?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

开源自托管健身记录：按周计划或轮换安排训练、逐组记录重量次数、看肌群覆盖与 1RM 曲线、导入 Strong/Hevy/FitNotes 历史数据；手机端可以离线单独用，也可以连回自己的服务器同步。

- 16.6k stars：2026-07 建仓，三个月破 1.6 万
- 自托管：docker compose 起两个容器，数据全在 ./data 目录
- 5,600+ 动作库：带动图，可按肌群图与器械筛选
- 多端：iPhone / iPad / Apple Watch / Android APK / 浏览器 PWA
- Passkey 登录：Face ID、Touch ID、指纹，私钥不离开设备
- 多设备合并同步：按字段合并，两台设备同时编辑不互相覆盖
- 内置 MCP server：10 个工具，可让助手查训练史、记训练

（来源：[官方仓库](https://github.com/DuarteSantos8/openGym)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 16.6k stars | 2026-07 建仓，三个月破 1.6 万 |
| 完全自托管 | 数据在自己磁盘上，无订阅无广告无遥测 |
| 动作库大 | 5,600+ 动作，带动图与肌群图 |
| 多端齐全 | App Store、Apple Watch、安卓 APK、PWA |
| Passkey 登录 | 私钥留在设备安全硬件里 |
| 合并式同步 | 按字段合并，不互相覆盖 |
| 自带 MCP | 10 个工具，可让助手读训练史 |

| 需要注意 | 说明 |
|---|---|
| 需要 Docker | 没有原生 Windows 安装包 |
| 手机端要 HTTPS | Passkey 在局域网 http 下不可用 |
| 动图体积大 | web 镜像和 APK 都不小 |
| 动图版权受限 | 只能在 openGym 内使用，二次分发需授权 |
| AGPL 协议 | 改了对外提供服务要开源 |

> 以上基于官方文档与社区反馈整理（2026-10-27），以官方最新文档为准。

## 快速部署（官方方式）

```bash
git clone --depth=1 https://github.com/DuarteSantos8/openGym
cd openGym
cp .env.example .env
docker compose pull
docker compose up -d
docker compose ps
echo "部署完成：打开 http://localhost:8080"
```

部署步骤来源：[https://github.com/DuarteSantos8/openGym#quick-start](https://github.com/DuarteSantos8/openGym#quick-start)

## 验证状态

| 场景 | 状态 |
|---|---|
| 仓库元数据核对：16,573 stars、2,163 forks、AGPL-3.0、2026-07-18 建仓 | 已核对 2026-10-27 |
| 读取 docker-compose.yml 确认 api / web 两个服务，镜像为 ghcr.io/duartesantos8/opengym-{api,web}:latest | 已核对 2026-10-27 |
| 读取 .env.example 确认 RP_ID / ORIGIN / WEB_PORT / FIRST_USER_ADMIN / PASSWORD_LOGIN 等变量含义 | 已核对 2026-10-27 |
| Release v1.4.3 确认三个 APK：标准 300.6 MB、Plus 404.9 MB、HD 724.7 MB，均附 SHA256SUMS | 已核对 2026-10-27 |
| 读取 mcp/README.md 确认是本地 stdio MCP server，9 个只读工具 + log_workout | 已核对 2026-10-27 |
| 未实测 docker compose 启动（本机未安装 Docker） | 说明 2026-10-27 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

openGym 自带一个本地 stdio MCP server（`mcp/` 目录），提供 list_routines、get_routine、preview_session、get_week_plan、list_workouts、get_workout、get_bodyweight、estimate_1rm、muscle_balance 九个只读工具，外加写入工具 log_workout。它直接读 `./data` 目录，不新增容器；log_workout 需要先在 App 里配对生成 token。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-27）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\opengym-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 配置要点

改 `.env` 里的这几项就够了：

| 变量 | 作用 | 默认 |
|---|---|---|
| `WEB_PORT` | 宿主映射端口，被占用就改这里 | `8080` |
| `RP_ID` | Passkey 绑定的域名，必须与实际访问地址一致 | `localhost` |
| `ORIGIN` | 应用对外完整地址 | `http://localhost:8080` |
| `FIRST_USER_ADMIN` | 设为 `1` 时，第一个创建的档案成为管理员 | 关闭 |
| `INVITE_ONLY` | 设为 `1` 后建档案需要邀请码 | 关闭 |
| `PASSWORD_LOGIN` | 除 Passkey 外再开启账号密码登录 | 关闭 |
| `ALLOW_GUEST` | 是否允许「不建账号直接用」 | 开启 |

### 从手机访问

Passkey 只在 HTTPS 下可用（`localhost` 除外）。要在家里的手机用，两条路：

1. **反向代理 + 域名**：用 Cloudflare Tunnel、Caddy、Traefik 或 nginx 给自己的域名终止 TLS，然后把 `RP_ID` 和 `ORIGIN` 改成那个域名
2. **局域网临时用**：设 `PASSWORD_LOGIN=1` 走账号密码，Passkey 在纯 `http://` 的局域网地址上不可用

`docs/SELF_HOSTING.md` 里有 Cloudflare Tunnel、Caddy、Traefik、nginx 四种反代的完整配置，另有局域网 HTTPS、Mac + Tailscale、Kubernetes 三份专题文档。

### 数据在哪

| 文件 | 内容 |
|---|---|
| `data/db.json` | 档案与 Passkey 公钥数据 |
| `data/state-<uid>.json` | 每个用户自己的计划、训练、体重与设置 |
| `data/secret` | 会话 Cookie 签名密钥 |
| `data/uploads/` | 自制动作的图片和视频 |

备份整个 `./data` 就等于备份了全部数据。丢了 `data/secret` 所有人都要重新登录。

### 让 AI 读你的训练数据（可选）

```bash
cd mcp
npm install
node src/index.js
```

单个用户的实例会自动识别 UID；多用户实例需要指定 `OPENGYM_UID` 和 `OPENGYM_DATA`。

注册到客户端时用 `command` + `args` 形式，并把 `OPENGYM_DATA` 指到绝对路径下的 `data` 目录。写入工具 `log_workout` 还要先在 App 的「设置 → 账户 → 配对手机」里拿一次性码：

```bash
node mcp/scripts/pair.mjs https://<你的域名> ABCD-1234
```

把输出的 token 写进 `OPENGYM_TOKEN`，同时给 `OPENGYM_URL`。

> ⚠️ 这个 token 等同于一次完整登录，配置文件里是明文，当作密码保管。在 App 里点「在所有设备上退出」会立刻让它失效。

### AI 教练（可选，默认关闭）

默认镜像不含任何 AI 运行时。要用教练功能，需要管理员在后台打开并配置自己的模型 Key（Anthropic、OpenAI、Gemini 或任意 OpenAI 兼容接口，含 Ollama）。想连 Claude Agent SDK 或 Codex CLI 一起打进镜像，需要另构建：

```bash
docker compose up -d --build api
```

配合 `.env` 里的 `API_TARGET=coach`，镜像会大约增加 300 MB。

## 常见坑

- 端口被占：改 `.env` 里的 `WEB_PORT`，不要改容器内端口
- Passkey 登录失败：`RP_ID` 和 `ORIGIN` 必须与实际访问的域名和协议完全一致
- 手机扫码打不开：先确认手机和电脑在同一网段，或改用域名访问
- 局域网 http 下建不了 Passkey：设 `PASSWORD_LOGIN=1` 用密码登录
- 首次拉镜像很慢：web 镜像内含动作动图，体积偏大
- 忘了管理员密码：用 `ADMIN_UIDS` 指定用户 ID，或改 `data/db.json` 里的 `admin` 字段
- 升级后数据还在吗：容器重建不影响 `./data` 挂载，但升级前先备份
- MCP 写入报 token 失效：在 App 里重新配对，`SESSION_DAYS` 默认 90 天

## 免责声明

本仓库为第三方指南，与 openGym 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-27），项目迭代快，请以[官方文档](https://github.com/DuarteSantos8/openGym/blob/main/docs/SELF_HOSTING.md)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
