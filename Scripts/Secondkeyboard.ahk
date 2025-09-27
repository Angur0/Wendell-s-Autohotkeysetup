#SingleInstance force
Persistent
#include "A:\autohotkey\AHK v2\Lib\AutoHotInterception.ahk"

;############### LOAD CONFIGURATION ########################
configFile := A_ScriptDir . "\config.ini"

; Load app locations from config
mediashareLocation := IniRead(configFile, "AppLocations", "mediashare", "")
obsidianLocation := IniRead(configFile, "AppLocations", "obsidian", "")
discordLocation := IniRead(configFile, "AppLocations", "discord", "")
zenLocation := IniRead(configFile, "AppLocations", "zen", "")
reaperLocation := IniRead(configFile, "AppLocations", "reaper", "")
steamLocation := IniRead(configFile, "AppLocations", "steam", "")
vscodeLocation := IniRead(configFile, "AppLocations", "vscode", "")
explorerLocation := IniRead(configFile, "AppLocations", "explorer", "")
clipstudiopaintLocation := IniRead(configFile, "AppLocations", "clipstudiopaint", "")
davinciresolveLocation := IniRead(configFile, "AppLocations", "davinciresolve", "")

; Load app identifiers from config
discordIdentifier := IniRead(configFile, "AppIdentifiers", "discord", "")
obsidianIdentifier := IniRead(configFile, "AppIdentifiers", "obsidian", "")
zenIdentifier := IniRead(configFile, "AppIdentifiers", "zen", "")
reaperIdentifier := IniRead(configFile, "AppIdentifiers", "reaper", "")
steamIdentifier := IniRead(configFile, "AppIdentifiers", "steam", "")
vscodeIdentifier := IniRead(configFile, "AppIdentifiers", "vscode", "")
explorerIdentifier := IniRead(configFile, "AppIdentifiers", "explorer", "")
clipstudiopaintIdentifier := IniRead(configFile, "AppIdentifiers", "clipstudiopaint", "")
davinciresolveIdentifier := IniRead(configFile, "AppIdentifiers", "davinciresolve", "")

; Load keyboard settings from config
vendorId := IniRead(configFile, "KeyboardSettings", "vendorId", "0x03F0")
productId := IniRead(configFile, "KeyboardSettings", "productId", "0x344A")

;############### INITIALIZE AUTOHOTINTERCEPTION ########################
AHI := AutoHotInterception()

keyboardId := AHI.GetKeyboardId(vendorId, productId)
AHI.SubscribeKeyboard(keyboardId, true, KeyEvent)


