#!/usr/bin/env bash
set -euo pipefail
# openGym Docker 部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/DuarteSantos8/openGym/blob/main/docs/SELF_HOSTING.md
# 更新日期：2026-10-27
# 类型：docker
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v docker >/dev/null 2>&1 || { echo "需要先安装 Docker"; exit 1; }
docker compose version >/dev/null 2>&1 || { echo "需要 Docker Compose v2（docker compose 子命令）"; exit 1; }

mkdir -p .download
cd .download

git clone --depth=1 https://github.com/DuarteSantos8/openGym
cd openGym
cp .env.example .env
docker compose pull
docker compose up -d
docker compose ps
echo "部署完成：打开 http://localhost:8080"

echo ""

echo "部署完成：打开 [http://localhost:8080](http://localhost:8080)，点 Create profile 建一个档案就能开始记录"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/DuarteSantos8/openGym/blob/main/docs/SELF_HOSTING.md"
