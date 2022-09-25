Посмотреть в **Powershell версию Windows** можно с помощью

```
Get-ComputerInfo
```

```
Get-ComputerInfo -Property *Version*
```

```
(Get-ComputerInfo).WindowsVersion
```

```
Get-WmiObject -Class Win32_OperatingSystem | fl -Property Version, BuildNumber
```