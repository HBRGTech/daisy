@ECHO OFF
set HOMEDRIVE=C:
set HOMEPATH=\Users\%USERNAME%
set HOME

powershell -ExecutionPolicy Bypass -command "%~dp0\daisy-init.ps1"