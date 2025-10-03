#Requires AutoHotkey v2.0

; Functions for handling Print Screen section keys behavior

PrintScreenKeys_HandleEvent(code, state) {
    keyName := CodeToKey(code)

    switch keyName {
        case "PrtSc":
            return PrintScreenKeys_HandlePrtSc(state)
        case "ScrLk":
            return PrintScreenKeys_HandleScrLk(state)
        case "Pause":
            return PrintScreenKeys_HandlePause(state)
        default:
            return false
    }
}

PrintScreenKeys_HandlePrtSc(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

PrintScreenKeys_HandleScrLk(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}

PrintScreenKeys_HandlePause(state) {
    if (state != 1)
        return false

    ; Add your function here
    
    return true
}
