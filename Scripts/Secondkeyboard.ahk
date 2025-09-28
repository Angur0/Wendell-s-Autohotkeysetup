#SingleInstance force
Persistent

#include "A:\autohotkey\AHK v2\Lib\AutoHotInterception.ahk"

;############### LOAD CONFIGURATION ########################
configFile := A_ScriptDir . "\config.ini"

; Load app locations from config - NumPad Key Bindings:
mediashareLocation := IniRead(configFile, "AppLocations", "mediashare", "")      ; NumPad 0 - Media Share folder
obsidianLocation := IniRead(configFile, "AppLocations", "obsidian", "")          ; NumPad 1 - Obsidian
discordLocation := IniRead(configFile, "AppLocations", "discord", "")            ; NumPad 2 - Discord
zenLocation := IniRead(configFile, "AppLocations", "zen", "")                    ; NumPad 3 - Zen Browser
reaperLocation := IniRead(configFile, "AppLocations", "reaper", "")              ; NumPad 4 - Reaper DAW
steamLocation := IniRead(configFile, "AppLocations", "steam", "")                ; NumPad 5 - Steam
vscodeLocation := IniRead(configFile, "AppLocations", "vscode", "")              ; NumPad 6 - Visual Studio Code
explorerLocation := IniRead(configFile, "AppLocations", "explorer", "")          ; NumPad 7 - File Explorer
clipstudiopaintLocation := IniRead(configFile, "AppLocations", "clipstudiopaint", "") ; NumPad 8 - Clip Studio Paint
davinciresolveLocation := IniRead(configFile, "AppLocations", "davinciresolve", "")   ; NumPad 9 - DaVinci Resolve
obsLocation := IniRead(configFile, "AppLocations", "obs", "")                    ; ./delete - OBS Studio

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
obsIdentifier := IniRead(configFile, "AppIdentifiers", "obs", "")
; Load keyboard settings from config
vendorId := IniRead(configFile, "KeyboardSettings", "vendorId",)
productId := IniRead(configFile, "KeyboardSettings", "productId",)

; Convert hex string values to 16-bit integers
vendorIdInt := Integer(vendorId) & 0xFFFF
productIdInt := Integer(productId) & 0xFFFF

;############### INITIALIZE AUTOHOTINTERCEPTION ########################
AHI := AutoHotInterception()
keyboardId := AHI.GetKeyboardId(vendorIdInt, productIdInt)
AHI.SubscribeKeyboard(keyboardId, true, KeyEvent)

if (keyboardId == 0) {
    MsgBox("Keyboard not found! Check vendor/product IDs")
}


;############### KEY EVENT HANDLER ########################
KeyEvent(code, state){

    if (state==1) && (code==82) ; NumPad0
    {
        ; Check if Media Share folder is already open in Explorer
        ; Look for any Explorer window with the Media Share folder path in the address bar
        found := false
        for window in WinGetList("ahk_class CabinetWClass")
        {
            try {
                ; Get the window's current folder path
                xl := ComObject("Shell.Application")
                for item in xl.Windows {
                    if (item.HWND == window) {
                        currentPath := item.Document.Folder.Self.Path
                        if (currentPath == mediashareLocation) {
                            WinActivate("ahk_id " . window)
                            found := true
                            break
                        }
                    }
                }
            }
            if (found)
                break
        }
        
        if (!found) {
            ; If not open, launch Explorer with the Media Share folder
            Run("explorer.exe `"" . mediashareLocation . "`"")
            ; Wait for the window to appear (max 10 seconds)
            WinWait("ahk_class CabinetWClass", , 10)
            ; Activate it once it's open
            WinActivate("ahk_class CabinetWClass")
        }
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
		activeWindow := WinGetID("A")
    	WinMinimize("ahk_id " . activeWindow)
	}

	if (state==1) && (code==55) ; NumPad Asterisk (*)
	{
	  WinMinimizeAll()
	}

	if (state==1) && (code==284) ; NumPad Enter
	{
	  Click("XButton1")
	}

	if (state==1) && (code==83) ; NumPad Delete
	{
			if WinExist(obsIdentifier)
		{
			; If it exists, activate it (bring to front)
			WinActivate(obsIdentifier)
		}
		else
		{
			; If not running, launch it and wait for it to open
			Run(obsLocation)
			; Wait for the window to appear (max 15 seconds - DaVinci takes longer to load)
			WinWait(obsIdentifier, , 15)
			; Activate it once it's open
			WinActivate(obsIdentifier)
		}
	}

	if (state==1) && (code==325) ; NumLock
    {
        ; Check if Zen is already running
        if WinExist(zenIdentifier)
        {
            ; If Zen exists, activate it and open YouTube
            WinActivate(zenIdentifier)
            Sleep(500) ; Wait for window to be active
            Send("^t") ; Open new tab (Ctrl+T)
            Sleep(200)
            Send("youtube.com{Enter}") ; Navigate to YouTube
        }
        else
        {
            ; If not running, launch Zen and then open YouTube
            Run(zenLocation)
            ; Wait for the window to appear (max 10 seconds)
            WinWait(zenIdentifier, , 10)
            ; Activate it once it's open
            WinActivate(zenIdentifier)
            Sleep(2000) ; Wait for Zen to fully load
            Send("^l") ; Focus address bar (Ctrl+L)
            Sleep(200)
            Send("youtube.com{Enter}") ; Navigate to YouTube
        }
    }

	
	if (state==1) && (code==309) ; Numpad /
    {
        ; Check if Zen is already running
        if WinExist(zenIdentifier)
        {
            ; If Zen exists, activate it and open facebook
            WinActivate(zenIdentifier)
            Sleep(500) ; Wait for window to be active
            Send("^t") ; Open new tab (Ctrl+T)
            Sleep(200)
            Send("facebook.com{Enter}") ; Navigate to facebook
        }
        else
        {
            ; If not running, launch Zen and then open facebook
            Run(zenLocation)
            ; Wait for the window to appear (max 10 seconds)
            WinWait(zenIdentifier, , 10)
            ; Activate it once it's open
            WinActivate(zenIdentifier)
            Sleep(2000) ; Wait for Zen to fully load
            Send("^l") ; Focus address bar (Ctrl+L)
            Sleep(200)
            Send("facebook.com{Enter}") ; Navigate to facebook
        }
    }

}