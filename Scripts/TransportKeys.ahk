#Requires AutoHotkey v2.0

; Functions for handling Transport Keys (Arrow Keys section and Print Screen section) behavior

#include "codetokey.ahk"

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

    ; Add your function here
    
    return true
}

TransportKeys_HandleHome(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

TransportKeys_HandlePageUp(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

TransportKeys_HandleDelete(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

TransportKeys_HandleEnd(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

TransportKeys_HandlePageDown(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

TransportKeys_HandleUp(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

TransportKeys_HandleDown(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

TransportKeys_HandleLeft(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

TransportKeys_HandleRight(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}
