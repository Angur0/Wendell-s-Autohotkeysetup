#SingleInstance force
Persistent

; Main control script for managing Numpad and Transport scripts
; Uses the same keyboard as defined in the config

#include "A:\autohotkey\AHK v2\Lib\AutoHotInterception.ahk"
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

; Function to reinitialize keyboard subscription if it gets disrupted
ReinitializeKeyboard() {
    global AHI, keyboardId, vendorIdInt, productIdInt
    try {
        AHI.UnsubscribeKeyboard(keyboardId)
        keyboardId := AHI.GetKeyboardId(vendorIdInt, productIdInt)
        AHI.SubscribeKeyboard(keyboardId, true, KeyEvent)
        ToolTip("Keyboard Reinitialized", 10, 70)
        SetTimer(() => ToolTip(), -1000)
    } catch Error as e {
        ; If reinitialize fails, reload the entire script
        ToolTip("Reinit Failed - Reloading", 10, 70)
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
    global numpadEnabled, transportEnabled
    ; Debug output - show all key presses
    ; ToolTip("Key Code: " . code . " State: " . state, 10, 50)
    SetTimer(() => ToolTip(), -1000)
    
    ; Only respond to key press (state == 1)
    if (state != 1) {
        return
    }
    
    ; Main script hotkeys (F1, F2, ESC, F12)
    ; F1 - Toggle Numpad functionality
    if (code == 59) {
        numpadEnabled := !numpadEnabled
        status := numpadEnabled ? "ON" : "OFF"
        ToolTip("Numpad Functions: " . status, 10, 10)
        SetTimer(() => ToolTip(), -2000)
        return
    }
    
    ; F2 - Toggle Transport functionality
    else if (code == 60) {
        transportEnabled := !transportEnabled
        status := transportEnabled ? "ON" : "OFF"
        ToolTip("Transport Functions: " . status, 10, 30)
        SetTimer(() => ToolTip(), -2000)
        return
    }
    
    ; ESC - Reload this script
    else if (code == 1) {
        ToolTip("Main Script: RELOADING", 10, 10)
        SetTimer(() => ToolTip(), -1000)
        Sleep(1000)
        Reload
        return
    }
    
    ; F12 - Show status
    else if (code == 88) {
        numpadStatus := numpadEnabled ? "ON" : "OFF"
        transportStatus := transportEnabled ? "ON" : "OFF"
        ToolTip("Function Status:`nNumpad: " . numpadStatus . "`nTransport: " . transportStatus, 10, 50)
        SetTimer(() => ToolTip(), -5000)  ; Hide tooltip after 5 seconds
        return
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