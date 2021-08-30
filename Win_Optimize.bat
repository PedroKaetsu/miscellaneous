@echo off
:: BatchGotAdmin
::-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Solicitando privilégios administrativos...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
::--------------------------------------

title Optimization
echo Fazendo a mágica acontecer...
echo Por favor aguarde...

:: Kill Foreground
taskkill /F /IM "MicrosoftEdge.exe" 1>NUL 2>NUL
taskkill /F /IM "explorer.exe" 1>NUL 2>NUL

:: Disable metro boot menu
bcdedit /set {default} bootmenupolicy legacy 1>NUL 2>NUL

:: Add environmental variables
setx ProgramFiles "C:\Program Files" /m 1>NUL 2>NUL
setx ProgramFiles86 "C:\Program Files (x86)" /m 1>NUL 2>NUL
setx ProgramData "C:\ProgramData" /m 1>NUL 2>NUL

:: Hide PerfLogs folder
attrib "C:\PerfLogs" +h 1>NUL 2>NUL

:: Set Hibernation type to Reduced
powercfg /h /type reduced 1>NUL 2>NUL

::Set the 'Power Management' to High Performance
powercfg -SETACTIVE 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

::Disable Advanced Indexing 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "PreventUsingAdvancedIndexingOptions" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

:: Delete "Microsoft Edge" shortcut from Desktop
del /f /q "C:\Users\%USERNAME%\Desktop\Microsoft Edge.lnk" 1>NUL 2>NUL

:: Delete "Your Phone" shortcut from Desktop
del /f /q "C:\Users\%USERNAME%\Desktop\Your Phone.lnk" 1>NUL 2>NUL

:: Disable Your Phone Services
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushsvc" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL

:: Change Folder options
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowStatusBar" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Enable Peek at desktop
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisablePreviewDesktop" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable Windows Defender SmartScreen Filter
reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable first login animation
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableFirstLogonAnimation" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable all Content Delivery Manager features
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "FeatureManagementEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314563Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable Slideshow during Lock Screen
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Lock Screen" /v "SlideshowEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable all suggested apps
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "22StokedOnIt.NotebookPro_ffs55s3hze5sr" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "2FE3CB00.PicsArt-PhotoStudio_crhqpqs3x1ygc" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "41038Axilesoft.ACGMediaPlayer_wxjjre7dryqb6" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "5CB722CC.SeekersNotesMysteriesofDarkwood_ypk0bew5psyra" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "7458BE2C.WorldofTanksBlitz_x4tje2y229k00" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "828B5831.HiddenCityMysteryofShadows_ytsefhwckbdv6" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "828B5831.TheSecretSociety-HiddenMystery_ytsefhwckbdv6" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "89006A2E.AutodeskSketchBook_tf1gferkr813w" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "9E2F88E3.Twitter_wgeqdkkx372wm" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "A278AB0D.AsphaltStreetStormRacing_h6adky7gbf63m" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "A278AB0D.DisneyMagicKingdoms_h6adky7gbf63m" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "A278AB0D.DragonManiaLegends_h6adky7gbf63m" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "A278AB0D.MarchofEmpires_h6adky7gbf63m" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "AdobeSystemsIncorporated.PhotoshopElements2018_ynb6jyjzte8ga" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "CAF9E577.Plex_aam28m9va5cke" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "DolbyLaboratories.DolbyAccess_rz1tebttyb220" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Drawboard.DrawboardPDF_gqbn7fs4pywxm" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Expedia.ExpediaHotelsFlightsCarsActivities_0wbx8rnn4qk5c" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Facebook.317180B0BB486_8xx8rvfyw5nnt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Facebook.Facebook_8xx8rvfyw5nnt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Facebook.InstagramBeta_8xx8rvfyw5nnt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Fitbit.FitbitCoach_6mqt6hf9g46tw" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "flaregamesGmbH.RoyalRevolt2_g0q0z3kw54rap" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "GAMELOFTSA.Asphalt8Airborne_0pp20fcewvvtj" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "king.com.BubbleWitch3Saga_kgqvnymyfvs32" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "king.com.CandyCrushSaga_kgqvnymyfvs32" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "king.com.CandyCrushSodaSaga_kgqvnymyfvs32" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.AgeCastles_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.BingNews_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.BingSports_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.BingWeather_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "microsoft.microsoftskydrive_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.MinecraftUWP_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.MSPaint_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "NAVER.LINEwin8_8ptj331gd3tyt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Nordcurrent.CookingFever_m9bz608c1b9ra" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "SiliconBendersLLC.Sketchable_r2kxzpx527qgj" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "SpotifyAB.SpotifyMusic_zpdnekdrzrea0" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "ThumbmunkeysLtd.PhototasticCollage_nfy108tqq3p12" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "USATODAY.USATODAY_wy7mw3214mat8" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "WinZipComputing.WinZipUniversal_3ykzqggjzj4z0" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable Gamebar
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CursorCaptureEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "MicrophoneCaptureEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable Game Mode
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable Network Location Wizard prompts
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" /f 1>NUL 2>NUL

