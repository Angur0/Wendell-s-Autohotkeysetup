#Requires AutoHotkey v2.0
#SingleInstance Force

; Path to your main script
mainScript := "A:\autohotkey\Scripts\Secondkeyboard.ahk"

; Function to check if main script is running
IsScriptRunning() {
    for process in ComObjGet("winmgmts:").ExecQuery("SELECT * FROM Win32_Process WHERE Name = 'AutoHotkey64.exe'") {
        if (InStr(process.CommandLine, "Secondkeyboard.ahk")) {
            return true
        }
    }
    return false
}

; ESC key hotkey to reload or launch the main script
Esc::
{
    if (IsScriptRunning()) {
        ; Script is running - reload it
        ; Kill any existing instances of the main script
        for process in ComObjGet("winmgmts:").ExecQuery("SELECT * FROM Win32_Process WHERE Name = 'AutoHotkey64.exe'") {
            if (InStr(process.CommandLine, "Secondkeyboard.ahk")) {
                process.Terminate()
            }
        }
        Sleep(500) ; Give it time to close
        
        ; Restart the main script
        Run(mainScript)
        
        ToolTip("Script reloaded!", 0, 0)
        SetTimer(() => ToolTip(), -2000)
    } else {
        ; Script is not running - launch it
        Run(mainScript)
        
        ToolTip("Script launched!", 0, 0)
        SetTimer(() => ToolTip(), -2000)
    }
}

