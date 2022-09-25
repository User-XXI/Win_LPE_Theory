## Защита LSA

Microsoft в **Windows 8.1 и более поздних версиях** предоставила дополнительную защиту для LSA, чтобы **предотвратить** **чтение памяти** или внедрение кода ненадежными процессами . [**Подробнее о защите LSA здесь**](/windows-hardening/stealing-credentials/credentials-protections#lsa-protection) .

```
reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\LSA /v RunAsPPL
```

## Охранник учетных данных

**Credential Guard** — это новая функция в Windows 10 (выпуск Enterprise и Education), которая помогает защитить ваши учетные данные на компьютере от таких угроз, как передача хэша.

```
reg query HKLM\System\CurrentControlSet\Control\LSA /v LsaCfgFlags
```

## Кэшированные учетные данные

**Учетные данные домена** используются компонентами операционной системы и **аутентифицируются** **локальным** администратором **безопасности** (LSA). Как правило, учетные данные домена устанавливаются для пользователя, когда зарегистрированный пакет безопасности аутентифицирует данные входа пользователя. [**Подробнее о кэшированных учетных данных здесь**](/windows-hardening/stealing-credentials/credentials-protections#cached-credentials) .

```
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION\WINLOGON" /v CACHEDLOGONSCOUNT
```

## UAC

UAC используется для того, чтобы **пользователь-администратор не давал права администратора каждому выполняемому процессу** . Это **достигается использованием по умолчанию** **маркера пользователя** с низкими привилегиями . [**Подробнее о UAC здесь**](/windows-hardening/authentication-credentials-uac-and-efs#uac) .

```
reg query HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\
```