:: Change Performance Options to Adjust for best performance
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "2" /f 1>NUL 2>NUL

:: Disable Aero Shake
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisallowShaking" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

:: Disable "Look for an app in the Store" dialogue
reg add "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "NoUseStoreOpenWith" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

:: Disable "You have new apps that can open this type of file" notification
reg add "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "NoNewAppAlert" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

:: Disable "Windows protected your PC" dialogue
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

:: Disable Error Reporting
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

:: Disable Cortana
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Windows Search" /v "CortanaConsent" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "DisableVoice" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

:: Disable online tips in Settings
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "AllowOnlineTips" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable suggested apps Windows Ink WorkSpace
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" /v "PenWorkspaceAppSuggestionsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Classes\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}" /v "AllowSuggestedAppsInWindowsInkWorkspace" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable Sharing of handwriting data
reg add "HKLM\Software\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

:: Disable Sharing of handwriting error reports
reg add "HKLM\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

:: Disable Inventory Collector
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

:: Disable Camera in login screen
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\AccessPage\Camera" /v "CameraEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable Advertising ID
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Id" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Id" /f 1>NUL 2>NUL

:: Disable transmission of typing information
reg add "HKCU\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable Microsoft conducting experiments with this machine
reg add "HKLM\Software\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable advertisements via Bluetooth
reg add "HKLM\Software\Microsoft\PolicyManager\current\device\Bluetooth" /v "AllowAdvertising" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable Windows Customer Experience Improvement Program
reg add "HKLM\Software\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable syncing of text messages to Microsoft
reg add "HKLM\Software\Policies\Microsoft\Windows\Messaging" /v "AllowMessageSync" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable user steps recorder
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

:: Disable synchronization of all settings to Microsoft
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d "5" /f 1>NUL 2>NUL

:: Disable updates for Speech Recognition and Speech Synthesis
reg add "HKLM\Software\Microsoft\Speech_OneCore\Preferences" /v "ModelDownloadAllowed" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Speech" /v "AllowSpeechModelUpdate" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable functionality to locate the system
reg add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

:: Disable peer-to-peer functionality in Windows Update
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable ads in File Explorer and OneDrive
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable feedback reminders
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Remove Search/Cortana from taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Remove Task View button from taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Remove People buttom from taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable Timeline
reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Enable clipboard history
reg add "HKCU\Software\Microsoft\Clipboard" /v "EnableClipboardHistory" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

:: Disable Open File security warning
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1806" /t "REG_DWORD" /d "00000000" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1806" /t "REG_DWORD" /d "00000000" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\Security" /v "DisableSecuritySettingsCheck" /t "REG_DWORD" /d "00000001" /f 1>NUL 2>NUL

:: Remove "Edit with photos" from context menus
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "ActivatableClassId" /t REG_SZ /d "App.AppX65n3t4j73ch7cremsjxn7q8bph1ma8jw.mca" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "PackageId" /t REG_SZ /d "Microsoft.Windows.Photos_2017.18062.12990.0_x64__8wekyb3d8bbwe" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "ContractId" /t REG_SZ /d "Windows.File" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "DesiredInitialViewState" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "" /t REG_SZ /d "@{Microsoft.Windows.Photos_2017.18062.12990.0_x64__8wekyb3d8bbwe?ms-resource://Microsoft.Windows.Photos/Resources/EditWithPhotos}" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "ProgrammaticAccessOnly" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit\command" /v "DelegateExecute" /t REG_SZ /d "{4ED3A719-CEA8-4BD9-910D-E252F997AFC2}" /f 1>NUL 2>NUL

