@echo off
setlocal enabledelayedexpansion
title Global Internet VPN

:: فعال‌سازی رنگ ANSI (ویندوز ۱۰+)
reg add "HKCU\Console" /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

set "R=[0m"
set "GRN=[92m"
set "RED=[91m"
set "YEL=[93m"
set "CYN=[96m"
set "BLU=[94m"
set "WHT=[97m"
set "DIM=[2m"
set "BOLD=[1m"

:: مسیرها (نسبت به محل bat — همیشه داخل پوشه پروژه)
cd /d "%~dp0"
set "PROJECT_DIR=%~dp0"
set "PROJECT_DIR=%PROJECT_DIR:~0,-1%"
set "VENV_DIR=%PROJECT_DIR%\.venv"
set "VPY=%VENV_DIR%\Scripts\python.exe"
set "VPIP=%VENV_DIR%\Scripts\pip.exe"
set "CONFIG=%PROJECT_DIR%\config.json"
set "SHORTCUT=%USERPROFILE%\Desktop\Global Internet VPN.lnk"
set "PROXY=127.0.0.1:8085"

cls
echo.
echo %BLU%%BOLD%  ╔══════════════════════════════════════════╗%R%
echo %BLU%%BOLD%  ║      🌐  Global Internet VPN             ║%R%
echo %BLU%%BOLD%  ╚══════════════════════════════════════════╝%R%
echo.

:: ── چک ۱: main.py موجوده؟ (مطمئن بشیم داخل پروژه هستیم) ──
if not exist "%PROJECT_DIR%\main.py" (
    echo   %RED%✗ خطا: این فایل باید داخل پوشه پروژه باشه!%R%
    echo   %YEL%  Global-Internet.bat رو کنار main.py بذار.%R%
    goto :ERROR_EXIT
)

:: ── چک ۲: Python ──
echo %CYN%%BOLD%  [۱/۴]%R% %WHT%بررسی Python...%R%

set "PY="
where py >nul 2>&1 && set "PY=py -3"
if "!PY!"=="" (
    where python >nul 2>&1 && set "PY=python"
)
if "!PY!"=="" (
    echo   %RED%✗ Python پیدا نشد!%R%
    echo.
    echo   %WHT%  دانلود: https://www.python.org/downloads/%R%
    echo   %DIM%  نکته: موقع نصب تیک "Add Python to PATH" رو بزن%R%
    goto :ERROR_EXIT
)
echo   %GRN%✓ Python پیدا شد%R%
echo.

:: ── چک ۳: venv و وابستگی‌ها ──
echo %CYN%%BOLD%  [۲/۴]%R% %WHT%بررسی محیط Python...%R%

if not exist "%VPY%" (
    echo   %DIM%    در حال ساخت virtual environment...%R%
    !PY! -m venv "%VENV_DIR%"
    if errorlevel 1 (
        echo   %RED%✗ ساخت venv شکست خورد!%R%
        goto :ERROR_EXIT
    )
    echo   %GRN%✓ Virtual environment ساخته شد%R%
) else (
    echo   %GRN%✓ Virtual environment موجود است%R%
)

:: بروزرسانی pip
"%VPY%" -m pip install --disable-pip-version-check -q --upgrade pip >nul 2>&1

:: چک وابستگی‌ها با import سریع (بدون pip اضافه)
"%VPY%" -c "import cryptography, h2, brotli, zstandard" >nul 2>&1
if errorlevel 1 (
    echo   %DIM%    در حال نصب وابستگی‌ها — چند دقیقه صبر کن...%R%
    "%VPY%" -m pip install --disable-pip-version-check -q -r requirements.txt
    if errorlevel 1 (
        echo   %YEL%  آینه جایگزین را امتحان می‌کند...%R%
        "%VPY%" -m pip install --disable-pip-version-check -q -r requirements.txt ^
            -i https://mirror-pypi.runflare.com/simple/ ^
            --trusted-host mirror-pypi.runflare.com
        if errorlevel 1 (
            echo   %RED%✗ نصب وابستگی‌ها شکست خورد!%R%
            echo.
            echo   %YEL%  راه‌حل:%R%
            echo   %DIM%  ۱. یه VPN دیگه روشن کن تا pip به اینترنت وصل بشه%R%
            echo   %DIM%  ۲. Settings ← Network ← Proxy ← همه رو خاموش کن%R%
            echo   %DIM%  ۳. دوباره Global-Internet.bat رو اجرا کن%R%
            goto :ERROR_EXIT
        )
    )
    echo   %GRN%✓ وابستگی‌ها نصب شدند%R%
) else (
    echo   %GRN%✓ وابستگی‌ها آماده هستند%R%
)
echo.

:: ── چک ۴: config.json ──
echo %CYN%%BOLD%  [۳/۴]%R% %WHT%بررسی تنظیمات...%R%

