@echo off
setlocal enabledelayedexpansion
 
:: 获取当前日期并格式化为MM/DD/YYYY
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do (
    set month=%%b
    set day=%%c
    set year=%%a
)
 
:: 检查日期格式是否正确
echo Current date: %month%/%day%/%year%
 
:: 检查注册表路径是否存在
reg query "HKEY_CURRENT_USER\Software\Typora" >nul 2>&1
if errorlevel 1 (
    echo The specified registry path does not exist. Please check the path.
    goto end
)
 
:: 更新注册表中的值
reg add "HKEY_CURRENT_USER\Software\Typora" /v IDate /t REG_SZ /d "%month%/%day%/%year%" /f
if errorlevel 0 (
    echo Successfully updated the registry value to %month%/%day%/%year%.
) else (
    echo Failed to update the registry value.
)
 
:end
pause