:: Remove "Edit with Paint 3D" from context menus
reg delete "HKLM\Software\Classes\SystemFileAssociations\.bmp\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.jpeg\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.jpe\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.jpg\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.png\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.gif\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.tif\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.tiff\Shell\3D Edit" /f 1>NUL 2>NUL

:: Disable Microsoft Edge prelaunching
reg add "HKCU\Software\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v "AllowPrelaunch" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Disable Microsoft Edge tab preloading
reg add "HKCU\Software\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v "AllowTabPreloading" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Remove acrylic blur on sign-in screen
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "DisableAcrylicBackgroundOnLogon" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

:: Remove potential bloat
powershell.exe "Get-AppxPackage *Microsoft.3DBuilder* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Appconnector* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.BingFinance* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.BingNews* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.BingSports* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.BingTranslator* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.FreshPaint* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.DesktopAppInstaller* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.MicrosoftPowerBIForWindows* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.MinecraftUWP* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.NetworkSpeedTest* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.WindowsPhone* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.CommsPhone* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.ConnectivityStore* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Office.Sway* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.BingFoodAndDrink* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.BingTravel* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.BingHealthAndFitness* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *9E2F88E3.Twitter* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *PandoraMediaInc.29680B314EFC2* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Flipboard.Flipboard* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *ShazamEntertainmentLtd.Shazam* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *king.com.CandyCrushSaga* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *king.com.CandyCrushSodaSaga* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *king.com.* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *ClearChannelRadioDigital.iHeartRadio* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *4DF9E0F8.Netflix* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *6Wunderkinder.Wunderlist* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Drawboard.DrawboardPDF* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *22StokedOnIt.NotebookPro* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *2FE3CB00.PicsArt-PhotoStudio* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *41038Axilesoft.ACGMediaPlayer* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *5CB722CC.SeekersNotesMysteriesofDarkwood* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *7458BE2C.WorldofTanksBlitz* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *D52A8D61.FarmVille2CountryEscape | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *TuneIn.TuneInRadio* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *GAMELOFTSA.Asphalt8Airborne* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *TheNewYorkTimes.NYTCrossword* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *DB6EA5DB.CyberLinkMediaSuiteEssentials* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Facebook.Facebook* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *flaregamesGmbH.RoyalRevolt2* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Playtika.CaesarsSlotsFreeCasino* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *A278AB0D.MarchofEmpires* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *KeeperSecurityInc.Keeper* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *ThumbmunkeysLtd.PhototasticCollage* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *INGAG.XING* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *89006A2E.AutodeskSketchBook* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *D5EA27B7.Duolingo-LearnLanguagesforFree* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *46928bounde.EclipseManager* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *ActiproSoftwareLLC.562882FEEB49* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *DolbyLaboratories.DolbyAccess* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *SpotifyAB.SpotifyMusic* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *A278AB0D.DisneyMagicKingdoms* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *WinZipComputing.WinZipUniversal* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.MSPaint* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Office.OneNote* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.OneConnect* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.People* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Print3D* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Wallet* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Windows.Photos* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.WindowsAlarms* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.WindowsCamera* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.windowscommunicationsapps* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.WindowsMaps* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.XboxApp* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Xbox.TCUI* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.ZuneVideo* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *828B5831.HiddenCityMysteryofShadows* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *king.com.BubbleWitch3Saga* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Fitbit.FitbitCoach* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Facebook.InstagramBeta* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Facebook.317180B0BB486* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Expedia.ExpediaHotelsFlightsCarsActivities* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *CAF9E577.Plex* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *AdobeSystemsIncorporated.PhotoshopElements2018* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *A278AB0D.DragonManiaLegends* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *A278AB0D.AsphaltStreetStormRacing* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *828B5831.TheSecretSociety-HiddenMystery* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *USATODAY.USATODAY* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *SiliconBendersLLC.Sketchable* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Nordcurrent.CookingFever* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *NAVER.LINEwin8* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *microsoft.microsoftskydrive* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.AgeCastles* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.ScreenSketch* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.WebMediaExtensions* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage"

