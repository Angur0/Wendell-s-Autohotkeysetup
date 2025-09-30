#SingleInstance force
Persistent

; Main control script for managing Numpad and Transport scripts
; Uses the same keyboard as defined in the config

#include "Lib\AutoHotInterception.ahk"
#include "Lib\InterceptionTapHold.ahk"
#include "codetokey.ahk"
#include "Numpad.ahk"
#include "Transport.ahk"

;############### LOAD CONFIGURATION ########################
configFile := A_ScriptDir . "\config.ini"

; Load keyboard settings from config
vendorId := IniRead(configFile, "KeyboardSettings", "vendorId",)
productId := IniRead(configFile, "KeyboardSettings", "productId",)

; Convert hex string values to 16-bit integers
vendorIdInt := Integer(vendorId) & 0xFFFF
productIdInt := Integer(productId) & 0xFFFF

;############### INITIALIZE AUTOHOTINTERCEPTION ########################
AHI := AutoHotInterception()
keyboardId := AHI.GetKeyboardId(vendorIdInt, productIdInt)
AHI.SubscribeKeyboard(keyboardId, true, KeyEvent)

; Initialize the F12 behavior
f12Key := 88  ; F12 keycode from keyconfig.ini
f12Pressed := false

if (keyboardId == 0) {
    MsgBox("Keyboard not found! Check vendor/product IDs")
}

ITH := InterceptionTapHold(AHI, keyboardId)

;############### FUNCTION MANAGEMENT ########################
; Function states
numpadEnabled := true
transportEnabled := true
debugKeysEnabled := false  ; Debug key names display toggle

; Function to reinitialize keyboard subscription if it gets disrupted
ReinitializeKeyboard() {
    global AHI, keyboardId, vendorIdInt, productIdInt
    try {
        AHI.UnsubscribeKeyboard(keyboardId)
        keyboardId := AHI.GetKeyboardId(vendorIdInt, productIdInt)
        AHI.SubscribeKeyboard(keyboardId, true, KeyEvent)
        MouseGetPos(&mouseX, &mouseY)
        ToolTip("Keyboard Reinitialized", mouseX + 10, mouseY + 10)
        SetTimer(() => ToolTip(), -1000)
    } catch Error as e {
        ; If reinitialize fails, reload the entire script
        MouseGetPos(&mouseX, &mouseY)
        ToolTip("Reinit Failed - Reloading", mouseX + 10, mouseY + 10)
        SetTimer(() => ToolTip(), -1000)
        Sleep(1000)
        Reload
    }
}

;############### HOTKEYS ########################
; Emergency reload hotkey for main script (Ctrl+Shift+M on main keyboard - not intercepted)
^+m::Reload

;############### F12 HANDLER FUNCTION ########################
ShowStatusTooltip() {
    global numpadEnabled, transportEnabled, debugKeysEnabled
    
    numpadStatus := numpadEnabled ? "ON" : "OFF"
    transportStatus := transportEnabled ? "ON" : "OFF"
    debugStatus := debugKeysEnabled ? "ON" : "OFF"
    
    MouseGetPos(&mouseX, &mouseY)
    ToolTip("Function Status:`nNumpad: " . numpadStatus . 
           "`nTransport: " . transportStatus . 
           "`nKey Debug: " . debugStatus, mouseX + 10, mouseY + 10)
}

;############### KEY EVENT HANDLER ########################
KeyEvent(code, state) {
    global numpadEnabled, transportEnabled, debugKeysEnabled
    
    ; Show key names when debug mode is on
    if (debugKeysEnabled && state == 1) {
        MouseGetPos(&mouseX, &mouseY)
        ToolTip("Key: " . CodeToKey(code) . " (Code: " . code . ")", mouseX + 10, mouseY + 10)
        SetTimer(() => ToolTip(), -2000)
    }
    
    ; Special case for F12 key handling - we need to process both press and release
    if (CodeToKey(code) == "F12") {
        static f12PrevState := 0  ; Track previous state to prevent repeat firing
        
        if (state == 1 && f12PrevState == 0) {  ; Key down (initial press only)
            f12Pressed := true
            f12PrevState := 1
            ; Show status tooltip immediately when key is initially pressed
            ShowStatusTooltip()
        } else if (state == 0 && f12PrevState == 1) {  ; Key up
            f12Pressed := false
            f12PrevState := 0
            ; Hide tooltip when key is released
            ToolTip()
        }
        return
    }
    
    ; For other keys, only respond to key press (state == 1)
    if (state != 1) {
        return
    }
    
    ; Main script hotkeys (F1, F2, ESC, F12)
    ; F1 - Toggle Numpad functionality
    if (CodeToKey(code) == "F1") {
        numpadEnabled := !numpadEnabled
        status := numpadEnabled ? "ON" : "OFF"
        ToolTip("Numpad Functions: " . status, 10, 10)
        SetTimer(() => ToolTip(), -2000)
        return
    }
    
    ; F2 - Toggle Transport functionality
    else if (CodeToKey(code) == "F2") {
        transportEnabled := !transportEnabled
        status := transportEnabled ? "ON" : "OFF"
        ToolTip("Transport Functions: " . status, 10, 10)
        SetTimer(() => ToolTip(), -2000)
        return
    }
    
    ; ESC - Reload this script
    else if (CodeToKey(code) == "Esc") {
        ToolTip("Main Script: RELOADING", 10, 10)
        SetTimer(() => ToolTip(), -1000)
        Sleep(1000)
        Reload
        return
    }
    
    ; F11 - Toggle Key Debug Mode
    else if (CodeToKey(code) == "F11") {
        debugKeysEnabled := !debugKeysEnabled
        status := debugKeysEnabled ? "ON" : "OFF"
        MouseGetPos(&mouseX, &mouseY)
        ToolTip("Key Debug Mode: " . status, mouseX + 10, mouseY + 10)
        SetTimer(() => ToolTip(), -2000)
        return
    }
    
    ; F12 is handled at the beginning of this function
    
    ; Delegate to numpad functions if enabled
    if (numpadEnabled) {
        needsReinit := HandleNumpadKey(code, state)
        if (needsReinit) {
            ; Steam or other app needs keyboard reinitialization
            ReinitializeKeyboard()
        }
    }
    
    ; Delegate to transport functions if enabled
    if (transportEnabled) {
        HandleTransportKey(code, state)
    }
}

; Clean up on exit
OnExit(ExitCleanup)

ExitCleanup(ExitReason, ExitCode) {
    global AHI, keyboardId
    
    ; Clear any tooltips
    ToolTip()
    
    ; Cleanup keyboard subscription
    try {
        AHI.UnsubscribeKeyboard(keyboardId)
    } catch {
        ; Ignore cleanup errors
    }
}