if exist "%CONFIG%" (
    echo   %GRN%✓ config.json موجود است%R%
) else (
    echo   %YEL%  اولین اجرا — Setup Wizard شروع میشه...%R%
    echo.
    "%VPY%" setup.py
    if errorlevel 1 (
        echo   %RED%✗ Setup لغو شد یا خطا داد%R%
        goto :ERROR_EXIT
    )
    if not exist "%CONFIG%" (
        echo   %RED%✗ config.json ساخته نشد!%R%
        goto :ERROR_EXIT
    )
    echo   %GRN%✓ config.json ساخته شد%R%
)
echo.

:: ── میانبر دسکتاپ ──
echo %CYN%%BOLD%  [۴/۴]%R% %WHT%میانبر دسکتاپ...%R%

if not exist "%SHORTCUT%" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
        "$ws=New-Object -COM WScript.Shell; $s=$ws.CreateShortcut('%SHORTCUT%'); $s.TargetPath='%~f0'; $s.WorkingDirectory='%PROJECT_DIR%'; $s.Description='Global Internet VPN'; $s.WindowStyle=1; $s.Save()" >nul 2>&1
    if exist "%SHORTCUT%" (
        echo   %GRN%✓ میانبر روی دسکتاپ ساخته شد%R%
    ) else (
        echo   %YEL%⚠ میانبر ساخته نشد — مشکلی نیست%R%
    )
) else (
    echo   %GRN%✓ میانبر دسکتاپ موجود است%R%
)
echo.

:: ══════════════════════════════════════
::  اتصال — پروکسی ست کن و VPN رو شروع کن
:: ══════════════════════════════════════
echo %BLU%%BOLD%  ╔══════════════════════════════════════════╗%R%
echo %BLU%%BOLD%  ║      در حال اتصال به اینترنت آزاد...    ║%R%
echo %BLU%%BOLD%  ╚══════════════════════════════════════════╝%R%
echo.

:: ست کردن پروکسی سیستم ویندوز
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable    /t REG_DWORD /d 1            /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer    /t REG_SZ    /d "%PROXY%"    /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride  /t REG_SZ    /d "localhost;127.0.0.1;<local>" /f >nul 2>&1

:: اطلاع‌رسانی به ویندوز (بدون این، مرورگر باید restart بشه)
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Add-Type -TypeDefinition 'using System;using System.Runtime.InteropServices;public class W{[DllImport(\"wininet.dll\")]public static extern bool InternetSetOption(IntPtr h,int o,IntPtr b,int l);}';[W]::InternetSetOption([IntPtr]::Zero,39,[IntPtr]::Zero,0);[W]::InternetSetOption([IntPtr]::Zero,37,[IntPtr]::Zero,0);" >nul 2>&1

echo   %GRN%✓ HTTP Proxy  →  %PROXY%%R%
echo   %GRN%✓ SOCKS5      →  127.0.0.1:1080%R%
echo.
echo   %YEL%%BOLD%  ⚠ این پنجره رو باز نگه دار — بستن = قطع اتصال%R%
echo.
echo   %DIM%  ─────────────────── لاگ ──────────────────────%R%
echo.

:: اجرای VPN — اینجا بلاک میشه تا پنجره بسته بشه
"%VPY%" main.py

:: ══════════════════════════════════════
::  قطع اتصال — پاک کردن پروکسی
:: ══════════════════════════════════════
:CLEANUP
echo.
echo   %RED%  ────────────── اتصال قطع شد ─────────────────%R%
echo.

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0  /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ    /d "" /f >nul 2>&1

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Add-Type -TypeDefinition 'using System;using System.Runtime.InteropServices;public class W{[DllImport(\"wininet.dll\")]public static extern bool InternetSetOption(IntPtr h,int o,IntPtr b,int l);}';[W]::InternetSetOption([IntPtr]::Zero,39,[IntPtr]::Zero,0);[W]::InternetSetOption([IntPtr]::Zero,37,[IntPtr]::Zero,0);" >nul 2>&1

echo   %GRN%✓ پروکسی پاک شد — اینترنت معمولی برگشت%R%
echo.
echo   %DIM%  دفعه بعد روی میانبر دسکتاپ دوبار کلیک کن%R%
echo.
pause
exit /b 0

:ERROR_EXIT
echo.
echo   %RED%%BOLD%  ╔══════════════════════════════════════════╗%R%
echo   %RED%%BOLD%  ║   ✗  خطا — راه‌اندازی متوقف شد          ║%R%
echo   %RED%%BOLD%  ╚══════════════════════════════════════════╝%R%
echo.
echo   %YEL%  مشکل رو برطرف کن و دوباره اجرا کن.%R%
echo.
pause
exit /b 1
