#Requires AutoHotkey v2.0

; Functions for handling Transport Keys (Arrow Keys section and Print Screen section) behavior

#include "..\AuxFunction\codetokey.ahk"

TransportKeys_HandleEvent(code, state) {
    keyName := CodeToKey(code)

    switch keyName {
        case "PrtSc":
            return TransportKeys_HandlePrtSc(state)
        case "ScrLk":
            return TransportKeys_HandleScrLk(state)
        case "Pause":
            return TransportKeys_HandlePause(state)
        case "Insert":
            return TransportKeys_HandleInsert(state)
        case "Home":
            return TransportKeys_HandleHome(state)
        case "Page Up":
            return TransportKeys_HandlePageUp(state)
        case "Delete":
            return TransportKeys_HandleDelete(state)
        case "End":
            return TransportKeys_HandleEnd(state)
        case "Page Down":
            return TransportKeys_HandlePageDown(state)
        case "Up":
            return TransportKeys_HandleUp(state)
        case "Down":
            return TransportKeys_HandleDown(state)
        case "Left":
            return TransportKeys_HandleLeft(state)
        case "Right":
            return TransportKeys_HandleRight(state)
        default:
            return false
    }
}

TransportKeys_HandlePrtSc(state) {
    if (state != 1)
        return false

    Send("^+|") ; Ctrl+Shift+M to toggle mute
    
    return true
}

TransportKeys_HandleScrLk(state) {
    if (state != 1)
        return false
    Send("^+>")
    
    return true
}

TransportKeys_HandlePause(state) {
    if (state != 1)
        return false

    ; Pause/Break -> Send Ctrl+Shift+L (disconnect)
    Send("^+L") ; Ctrl+Shift+L (uppercase L for Discord)
    
    return true
}

TransportKeys_HandleInsert(state) {
    if (state != 1)
        return false

    ; Insert -> Start/Stop Streaming in OBS
    Send("^+{F9}") ; Ctrl+Shift+F9 (Start/Stop Streaming)
    
    return true
}

TransportKeys_HandleHome(state) {
    if (state != 1)
        return false

    ; Home -> Start/Stop Recording in OBS
    Send("^+{F12}") ; Ctrl+Shift+F12 (Start/Stop Recording)
    
    return true
}

TransportKeys_HandlePageUp(state) {
    if (state != 1)
        return false

    ; Page Up -> Start/Stop Replay Buffer in OBS
    Send("^+{F10}") ; Ctrl+Shift+F10 (Start/Stop Replay Buffer)
    
    return true
}

TransportKeys_HandleDelete(state) {
    if (state != 1)
        return false

    ; Delete -> Save Replay Buffer in OBS
    Send("^+s") ; Ctrl+Shift+S (Save Replay Buffer)
    
    return true
}

TransportKeys_HandleEnd(state) {
    if (state != 1)
        return false

    ; End -> Save Replay Buffer in OBS
    Send("^+s") ; Ctrl+Shift+S (Save Replay Buffer)
    
    return true
}

TransportKeys_HandlePageDown(state) {
    if (state != 1)
        return false

    ; Page Down -> Mute/Unmute YouTube in Chrome
    if !WinActive("") {
        ; Get the control HWND of Chrome
        try {
            controlID := ControlGetHwnd("Chrome_RenderWidgetHostHWND1", "Google Chrome")
            
            ; Focus on Chrome without breaking focus on what you're doing
            ControlFocus("Chrome_RenderWidgetHostHWND1", "ahk_id " controlID)
            
            Sleep(50)
            
            ; Mute YouTube
            ControlSend("k", "Chrome_RenderWidgetHostHWND1", "Google Chrome")
        }
    }
    
    return true
}

TransportKeys_HandleUp(state) {
    if (state != 1)
        return false

    ; Up -> Switch to Previous Scene in OBS
    Send("^+{F7}") ; Ctrl+Shift+F7 (Previous Scene)
    
    return true
}

TransportKeys_HandleDown(state) {
    if (state != 1)
        return false

    ; Down -> Switch to Next Scene in OBS
    Send("^+{F8}") ; Ctrl+Shift+F8 (Next Scene)
    
    return true
}

TransportKeys_HandleLeft(state) {
    if (state != 1)
        return false

    ; Left -> Mute/Unmute Desktop Audio in OBS
    Send("^+{F1}") ; Ctrl+Shift+F1 (custom OBS hotkey for Desktop Audio)
    
    return true
}

TransportKeys_HandleRight(state) {
    if (state != 1)
        return false

    ; Right -> Mute/Unmute Microphone in OBS
    Send("^+{F2}") ; Ctrl+Shift+F2 (custom OBS hotkey for Mic/Aux)
    
    return true
}