:: Remove potential bloat for new users
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.DesktopAppInstaller* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.3DBuilder* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Appconnector* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.BingFinance* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.BingNews* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.BingSports* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.BingTranslator* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.BingWeather* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.FreshPaint* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.DesktopAppInstaller* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Getstarted* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.GetHelp* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Messaging* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Microsoft3DViewer* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.MicrosoftOfficeHub* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.MicrosoftPowerBIForWindows* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.MicrosoftStickyNotes* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.MinecraftUWP* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.NetworkSpeedTest* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.WindowsPhone* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.CommsPhone* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.ConnectivityStore* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Office.Sway* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.BingFoodAndDrink* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.BingTravel* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.BingHealthAndFitness* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *9E2F88E3.Twitter* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *PandoraMediaInc.29680B314EFC2* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Flipboard.Flipboard* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *ShazamEntertainmentLtd.Shazam* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *king.com.CandyCrushSaga* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *king.com.CandyCrushSodaSaga* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *king.com.* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *ClearChannelRadioDigital.iHeartRadio* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *4DF9E0F8.Netflix* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *6Wunderkinder.Wunderlist* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Drawboard.DrawboardPDF* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *22StokedOnIt.NotebookPro* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *2FE3CB00.PicsArt-PhotoStudio* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *41038Axilesoft.ACGMediaPlayer* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *5CB722CC.SeekersNotesMysteriesofDarkwood* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *7458BE2C.WorldofTanksBlitz* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *D52A8D61.FarmVille2CountryEscape | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *TuneIn.TuneInRadio* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *GAMELOFTSA.Asphalt8Airborne* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *TheNewYorkTimes.NYTCrossword* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *DB6EA5DB.CyberLinkMediaSuiteEssentials* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Facebook.Facebook* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *flaregamesGmbH.RoyalRevolt2* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Playtika.CaesarsSlotsFreeCasino* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *A278AB0D.MarchofEmpires* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *KeeperSecurityInc.Keeper* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *ThumbmunkeysLtd.PhototasticCollage* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *INGAG.XING* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *89006A2E.AutodeskSketchBook* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *D5EA27B7.Duolingo-LearnLanguagesforFree* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *46928bounde.EclipseManager* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *ActiproSoftwareLLC.562882FEEB49* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *DolbyLaboratories.DolbyAccess* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *SpotifyAB.SpotifyMusic* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *A278AB0D.DisneyMagicKingdoms* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *WinZipComputing.WinZipUniversal* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.MSPaint* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Office.OneNote* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.OneConnect* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.People* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Print3D* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.SkypeApp* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Wallet* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Windows.Photos* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.WindowsAlarms* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.WindowsCamera* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.windowscommunicationsapps* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.WindowsFeedbackHub* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.WindowsMaps* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.WindowsSoundRecorder* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.XboxApp* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Xbox.TCUI* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.ZuneMusic* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.ZuneVideo* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *828B5831.HiddenCityMysteryofShadows* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *king.com.BubbleWitch3Saga* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Fitbit.FitbitCoach* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Facebook.InstagramBeta* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Facebook.317180B0BB486* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Expedia.ExpediaHotelsFlightsCarsActivities* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *CAF9E577.Plex* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *AdobeSystemsIncorporated.PhotoshopElements2018* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *A278AB0D.DragonManiaLegends* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *A278AB0D.AsphaltStreetStormRacing* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *828B5831.TheSecretSociety-HiddenMystery* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *USATODAY.USATODAY* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *SiliconBendersLLC.Sketchable* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Nordcurrent.CookingFever* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *NAVER.LINEwin8* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *microsoft.microsoftskydrive* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.AgeCastles* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.ScreenSketch* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.YourPhone* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.WebMediaExtensions* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.MixedReality.Portal* | Remove-AppxProvisionedPackage -Online"

:: Disable telemetry
reg add "HKLM\SYSTEM\ControlSet001\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\ControlSet001\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

:: Countdown
cls
for %%r in (5 4 3 2 1) do (
echo Restarting in %%r...
timeout 1 1>NUL 2>NUL
cls
)

:: Force restart
shutdown /r /f /t 0
