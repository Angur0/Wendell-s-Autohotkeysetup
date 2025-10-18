; Numpad Functions Library
; This script provides functions for numpad key handling
; Called by Main.ahk - no direct keyboard subscription

#include "..\AuxFunction\codetokey.ahk"

;############### NUMPAD KEY HANDLER ########################
; Main function called by Main.ahk for numpad key events
; Uses global config variables loaded by Main.ahk's LoadAppConfig() function
HandleNumpadKey(code, state) {
    global app1Location, app2Location, app3Location, app4Location, app5Location
    global app6Location, app7Location, app8Location, app9Location, app10Location, app11Location,app12Location
    global app1Identifier, app2Identifier, app3Identifier, app4Identifier, app5Identifier
    global app6Identifier, app7Identifier, app8Identifier, app9Identifier, app10Identifier, app11Identifier,app12Identifier

    
    if (state==1) && (CodeToKey(code) == "NumPad0")
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
                        if (currentPath == app1Location) {
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
            Run("explorer.exe `"" . app1Location . "`"")
            ; Wait for the window to appear (max 10 seconds)
            WinWait("ahk_class CabinetWClass", , 10)
            ; Activate it once it's open
            WinActivate("ahk_class CabinetWClass")
        }
    }

    if (state==1) && (CodeToKey(code) == "NumPad1")
    {
        ; Check if app2 is already running
        if WinExist(app2Identifier)
        {
            ; If it exists, activate it (bring to front)
            WinActivate(app2Identifier)
        }
        else
        {
            ; If not running, launch it and wait for it to open
            Run(app2Location)
            ; Wait for the window to appear (max 10 seconds)
            WinWait(app2Identifier, , 10)
            ; Activate it once it's open
            WinActivate(app2Identifier)
        }
    }

    if (state==1) && (CodeToKey(code) == "NumPad2")
    {
          ; Check if app3 is already running
        if WinExist(app3Identifier)
        {
            ; If it exists, activate it (bring to front)
            WinActivate(app3Identifier)
        }
        else
        {
            ; If not running, launch it and wait for it to open
            Run(app3Location)
            ; Wait for the window to appear (max 10 seconds)
            WinWait(app3Identifier, , 10)
            ; Activate it once it's open
            WinActivate(app3Identifier)
        }
    }

    if (state==1) && (CodeToKey(code) == "NumPad3")
    {
        ; Check if app4 is already running
        if WinExist(app4Identifier)
        {
            ; If it exists, activate it (bring to front)
            WinActivate(app4Identifier)
        }
        else
        {
            ; If not running, launch it and wait for it to open
            Run(app4Location)
            ; Wait for the window to appear (max 10 seconds)
            WinWait(app4Identifier, , 10)
            ; Activate it once it's open
            WinActivate(app4Identifier)
        }
    }

    if (state==1) && (CodeToKey(code) == "NumPad4")
    {
        ; Check if app5 is already running
        if WinExist(app5Identifier)
        {
            ; If it exists, activate it (bring to front)
            WinActivate(app5Identifier)
        }
        else
        {
            ; If not running, launch it and wait for it to open
            Run(app5Location)
            ; Wait for the window to appear (max 10 seconds)
            WinWait(app5Identifier, , 10)
            ; Activate it once it's open
            WinActivate(app5Identifier)
        }
    }

    if (state==1) && (CodeToKey(code) == "NumPad5")
    {
        ; Check if app6 is already running
        if WinExist(app6Identifier)
        {
            ; If it exists, activate it (bring to front)
            try {
                WinActivate(app6Identifier)
                ; Brief delay to allow window activation
                Sleep(100)
                ; Return true to signal main script to reinitialize keyboard
                return true
            } catch Error as e {
                ; If activation fails, continue without breaking the script
            }
        }
        else
        {
            ; If not running, launch it and wait for it to open
            try {
                Run(app6Location)
                ; Wait for the window to appear (max 20 seconds - Steam takes longer to load)
                if WinWait(app6Identifier, , 20) {
                    ; Activate it once it's open
                    WinActivate(app6Identifier)
                    Sleep(100)
                    ; Return true to signal main script to reinitialize keyboard
                    return true
                }
            } catch Error as e {
                ; If launch fails, continue without breaking the script
            }
        }
    }

    if (state==1) && (code==77) ; NumPad6
    {
        ; Check if app7 is already running
        if WinExist(app7Identifier)
        {
            ; If it exists, activate it (bring to front)
            WinActivate(app7Identifier)
        }
        else
        {
            ; If not running, launch it and wait for it to open
            Run(app7Location)
            ; Wait for the window to appear (max 10 seconds)
            WinWait(app7Identifier, , 10)
            ; Activate it once it's open
            WinActivate(app7Identifier)
        }
    }

    if (state==1) && (code==71) ; NumPad7
    {
        ; Check if app8 is already running
        if WinExist(app8Identifier)
        {
            ; If it exists, activate it (bring to front)
            WinActivate(app8Identifier)
        }
        else
        {
            ; If not running, launch it and wait for it to open
            Run(app8Location)
            ; Wait for the window to appear (max 10 seconds)
            WinWait(app8Identifier, , 10)
            ; Activate it once it's open
            WinActivate(app8Identifier)
        }
    }

    if (state==1) && (code==72) ; NumPad8
    {
        ; Check if app9 is already running
        if WinExist(app9Identifier)
        {
            ; If it exists, activate it (bring to front)
            WinActivate(app9Identifier)
        }
        else
        {
            ; If not running, launch it and wait for it to open
            Run(app9Location)
            ; Wait for the window to appear (max 10 seconds)
            WinWait(app9Identifier, , 10)
            ; Activate it once it's open
            WinActivate(app9Identifier)
        }
    }

    if (state==1) && (code==73) ; NumPad9
    {
        ; Check if app10 is already running
        if WinExist(app10Identifier)
        {
            ; If it exists, activate it (bring to front)
            WinActivate(app10Identifier)
        }
        else
        {
            ; If not running, launch it and wait for it to open
            Run(app10Location)
            ; Wait for the window to appear (max 15 seconds - DaVinci takes longer to load)
            WinWait(app10Identifier, , 15)
            ; Activate it once it's open
            WinActivate(app10Identifier)
        }
    }



    if (state==1) && (code==78) ; NumPad Plus (+)
    {
        ; Take a screenshot using Print Screen
        Send("{PrintScreen}")
    }

    if (state==1) && (code==74) ; NumPad Minus (-)
    {
        activeWindow := WinGetID("A")
        WinMinimize("ahk_id " . activeWindow)
    }

    if (state==1) && (code==55) ; NumPad Asterisk (*)
    {
      
        if WinExist(app12Identifier) || ProcessExist("MouseWithoutBorders.exe") || ProcessExist("MouseWithoutBordersHelper.exe")
        {
            ; Default global exit hotkey: Ctrl+Alt+Shift+Q
            Send("^!+q")
            ; Show confirmation tooltip
            ToolTip("Mouse without Borders closed")
            SetTimer(() => ToolTip(), -2000) ; Remove tooltip after 2 seconds
        }
        else
        {
            if (app12Location != "")
                Run(app12Location)
        }
    }

    if (state==1) && (code==284) ; NumPad Enter
    {
      Click("XButton1")
    }

    if (state==1) && (code==83) ; NumPad Delete
    {
        if WinExist(app11Identifier)
        {
            ; If it exists, activate it (bring to front)
            WinActivate(app11Identifier)
        }
        else
        {
            ; If not running, launch it and wait for it to open
            Run(app11Location)
            ; Wait for the window to appear (max 15 seconds)
            WinWait(app11Identifier, , 15)
            ; Activate it once it's open
            WinActivate(app11Identifier)
        }
    }

    if (state==1) && (code==325) ; NumLock
    {
        ; Check if app4 (Zen) is already running
        if WinExist(app4Identifier)
        {
            ; If Zen exists, activate it and open YouTube
            WinActivate(app4Identifier)
            Sleep(500) ; Wait for window to be active
            Send("^t") ; Open new tab (Ctrl+T)
            Sleep(200)
            Send("youtube.com{Enter}") ; Navigate to YouTube
        }
        else
        {
            ; If not running, launch Zen and then open YouTube
            Run(app4Location)
            ; Wait for the window to appear (max 10 seconds)
            WinWait(app4Identifier, , 10)
            ; Activate it once it's open
            WinActivate(app4Identifier)
            Sleep(2000) ; Wait for Zen to fully load
            Send("^l") ; Focus address bar (Ctrl+L)
            Sleep(200)
            Send("youtube.com{Enter}") ; Navigate to YouTube
        }
    }

    
    if (state==1) && (code==309) ; Numpad /
    {
        ; Check if app4 (Zen) is already running
        if WinExist(app4Identifier)
        {
            ; If Zen exists, activate it and open facebook
            WinActivate(app4Identifier)
            Sleep(500) ; Wait for window to be active
            Send("^t") ; Open new tab (Ctrl+T)
            Sleep(200)
            Send("facebook.com{Enter}") ; Navigate to facebook
        }
        else
        {
            ; If not running, launch Zen and then open facebook
            Run(app4Location)
            ; Wait for the window to appear (max 10 seconds)
            WinWait(app4Identifier, , 10)
            ; Activate it once it's open
            WinActivate(app4Identifier)
            Sleep(2000) ; Wait for Zen to fully load
            Send("^l") ; Focus address bar (Ctrl+L)
            Sleep(200)
            Send("facebook.com{Enter}") ; Navigate to facebook
        }
    }
    
    return false ; No special handling needed
}

