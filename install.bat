@echo off
cls
title Instalador controle
echo =================================================
echo Pedindo permisao do admin...
echo =================================================
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
echo Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
echo args = "ELEV " >> "%vbsGetPrivileges%"
echo For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
echo args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
echo Next >> "%vbsGetPrivileges%"
echo UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
goto b

:exit
exit

:b
cls
echo =================================================
echo [X] Permisao do admin
echo [X] Verificando aplicacoes
echo [X] Deletar arquivos temp do roblox
echo [X] Baixar
echo [+] Instalar
echo [-] Deletar arquivos temp do roblox
echo [-] Desfrute
echo =================================================
ping localhost -n 5 > nul
cd /d "%~dp0"
copy /y "*.*" "C:\Program Files (x86)\Roblox\Versions\version-b117c4c276664452"
cls
echo =================================================
echo [X] Permisao do admin
echo [X] Verificando aplicacoes
echo [X] Deletar arquivos temp do roblox
echo [X] Baixar
echo [X] Instalar
echo [+] Deletar arquivos temp do roblox
echo [-] Desfrute
echo =================================================
ping localhost -n 5 > nul
cd /d "%~dp0"
cd ..
echo O programa saira sozinho
ping localhost -n 5 > nul
rd /s /q "Joy-Stick-roblox"
exit
