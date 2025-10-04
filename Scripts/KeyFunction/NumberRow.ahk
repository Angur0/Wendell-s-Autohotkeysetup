#Requires AutoHotkey v2.0

; Functions for handling Number Row (1-9, 0, -, =, \, Backspace) behavior

#include "..\AuxFunction\codetokey.ahk"

NumberRow_HandleEvent(code, state) {
    keyName := CodeToKey(code)

    switch keyName {
        case "~":
            return NumberRow_HandleTilde(state)
        case "1":
            return NumberRow_Handle1(state)
        case "2":
            return NumberRow_Handle2(state)
        case "3":
            return NumberRow_Handle3(state)
        case "4":
            return NumberRow_Handle4(state)
        case "5":
            return NumberRow_Handle5(state)
        case "6":
            return NumberRow_Handle6(state)
        case "7":
            return NumberRow_Handle7(state)
        case "8":
            return NumberRow_Handle8(state)
        case "9":
            return NumberRow_Handle9(state)
        case "0":
            return NumberRow_Handle0(state)
        case "-":
            return NumberRow_HandleMinus(state)
        case "=":
            return NumberRow_HandleEquals(state)
        case "\":
            return NumberRow_HandleBackslash(state)
        case "Backspace":
            return NumberRow_HandleBackspace(state)
        default:
            return false
    }
}

NumberRow_HandleTilde(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

NumberRow_Handle1(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

NumberRow_Handle2(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

NumberRow_Handle3(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

NumberRow_Handle4(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

NumberRow_Handle5(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

NumberRow_Handle6(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

NumberRow_Handle7(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

NumberRow_Handle8(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

NumberRow_Handle9(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

NumberRow_Handle0(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

NumberRow_HandleMinus(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

NumberRow_HandleEquals(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

NumberRow_HandleBackslash(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

NumberRow_HandleBackspace(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}
