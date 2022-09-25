
**Если** эти 2 регистра **включены** (значение **0x1** ), то пользователи с любыми привилегиями могут **устанавливать** (выполнять) `*.msi`файлы как NT AUTHORITY\ **SYSTEM** .

```
reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
```