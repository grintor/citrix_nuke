::------------------------------------------------------
:: regular uninstall
::------------------------------------------------------

for /f "tokens=2*" %%a in ('reg query HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\CitrixOnlinePluginPackWeb /v UninstallString 2^>nul') do (
   for /f "tokens=1 delims=/" %%c in ("%%b") do start /wait "" "%%c" /uninstall /cleanup /silent /noreboot
)

for /f "tokens=2*" %%a in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CitrixOnlinePluginPackWeb /v UninstallString 2^>nul') do (
   for /f "tokens=1 delims=/" %%c in ("%%b") do start /wait "" "%%c" /uninstall /cleanup /silent /noreboot
)

::------------------------------------------------------
:: official cleanup utility
::------------------------------------------------------

ReceiverCleanupUtility.exe  /silent /noreboot

::------------------------------------------------------
:: delete registration by official installed MSI CLSID's
::------------------------------------------------------

for /f %%n in ('wmic product where "name like 'Citrix Authentication Manager' or name like 'Citrix Receiver Inside' or name like 'Citrix Receiver(Aero)' or name like 'Citrix Receiver(DV)' or name like 'Citrix Receiver (HDX Flash Redirection)' or name like 'Citrix Receiver(USB)' or name like 'Online Plug-in' or name like 'Citrix Web Helper'" get identifyingnumber ^| find "}"') do call :del_by_CLSID %%n

::------------------------------------------------------
:: go crazy and start deleting anything that looks like citrix from the registry
:: https://support.citrix.com/article/CTX212773
::------------------------------------------------------

call :del_product_reg Online Plug-in
call :del_product_reg Citrix Authentication Manager
call :del_product_reg Citrix Receiver Inside
call :del_product_reg Citrix Receiver(Aero)
call :del_product_reg Citrix Receiver(DV)
call :del_product_reg Citrix Receiver (HDX Flash Redirection)
call :del_product_reg Citrix Receiver(USB)
call :del_product_reg Citrix Web Helper

::-----------------------------------------------------
:: go even more crazy
:: https://support.citrix.com/article/CTX325140
::-----------------------------------------------------

for /f %%n in ('reg query hkcr ^| find "\Citrix.ICAClient"') do reg delete %%n /f
for /f %%n in ('reg query hkcr ^| find "\Citrix.ICAClientProp"') do reg delete %%n /f
reg delete hkcr\ica /f
for /f %%n in ('reg query hkcr\CLSID ^| find "{238F"') do reg delete %%n /f
reg delete hkcr\Installer\UpgradeCodes\9B123F490B54521479D0EDD389BCACC1 /f
reg delete hkcr\Installer\UpgradeCodes\9B123F490B54521479D0EDD389BCACC1 /f
reg delete "hkcr\Mime\Database\Content Type\application/x-ica" /f
reg delete hkcr\Wfica /f
reg delete hkcr\WinFrameICA /f
reg delete "hkcr\ICA Client" /f

reg delete "hkcu\SOFTWARE\Citrix\ICA Client" /f
reg delete "hkcu\SOFTWARE\Citrix\PNAgent" /f
reg delete "hkcu\SOFTWARE\Citrix\Dazzle" /f
reg delete "hkcu\SOFTWARE\Citrix\PrinterProperties" /f
reg delete "hkcu\SOFTWARE\Citrix\Receiver" /f
reg delete "hkcu\SOFTWARE\Citrix\XenDesktop\DesktopViewer" /f

reg delete "HKEY_USERS\.DEFAULT\Software\Citrix\ICA Client" /f
reg delete "HKEY_USERS\.DEFAULT\Software\Citrix\PNAgent" /f
reg delete "HKEY_USERS\.DEFAULT\Software\Citrix\Dazzle" /f
reg delete "HKEY_USERS\.DEFAULT\Software\Citrix\PrinterProperties" /f
reg delete "HKEY_USERS\.DEFAULT\Software\Citrix\Receiver" /f
reg delete "HKEY_USERS\.DEFAULT\Software\Citrix\XenDesktop\DesktopViewer" /f

