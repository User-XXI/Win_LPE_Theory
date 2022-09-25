wmic service list brief

./accesschk.exe -ucqv RemoteRegistry
./accesschk.exe -ucqv TermService
./accesschk.exe -ucqv SSDPSRV
./accesschk.exe -ucqv Shedule
./accesschk.exe -ucqv Telnet
./accesschk.exe -ucqv Seclogon



accesschk.exe -uwcqv "Users" * /accepteula

reg query HKEY_CURRENT_USER\Software\OpenSSH\Agent\Keys

reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated

reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\LSA /v RunAsPPL

reg query HKLM\System\CurrentControlSet\Control\LSA /v LsaCfgFlags

reg query "HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION\WINLOGON" /v CACHEDLOGONSCOUNT

reg query HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\

reg query hklm\System\CurrentControlSet\Services /s /v imagepath #Get the binary paths of the services

get-acl HKLM:\System\CurrentControlSet\services\* | Format-List * | findstr /i "<Username> Users Path Everyone"