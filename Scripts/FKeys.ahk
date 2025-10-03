#Requires AutoHotkey v2.0

; Functions for handling F-key row behavior

FKeys_HandleEvent(code, state) {
    keyName := CodeToKey(code)

    switch keyName {
        case "F1":
            return FKeys_HandleF1(state)
        case "F2":
            return FKeys_HandleF2(state)
        case "F3":
            return FKeys_HandleF3(state)
        case "F4":
            return FKeys_HandleF4(state)
        case "F5":
            return FKeys_HandleF5(state)
        case "F6":
            return FKeys_HandleF6(state)
        case "F7":
            return FKeys_HandleF7(state)
        case "F9":
            return FKeys_HandleF9(state)
        case "F10":
            return FKeys_HandleF10(state)
        case "F11":
            return FKeys_HandleF11(state)
        case "F12":
            return FKeys_HandleF12(state)
        default:
            return false
    }
}

FKeys_HandleF1(state) {
    global numpadEnabled

    if (state != 1)
        return false

    numpadEnabled := !numpadEnabled
    status := numpadEnabled ? "ON" : "OFF"
    ToolTip("Numpad Functions: " . status, 10, 10)
    SetTimer(() => ToolTip(), -2000)
    return true
}

FKeys_HandleF2(state) {
    global transportKeysEnabled

    if (state != 1)
        return false

    transportKeysEnabled := !transportKeysEnabled
    status := transportKeysEnabled ? "ON" : "OFF"
    ToolTip("Transport Functions: " . status, 10, 10)
    SetTimer(() => ToolTip(), -2000)
    return true
}

FKeys_HandleF3(state) {
    global numberRowEnabled

    if (state != 1)
        return false

    numberRowEnabled := !numberRowEnabled
    status := numberRowEnabled ? "ON" : "OFF"
    ToolTip("Number Row: " . status, 10, 10)
    SetTimer(() => ToolTip(), -2000)
    return true
}

FKeys_HandleF4(state) {
    global qwertyRowEnabled

    if (state != 1)
        return false

    qwertyRowEnabled := !qwertyRowEnabled
    status := qwertyRowEnabled ? "ON" : "OFF"
    ToolTip("QWERTY Row: " . status, 10, 10)
    SetTimer(() => ToolTip(), -2000)
    return true
}

FKeys_HandleF5(state) {
    global asdfRowEnabled

    if (state != 1)
        return false

    asdfRowEnabled := !asdfRowEnabled
    status := asdfRowEnabled ? "ON" : "OFF"
    ToolTip("ASDF Row: " . status, 10, 10)
    SetTimer(() => ToolTip(), -2000)
    return true
}

FKeys_HandleF6(state) {
    global zxcvRowEnabled

    if (state != 1)
        return false

    zxcvRowEnabled := !zxcvRowEnabled
    status := zxcvRowEnabled ? "ON" : "OFF"
    ToolTip("ZXCV Row: " . status, 10, 10)
    SetTimer(() => ToolTip(), -2000)
    return true
}

FKeys_HandleF7(state) {
    global ctrlSpaceRowEnabled

    if (state != 1)
        return false

    ctrlSpaceRowEnabled := !ctrlSpaceRowEnabled
    status := ctrlSpaceRowEnabled ? "ON" : "OFF"
    ToolTip("Ctrl/Space Row: " . status, 10, 10)
    SetTimer(() => ToolTip(), -2000)
    return true
}

FKeys_HandleF9(state) {
    if (state != 1)
        return false

    ; F8-F10 available for future use
    ToolTip("F9: Unassigned", 10, 10)
    SetTimer(() => ToolTip(), -2000)
    return true
}

FKeys_HandleF10(state) {
    if (state != 1)
        return false

    ; F10 available for future use
    ToolTip("F10: Unassigned", 10, 10)
    SetTimer(() => ToolTip(), -2000)
    return true
}

FKeys_HandleF11(state) {
    global debugKeysEnabled

    if (state != 1)
        return false

    debugKeysEnabled := !debugKeysEnabled
    status := debugKeysEnabled ? "ON" : "OFF"
    MouseGetPos(&mouseX, &mouseY)
    ToolTip("Key Debug Mode: " . status, mouseX + 10, mouseY + 10)
    SetTimer(() => ToolTip(), -2000)
    return true
}

FKeys_HandleF12(state) {
    static prevState := 0

    if (state == 1 && prevState == 0) {
        prevState := 1
        FKeys_ShowStatusTooltip()
        return true
    }

    if (state == 0 && prevState == 1) {
        prevState := 0
        ToolTip()
        return true
    }

    return false
}

FKeys_ShowStatusTooltip() {
    global numpadEnabled, transportKeysEnabled, numberRowEnabled, qwertyRowEnabled
    global asdfRowEnabled, zxcvRowEnabled, ctrlSpaceRowEnabled, debugKeysEnabled

    numpadStatus := numpadEnabled ? "ON" : "OFF"
    transportStatus := transportKeysEnabled ? "ON" : "OFF"
    numberRowStatus := numberRowEnabled ? "ON" : "OFF"
    qwertyRowStatus := qwertyRowEnabled ? "ON" : "OFF"
    asdfRowStatus := asdfRowEnabled ? "ON" : "OFF"
    zxcvRowStatus := zxcvRowEnabled ? "ON" : "OFF"
    ctrlSpaceRowStatus := ctrlSpaceRowEnabled ? "ON" : "OFF"
    debugStatus := debugKeysEnabled ? "ON" : "OFF"

    MouseGetPos(&mouseX, &mouseY)
    ToolTip("Function Status:"
           . "`nF1  - Numpad: " . numpadStatus
           . "`nF2  - Transport: " . transportStatus
           . "`nF3  - Number Row: " . numberRowStatus
           . "`nF4  - QWERTY Row: " . qwertyRowStatus
           . "`nF5  - ASDF Row: " . asdfRowStatus
           . "`nF6  - ZXCV Row: " . zxcvRowStatus
           . "`nF7  - Ctrl/Space: " . ctrlSpaceRowStatus
           . "`n---"
           . "`nEsc - Reload (Always ON)"
           . "`nF11 - Debug: " . debugStatus, mouseX + 10, mouseY + 10)
}
