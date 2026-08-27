@echo off
setlocal enabledelayedexpansion

echo ============================================
echo    AI 爆款文章创作器 - 一键启动
echo ============================================
echo.

rem ---- 1. 检查/启动 Docker Desktop ----
docker info >nul 2>&1
if %errorlevel% equ 0 (
    echo [1/4] Docker 已在运行
    goto workdir
)
echo [1/4] 正在启动 Docker Desktop...
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
echo       等待 Docker 就绪（首次约 30-60 秒）...
set /a n=0
:wait_docker
ping -n 4 127.0.0.1 >nul
docker info >nul 2>&1
if !errorlevel! equ 0 goto workdir
set /a n+=1
if !n! geq 120 goto docker_timeout
goto wait_docker

:workdir
cd /d "%~dp0"
echo [2/4] 工作目录: %cd%
echo.

rem ---- 2. 启动容器 ----
echo [3/4] 启动服务容器...
docker compose up -d
if !errorlevel! neq 0 goto compose_fail
echo.

rem ---- 3. 等待就绪 ----
echo [4/4] 等待服务就绪（约 30-60 秒）...
set /a n=0
:wait_backend
ping -n 4 127.0.0.1 >nul
curl -sf http://localhost:8123/api/health/ >nul 2>&1
if !errorlevel! equ 0 goto ready
set /a n+=1
if !n! geq 40 goto ready
goto wait_backend

:ready
echo.
echo 正在打开浏览器...
start http://localhost
echo.
echo ============================================
echo   完成！页面地址: http://localhost
echo   登录账号: admin / 12345678
echo   如未自动打开请手动访问 http://localhost
echo ============================================
echo.
pause
exit /b 0

:compose_fail
echo.
echo [错误] 容器启动失败，请查看上方报错信息。
pause
exit /b 1

:docker_timeout
echo.
echo [错误] Docker 启动超时，请手动打开 Docker Desktop 后再运行本脚本。
pause
exit /b 1
