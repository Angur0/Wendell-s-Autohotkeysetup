#Requires AutoHotkey v2.0

; Functions for handling Shift-ZXCV Row behavior

#include "codetokey.ahk"

ZxcvRow_HandleEvent(code, state) {
    keyName := CodeToKey(code)

    switch keyName {
        case "Left Shift":
            return ZxcvRow_HandleLeftShift(state)
        case "Z":
            return ZxcvRow_HandleZ(state)
        case "X":
            return ZxcvRow_HandleX(state)
        case "C":
            return ZxcvRow_HandleC(state)
        case "V":
            return ZxcvRow_HandleV(state)
        case "B":
            return ZxcvRow_HandleB(state)
        case "N":
            return ZxcvRow_HandleN(state)
        case "M":
            return ZxcvRow_HandleM(state)
        case ",":
            return ZxcvRow_HandleComma(state)
        case ".":
            return ZxcvRow_HandlePeriod(state)
        case "/":
            return ZxcvRow_HandleSlash(state)
        case "Right Shift":
            return ZxcvRow_HandleRightShift(state)
        default:
            return false
    }
}

ZxcvRow_HandleLeftShift(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

ZxcvRow_HandleZ(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

ZxcvRow_HandleX(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

ZxcvRow_HandleC(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

ZxcvRow_HandleV(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

ZxcvRow_HandleB(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

ZxcvRow_HandleN(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

ZxcvRow_HandleM(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

ZxcvRow_HandleComma(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

ZxcvRow_HandlePeriod(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

ZxcvRow_HandleSlash(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

ZxcvRow_HandleRightShift(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}
