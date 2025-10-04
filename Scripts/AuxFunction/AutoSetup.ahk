#Requires AutoHotkey v2.0

; AutoSetup.ahk
; Automatically creates required configuration files if they don't exist
; Useful when running as compiled .exe on a new system

EnsureRequiredFilesExist() {
    scriptDir := A_ScriptDir
    
    ; Create config.ini if it doesn't exist
    configFile := scriptDir . "\config.ini"
    if (!FileExist(configFile)) {
        defaultConfig := "
(
;UPDATE CONFIG BASED ON ACTUAL PATHS

[AppLocations]
; Application and folder locations mapped to NumPad keys
mediashare=C:\Users\" . A_UserName . "\Documents

obsidian=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Obsidian.lnk
discord=C:\Users\" . A_UserName . "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk
zen=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Zen.lnk
reaper=C:\Users\" . A_UserName . "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\reaper.lnk
steam=C:\Users\" . A_UserName . "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\steam.lnk
vscode=C:\Users\" . A_UserName . "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Visual Studio Code\Visual Studio Code.lnk
explorer=C:\Windows\explorer.exe
clipstudiopaint=C:\Users\" . A_UserName . "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\CLIPStudioPaint.lnk
davinciresolve=C:\Users\" . A_UserName . "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Blackmagic Design\DaVinci Resolve\DaVinci Resolve.lnk
obs=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\OBS Studio\OBS Studio (64bit).lnk

[AppIdentifiers]
; Window identifiers for each application
discord=ahk_exe Discord.exe
obsidian=ahk_exe Obsidian.exe
zen=ahk_exe zen.exe
reaper=ahk_exe reaper.exe
steam=ahk_exe steam.exe
vscode=ahk_exe Code.exe
explorer=ahk_class CabinetWClass
clipstudiopaint=ahk_exe CLIPStudioPaint.exe
davinciresolve=ahk_exe Resolve.exe
obs=ahk_exe obs64.exe

[KeyboardSettings]
; AutoHotInterception keyboard settings
; IMPORTANT: Update these values for your keyboard!
; Run 'Monitor.ahk' to find your keyboard's vendor and product IDs
vendorId=0x0000
productId=0x0000
)"
        try {
            FileAppend(defaultConfig, configFile)
            MsgBox("Config file created at:`n" . configFile . "`n`nPlease update the KeyboardSettings section with your keyboard's Vendor ID and Product ID!", "First Run - Config Created", "Icon!")
        } catch as e {
            MsgBox("Failed to create config.ini: " . e.Message, "Error", "Icon!")
        }
    }
    
    ; Create keyconfig.ini if it doesn't exist
    keyconfigFile := scriptDir . "\keyconfig.ini"
    if (!FileExist(keyconfigFile)) {
        defaultKeyConfig := "
(
[KeyCodeMap]
; This is an actual comment line
;These should be read normally

; Numpad keys
82=NumPad0
79=NumPad1
80=NumPad2
81=NumPad3
75=NumPad4
76=NumPad5
77=NumPad6
71=NumPad7
72=NumPad8
73=NumPad9
325=NumLock
309=NumPad/
55=NumPad*
74=NumPad-
78=NumPad+
284=NumPadEnter
83=NumPad.

; F keys
59=F1
60=F2
61=F3
62=F4
63=F5
64=F6
65=F7
66=F8
67=F9
68=F10
87=F11
88=F12

; Main number row
41=~
2=1
3=2
4=3
5=4
6=5
7=6
8=7
9=8
10=9
11=0
12=-
13==
43=\
14=Backspace

; Tab-QWERTY row
15=Tab
16=Q
17=W
18=E
19=R
20=T
21=Y
22=U
23=I
24=O
25=P
26=[
27=]

; Caps-ASDF row
58=CapsLock
30=A
31=S
32=D
33=F
34=G
35=H
36=J
37=K
38=L
39=;
40='
28=Enter

; Shift-ZXCV row
42=Left Shift
44=Z
45=X
46=C
47=V
48=B
49=N
50=M
51=,
52=.
53=/
310=Right Shift

; Ctrl/Spacebar row
29=Left Ctrl
347=Windows
56=Left Alt
57=Space
312=Right Alt
348=Left Win
349=Menu
285=Right Ctrl

; Print screen(Transport) section
311=PrtSc
70=ScrLk
69=Pause
338=Insert
327=Home
329=Page Up
339=Delete
335=End
337=Page Down
328=Up
336=Down
331=Left
333=Right

; Special key for Escape
1=Esc
)"
        try {
            FileAppend(defaultKeyConfig, keyconfigFile)
        } catch as e {
            MsgBox("Failed to create keyconfig.ini: " . e.Message, "Error", "Icon!")
        }
    }
}
