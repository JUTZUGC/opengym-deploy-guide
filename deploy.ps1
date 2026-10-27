# openGym Docker 部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/DuarteSantos8/openGym/blob/main/docs/SELF_HOSTING.md
# 更新日期：2026-10-27
# 类型：docker
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

foreach ($cmd in @('git', 'docker')) {
  if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) { throw "需要先安装 $cmd" }
}
docker compose version | Out-Null
if ($LASTEXITCODE -ne 0) { throw '需要 Docker Compose v2（docker compose 子命令）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

git clone --depth=1 https://github.com/DuarteSantos8/openGym
Set-Location openGym
Copy-Item .env.example .env
docker compose pull
docker compose up -d
docker compose ps
Write-Host '部署完成：打开 http://localhost:8080'

Write-Host ''

Write-Host '部署完成：打开 [http://localhost:8080](http://localhost:8080)，点 Create profile 建一个档案就能开始记录'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/DuarteSantos8/openGym/blob/main/docs/SELF_HOSTING.md'
