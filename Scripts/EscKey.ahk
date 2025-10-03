#Requires AutoHotkey v2.0

; Functions for handling Escape key behavior

#include "codetokey.ahk"

EscKey_HandleEvent(code, state) {
    keyName := CodeToKey(code)

    switch keyName {
        case "Esc":
            return EscKey_HandleEsc(state)
        default:
            return false
    }
}

EscKey_HandleEsc(state) {
    if (state != 1)
        return false

    ; Reload the main script
    ToolTip("Main Script: RELOADING", 10, 10)
    SetTimer(() => ToolTip(), -1000)
    Sleep(1000)
    Reload
    
    return true
}