reg delete "hklm\SOFTWARE\Citrix\AuthManager" /f
reg delete "hklm\SOFTWARE\Citrix\CitrixCAB" /f
reg delete "hklm\SOFTWARE\Citrix\Dazzle" /f
reg delete "hklm\SOFTWARE\Citrix\ICA Client" /f
reg delete "hklm\SOFTWARE\Citrix\ReceiverInside" /f
reg delete "hklm\SOFTWARE\Citrix\PNAgent" /f
reg delete "hklm\SOFTWARE\Citrix\PluginPackages\XenAppSuite" /f
reg delete "hklm\SOFTWARE\Citrix\XenDesktop\DesktopViewer" /f

reg delete "hklm\SOFTWARE\Citrix\Install\{94F321B9-45B0-4125-970D-DE3D98CBCA1C}" /f
reg delete "hklm\SOFTWARE\Citrix\Install\ICA Client" /f
reg delete "hklm\SOFTWARE\Citrix\Install\PNAgent" /f
reg delete "hklm\SOFTWARE\Citrix\Install\DesktopViewer" /f
reg delete "hklm\SOFTWARE\Citrix\Install\ReceiverInsideForOnline" /f
reg delete "hklm\SOFTWARE\Citrix\Install\MUI" /f

reg delete "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CitrixOnlinePluginFull" /f
reg delete "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CitrixOnlinePluginPackWeb" /f

reg delete "hklm\SOFTWARE\Wow6432Node\Citrix\AuthManager" /f
reg delete "hklm\SOFTWARE\Wow6432Node\Citrix\CitrixCAB" /f
reg delete "hklm\SOFTWARE\Wow6432Node\Citrix\Dazzle" /f
reg delete "hklm\SOFTWARE\Wow6432Node\Citrix\ICA Client" /f
reg delete "hklm\SOFTWARE\Wow6432Node\Citrix\ReceiverInside" /f
reg delete "hklm\SOFTWARE\Wow6432Node\Citrix\PNAgent" /f
reg delete "hklm\SOFTWARE\Wow6432Node\Citrix\PluginPackages\XenAppSuite" /f
reg delete "hklm\SOFTWARE\Wow6432Node\Citrix\XenDesktop\DesktopViewer" /f

reg delete "hklm\SOFTWARE\Wow6432Node\Citrix\Install\{94F321B9-45B0-4125-970D-DE3D98CBCA1C}" /f
reg delete "hklm\SOFTWARE\Wow6432Node\Citrix\Install\ICA Client" /f
reg delete "hklm\SOFTWARE\Wow6432Node\Citrix\Install\PNAgent" /f
reg delete "hklm\SOFTWARE\Wow6432Node\Citrix\Install\DesktopViewer" /f
reg delete "hklm\SOFTWARE\Wow6432Node\Citrix\Install\ReceiverInsideForOnline" /f
reg delete "hklm\SOFTWARE\Wow6432Node\Citrix\Install\MUI" /f

reg delete "hklm\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\CitrixOnlinePluginFull" /f
reg delete "hklm\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\CitrixOnlinePluginPackWeb" /f

reg delete "hklm\Software\Policies\Citrix\ICA Client" /f
reg delete "hkcu\Software\Policies\Citrix\ICA Client" /f
reg delete "hklm\Software\Wow6432Node\Policies\Citrix\ICA Client" /f


::-------------------------------------------------
goto :EOF
:del_product_reg
for /f %%a in ('reg query hkcr\installer\products') do (
   for /f %%h in ('reg query %%a /v ProductName 2^>nul ^| find "%*"') do (
      for /f "tokens=4 delims=\" %%q in ('echo %%a') do (
         reg delete HKEY_CLASSES_ROOT\Installer\Products\%%q /f
         reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Installer\Products\%%q /f
      )
   )
   
)
goto :EOF


::-------------------------------------------------
goto :EOF
:del_by_CLSID
set CLSID=%1
set CLSID=%CLSID:}=%
set CLSID=%CLSID:{=%
set CLSID=%CLSID:-=%
:: https://support.citrix.com/article/CTX212773
reg delete HKEY_CLASSES_ROOT\Installer\Products\%CLSID% /f
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Installer\Products\%CLSID% /f
goto :EOF
