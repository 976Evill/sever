@echo off
echo ===================================
echo  %0 started %DATE% %TIME%
echo ===================================


set remote_script_dir=/tmp
set remote_script=%remote_script_dir%/%script%

SET FILE_IPLIST="iplist.txt"

echounix -n "Checking file %FILE_IPLIST% ... "
if exist %FILE_IPLIST% (
	echounix "found"
	echounix "---- %FILE_IPLIST% ----"
	type %FILE_IPLIST%
	echounix "---- %FILE_IPLIST% ----"
) else (
	echounix "not found"
	goto error
)

echounix
echounix
echounix "============================================================"
echounix "checking hosts state - started"
setlocal enabledelayedexpansion
for /F %%i in (iplist.txt) do (
	echounix -n "%%i ... "
	echounix "yes" | plink -pw xxxxxx root@%%i echo -n
	IF !errorlevel! equ 0 (
		echounix -n "%%i is online, updating"
        call rssh-internal-1host.cmd %%i
        IF !ERRORLEVEL! neq 0 goto error
	) else (
		echounix "%%i is offline, skipped"
	)
)
endlocal
echounix "============================================================"
echounix
echounix


echo ===================================
echo  SUCCESS: %0 completed %DATE% %TIME%
echo ===================================
exit /B 0
GOTO end

:error
echo ===================================
echo  ERROR: %0 failed %DATE% %TIME%
echo ===================================
exit /B 1
:end





