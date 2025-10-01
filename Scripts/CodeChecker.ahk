#SingleInstance force
Persistent

#include "Lib\AutoHotInterception.ahk"
#include "codetokey.ahk"

; Load configuration
configFile := A_ScriptDir . "\config.ini"
vendorId := IniRead(configFile, "KeyboardSettings", "vendorId",)
productId := IniRead(configFile, "KeyboardSettings", "productId",)
vendorIdInt := Integer(vendorId) & 0xFFFF
productIdInt := Integer(productId) & 0xFFFF

; Initialize AutoHotInterception
AHI := AutoHotInterception()
keyboardId := AHI.GetKeyboardId(vendorIdInt, productIdInt)
AHI.SubscribeKeyboard(keyboardId, true, KeyEvent)

if (keyboardId == 0) {
    MsgBox("Keyboard not found! Check vendor/product IDs in config.ini")
    ExitApp
}

; Show startup message
ToolTip("CodeChecker Running - Press any key on your second keyboard to see its code", 10, 10)
SetTimer(() => ToolTip(), -5000)

; Emergency reload hotkey (Ctrl+Shift+M on main keyboard - not intercepted)
^+m::Reload

; Key event handler - shows all key presses
KeyEvent(code, state) {
    if (state == 1) {  ; Key down
        MouseGetPos(&mouseX, &mouseY)
        ToolTip("Key: " . CodeToKey(code) . " (Code: " . code . ")", mouseX + 10, mouseY + 10)
        SetTimer(() => ToolTip(), -3000)
    }
}

; Clean up on exit
OnExit(ExitCleanup)

ExitCleanup(ExitReason, ExitCode) {
    global AHI, keyboardId
    ; Cleanup keyboard subscription
    try {
        AHI.UnsubscribeKeyboard(keyboardId)
    } catch {
        ; Ignore cleanup errors
    }
}