KeyEvent(code, state){
	if (state==1) && (code==82) ; NumPad0
	{
		; Open A:\MEDIA SHARE folder
		
	Run("explorer.exe `"" . mediashareLocation . "`"")
	}

	if (state==1) && (code==79) ; NumPad1
	{
		; Check if Obsidian is already running
		if WinExist(obsidianIdentifier)
		{
			; If it exists, activate it (bring to front)
			WinActivate(obsidianIdentifier)
		}
		else
		{
			; If not running, launch it and wait for it to open
			Run(obsidianLocation)
			; Wait for the window to appear (max 10 seconds)
			WinWait(obsidianIdentifier, , 10)
			; Activate it once it's open
			WinActivate(obsidianIdentifier)
		}
	}

	if (state==1) && (code==80) ; NumPad2
	{
  		; Check if Discord is already running
		if WinExist(discordIdentifier)
		{
			; If it exists, activate it (bring to front)
			WinActivate(discordIdentifier)
		}
		else
		{
			; If not running, launch it and wait for it to open
			Run(discordLocation)
			; Wait for the window to appear (max 10 seconds)
			WinWait(discordIdentifier, , 10)
			; Activate it once it's open
			WinActivate(discordIdentifier)
		}
	}

	if (state==1) && (code==81) ; NumPad3
	{
		; Check if Zen is already running
		if WinExist(zenIdentifier)
		{
			; If it exists, activate it (bring to front)
			WinActivate(zenIdentifier)
		}
		else
		{
			; If not running, launch it and wait for it to open
			Run(zenLocation)
			; Wait for the window to appear (max 10 seconds)
			WinWait(zenIdentifier, , 10)
			; Activate it once it's open
			WinActivate(zenIdentifier)
		}
	}

	if (state==1) && (code==75) ; NumPad4
	{
		; Check if Reaper is already running
		if WinExist(reaperIdentifier)
		{
			; If it exists, activate it (bring to front)
			WinActivate(reaperIdentifier)
		}
		else
		{
			; If not running, launch it and wait for it to open
			Run(reaperLocation)
			; Wait for the window to appear (max 10 seconds)
			WinWait(reaperIdentifier, , 10)
			; Activate it once it's open
			WinActivate(reaperIdentifier)
		}
	}

	if (state==1) && (code==76) ; NumPad5
	{
		; Check if Steam is already running
		if WinExist(steamIdentifier)
		{
			; If it exists, activate it (bring to front)
			WinActivate(steamIdentifier)
		}
		else
		{
			; If not running, launch it and wait for it to open
			Run(steamLocation)
			; Wait for the window to appear (max 10 seconds)
			WinWait(steamIdentifier, , 10)
			; Activate it once it's open
			WinActivate(steamIdentifier)
		}
	}

	if (state==1) && (code==77) ; NumPad6
	{
		; Check if VS Code is already running
		if WinExist(vscodeIdentifier)
		{
			; If it exists, activate it (bring to front)
			WinActivate(vscodeIdentifier)
		}
		else
		{
			; If not running, launch it and wait for it to open
			Run(vscodeLocation)
			; Wait for the window to appear (max 10 seconds)
			WinWait(vscodeIdentifier, , 10)
			; Activate it once it's open
			WinActivate(vscodeIdentifier)
		}
	}

	if (state==1) && (code==71) ; NumPad7
	{
		; Check if File Explorer is already running
		if WinExist(explorerIdentifier)
		{
			; If it exists, activate it (bring to front)
			WinActivate(explorerIdentifier)
		}
		else
		{
			; If not running, launch it and wait for it to open
			Run(explorerLocation)
			; Wait for the window to appear (max 10 seconds)
			WinWait(explorerIdentifier, , 10)
			; Activate it once it's open
			WinActivate(explorerIdentifier)
		}
	}

	if (state==1) && (code==72) ; NumPad8
	{
		; Check if Clip Studio Paint is already running
		if WinExist(clipstudiopaintIdentifier)
		{
			; If it exists, activate it (bring to front)
			WinActivate(clipstudiopaintIdentifier)
		}
		else
		{
			; If not running, launch it and wait for it to open
			Run(clipstudiopaintLocation)
			; Wait for the window to appear (max 10 seconds)
			WinWait(clipstudiopaintIdentifier, , 10)
			; Activate it once it's open
			WinActivate(clipstudiopaintIdentifier)
		}
	}

	if (state==1) && (code==73) ; NumPad9
	{
		; Check if DaVinci Resolve is already running
		if WinExist(davinciresolveIdentifier)
		{
			; If it exists, activate it (bring to front)
			WinActivate(davinciresolveIdentifier)
		}
		else
		{
			; If not running, launch it and wait for it to open
			Run(davinciresolveLocation)
			; Wait for the window to appear (max 15 seconds - DaVinci takes longer to load)
			WinWait(davinciresolveIdentifier, , 15)
			; Activate it once it's open
			WinActivate(davinciresolveIdentifier)
		}
	}


	if (state==1) && (code==78) ; NumPad Plus (+)
	{
		
	}

	if (state==1) && (code==74) ; NumPad Minus (-)
	{
	
	}

	if (state==1) && (code==55) ; NumPad Asterisk (*)
	{
		
	}

	if (state==1) && (code==284) ; NumPad Enter
	{
		WinMinimizeAll()
	}

	if (state==1) && (code==83) ; NumPad Delete
	{
	}

	; F-Key shortcuts
	if (state==1) && (code==59) ; F1
	{
	
	}

	if (state==1) && (code==60) ; F2
	{
	
	}

	if (state==1) && (code==61) ; F3
	{

	}

	if (state==1) && (code==62) ; F4
	{
	
	}
}




;######## ALL KEY NUMBERS ############
;{======= NUMPAD ID ==================
;NumPad0 = 82
;NumPad1 = 79
;NumPad2 = 80
;NumPad3 = 81
;NumPad4 = 75
;NumPad5 = 76
;NumPad6 = 77
;NumPad7 = 71
;NumPad8 = 72
;NumPad9 = 73
;
;NumLock = 325
;Slash(/) = 309
;Asterisk(*) = 55
;Minus(-) = 74
;Plus(+) = 78
;Enter = 284
;Dot(.)/Delete = 83
;}
;{======= Arrow Keys ID ==============
;Up = 328
;Down = 336
;Left = 331
;Right = 333
;
;}
;{======= F Keys ID ==================
;F1 = 59
;F2 = 60
;F3 = 61
;F4 = 62
;F5 = 63
;F6 = 64
;F7 = 65
;F8 = 66
;F9 = 67
;F10 = 68
;F11 = 87
;F12 = 88
;}
;{======= Main Numbers Row ID ========
;Tilde = 41
;1 = 2
;2 = 3
;3 = 4
;4 = 5
;5 = 6
;6 = 7
;7 = 8
;8 = 9
;9 = 10
;0 = 11
;Dash/Minus/Underscore = 12
;Plus/Equal Sign = 13
;BackSlash = 43
;BackSpace = 14
;}
;{======= Tab-Qwerty Row ID ==========
;Tab = 15
;Q = 16
;W = 17
;E = 18
;R = 19
;T = 20
;Y = 21
;U = 22
;I = 23
;O = 24
;P = 25
;Left Square Bracket("[") = 26
;Right Square Bracket("]") = 27
;}
;{======= Caps-ASD Row ID ============
;CapsLock = 58
;A = 30
;S = 31
;D = 32
;F = 33
;G = 34
;H = 35
;J = 36
;K = 37
;L = 38
;Semicolon(";") = 39
;Apostrophe("'") = 40
;Enter = 28
;}
;{======= Shift-ZXC Row ID ===========
;Left Shift = 42
;Z = 44
;X = 45
;C = 46
;V = 47
;B = 48
;N = 49
;M = 50
;Comma(",") = 51
;Dot(".") =  52
;Slash(/) = 53
;Right Shift = 310
;}
;{======= Gtrl/Spacebar Row ID =======
;Left Ctrl = 29
;Windows Button = 347
;Left Alt = 56
;Spacebar = 57
;Right Alt = 312
;***Left Windows Button = 348
;***Mistery Key With some list menu and mouse cursor = 349
;Right Ctrl = 285
;}
;{======= Print Screen Buttons =======
;PrtSc = 311
;ScrLk = 70
;Pause = 325
;Insert = 338
;Home = 327
;Page Up = 329
;Delete = 339
;End = 335
;Page Down  = 337
;}z