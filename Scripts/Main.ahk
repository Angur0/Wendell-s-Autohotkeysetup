#SingleInstance force
Persistent

; Main control script for managing Numpad and Transport scripts
; Uses the same keyboard as defined in the config

#include "Lib\AutoHotInterception.ahk"
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

if (keyboardId == 0) {
    MsgBox("Keyboard not found! Check vendor/product IDs")
}

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

;############### KEY EVENT HANDLER ########################
KeyEvent(code, state) {
    global numpadEnabled, transportEnabled, debugKeysEnabled
    
    ; Show key names when debug mode is on
    if (debugKeysEnabled && state == 1) {
        MouseGetPos(&mouseX, &mouseY)
        ToolTip("Key: " . CodeToKey(code) . " (Code: " . code . ")", mouseX + 10, mouseY + 10)
        SetTimer(() => ToolTip(), -2000)
    }
    
    ; Only respond to key press (state == 1)
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
    
    ; F12 - Show status
    else if (CodeToKey(code) == "F12") {
        numpadStatus := numpadEnabled ? "ON" : "OFF"
        transportStatus := transportEnabled ? "ON" : "OFF"
        debugStatus := debugKeysEnabled ? "ON" : "OFF"
        MouseGetPos(&mouseX, &mouseY)
        ToolTip("Function Status:`nNumpad: " . numpadStatus . 
                "`nTransport: " . transportStatus . 
                "`nKey Debug: " . debugStatus , mouseX + 10, mouseY + 10) 
        SetTimer(() => ToolTip(), -5000)  ; Hide tooltip after 5 seconds
 
    }
    
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
    ; Cleanup keyboard subscription
    try {
        AHI.UnsubscribeKeyboard(keyboardId)
    } catch {
        ; Ignore cleanup errors
    }
}