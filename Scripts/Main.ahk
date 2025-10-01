#SingleInstance force
Persistent

; Main control script for managing Numpad and Transport scripts
; Uses the same keyboard as defined in the config 
; post revert

#include "Lib\AutoHotInterception.ahk"
#include "codetokey.ahk"
#include "FKeys.ahk"
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
    static heldKeys := Map() ; Track which keys are currently held down
    static keyPressTime := Map() ; Track when keys were first pressed
    
    ; Show key names when debug mode is on
    if (debugKeysEnabled) {
        MouseGetPos(&mouseX, &mouseY)
        ToolTip("Key: " . CodeToKey(code) . " (Code: " . code . ") State: " . state, mouseX + 10, mouseY + 10)
        SetTimer(() => ToolTip(), -2000)
    }
    
    ; Handle F-key row actions (these still respond immediately on press)
    if (FKeys_HandleEvent(code, state)) {
        return
    }
    
    ; Track key press/release states
    if (state == 1) {
        ; Key pressed down
        heldKeys[code] := true
        keyPressTime[code] := A_TickCount
        return ; Don't activate functions on press, wait for release
    } else if (state == 0) {
        ; Key released
        if (!heldKeys.Has(code)) {
            return ; Key wasn't tracked as pressed
        }
        
        ; Calculate how long the key was held
        holdDuration := A_TickCount - keyPressTime[code]
        
        ; Clean up tracking
        heldKeys.Delete(code)
        keyPressTime.Delete(code)
        
        ; Remove minimum hold time requirement for now to test
        ; if (holdDuration < 50) {
        ;     return
        ; }
        
        ; Show debug info when key is released and will activate
        if (debugKeysEnabled) {
            MouseGetPos(&mouseX, &mouseY)
            ToolTip("ACTIVATING: " . CodeToKey(code) . " held for " . holdDuration . "ms", mouseX + 10, mouseY + 10)
            SetTimer(() => ToolTip(), -3000)
        }
        
        ; ESC - Reload this script (now activates on release)
        if (CodeToKey(code) == "Esc") {
            ToolTip("Main Script: RELOADING", 10, 10)
            SetTimer(() => ToolTip(), -1000)
            Sleep(1000)
            Reload
            return
        }
        
        ; Delegate to numpad functions if enabled (now activates on release)
        if (numpadEnabled) {
            needsReinit := HandleNumpadKey(code, 1) ; Pass state as 1 since functions expect press event
            if (needsReinit) {
                ; Steam or other app needs keyboard reinitialization
                ReinitializeKeyboard()
            }
        }
        
        ; Delegate to transport functions if enabled (now activates on release)
        if (transportEnabled) {
            HandleTransportKey(code, 1) ; Pass state as 1 since functions expect press event
        }
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