#Requires AutoHotkey v2.0

; Functions for handling Ctrl/Spacebar Row behavior

#include "codetokey.ahk"

CtrlSpaceRow_HandleEvent(code, state) {
    keyName := CodeToKey(code)

    switch keyName {
        case "Left Ctrl":
            return CtrlSpaceRow_HandleLeftCtrl(state)
        case "Windows":
            return CtrlSpaceRow_HandleWindows(state)
        case "Left Alt":
            return CtrlSpaceRow_HandleLeftAlt(state)
        case "Space":
            return CtrlSpaceRow_HandleSpace(state)
        case "Right Alt":
            return CtrlSpaceRow_HandleRightAlt(state)
        case "Left Win":
            return CtrlSpaceRow_HandleLeftWin(state)
        case "Menu":
            return CtrlSpaceRow_HandleMenu(state)
        case "Right Ctrl":
            return CtrlSpaceRow_HandleRightCtrl(state)
        default:
            return false
    }
}

CtrlSpaceRow_HandleLeftCtrl(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

CtrlSpaceRow_HandleWindows(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

CtrlSpaceRow_HandleLeftAlt(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

CtrlSpaceRow_HandleSpace(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

CtrlSpaceRow_HandleRightAlt(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

CtrlSpaceRow_HandleLeftWin(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

CtrlSpaceRow_HandleMenu(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

CtrlSpaceRow_HandleRightCtrl(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}
