#Requires AutoHotkey v2.0

; Functions for handling F-key row behavior

FKeys_HandleEvent(code, state) {
    keyName := CodeToKey(code)

    switch keyName {
        case "F1":
            return FKeys_HandleF1(state)
        case "F2":
            return FKeys_HandleF2(state)
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
    global transportEnabled

    if (state != 1)
        return false

    transportEnabled := !transportEnabled
    status := transportEnabled ? "ON" : "OFF"
    ToolTip("Transport Functions: " . status, 10, 10)
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
    global numpadEnabled, transportEnabled, debugKeysEnabled

    numpadStatus := numpadEnabled ? "ON" : "OFF"
    transportStatus := transportEnabled ? "ON" : "OFF"
    debugStatus := debugKeysEnabled ? "ON" : "OFF"

    MouseGetPos(&mouseX, &mouseY)
    ToolTip("Function Status:`nNumpad: " . numpadStatus .
           "`nTransport: " . transportStatus .
           "`nKey Debug: " . debugStatus, mouseX + 10, mouseY + 10)
}
