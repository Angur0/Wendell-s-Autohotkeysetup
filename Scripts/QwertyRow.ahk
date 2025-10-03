#Requires AutoHotkey v2.0

; Functions for handling Tab-QWERTY Row behavior

#include "codetokey.ahk"

QwertyRow_HandleEvent(code, state) {
    keyName := CodeToKey(code)

    switch keyName {
        case "Tab":
            return QwertyRow_HandleTab(state)
        case "Q":
            return QwertyRow_HandleQ(state)
        case "W":
            return QwertyRow_HandleW(state)
        case "E":
            return QwertyRow_HandleE(state)
        case "R":
            return QwertyRow_HandleR(state)
        case "T":
            return QwertyRow_HandleT(state)
        case "Y":
            return QwertyRow_HandleY(state)
        case "U":
            return QwertyRow_HandleU(state)
        case "I":
            return QwertyRow_HandleI(state)
        case "O":
            return QwertyRow_HandleO(state)
        case "P":
            return QwertyRow_HandleP(state)
        case "[":
            return QwertyRow_HandleLeftBracket(state)
        case "]":
            return QwertyRow_HandleRightBracket(state)
        default:
            return false
    }
}

QwertyRow_HandleTab(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

QwertyRow_HandleQ(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

QwertyRow_HandleW(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

QwertyRow_HandleE(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

QwertyRow_HandleR(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

QwertyRow_HandleT(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

QwertyRow_HandleY(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

QwertyRow_HandleU(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

QwertyRow_HandleI(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

QwertyRow_HandleO(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

QwertyRow_HandleP(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

QwertyRow_HandleLeftBracket(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

QwertyRow_HandleRightBracket(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}
