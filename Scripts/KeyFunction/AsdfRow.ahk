#Requires AutoHotkey v2.0

; Functions for handling Caps-ASDF Row behavior

#include "..\AuxFunction\codetokey.ahk"

AsdfRow_HandleEvent(code, state) {
    keyName := CodeToKey(code)

    switch keyName {
        case "CapsLock":
            return AsdfRow_HandleCapsLock(state)
        case "A":
            return AsdfRow_HandleA(state)
        case "S":
            return AsdfRow_HandleS(state)
        case "D":
            return AsdfRow_HandleD(state)
        case "F":
            return AsdfRow_HandleF(state)
        case "G":
            return AsdfRow_HandleG(state)
        case "H":
            return AsdfRow_HandleH(state)
        case "J":
            return AsdfRow_HandleJ(state)
        case "K":
            return AsdfRow_HandleK(state)
        case "L":
            return AsdfRow_HandleL(state)
        case ";":
            return AsdfRow_HandleSemicolon(state)
        case "'":
            return AsdfRow_HandleApostrophe(state)
        case "Enter":
            return AsdfRow_HandleEnter(state)
        default:
            return false
    }
}

AsdfRow_HandleCapsLock(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

AsdfRow_HandleA(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

AsdfRow_HandleS(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

AsdfRow_HandleD(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

AsdfRow_HandleF(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

AsdfRow_HandleG(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

AsdfRow_HandleH(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

AsdfRow_HandleJ(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

AsdfRow_HandleK(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

AsdfRow_HandleL(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

AsdfRow_HandleSemicolon(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

AsdfRow_HandleApostrophe(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

AsdfRow_HandleEnter(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}
