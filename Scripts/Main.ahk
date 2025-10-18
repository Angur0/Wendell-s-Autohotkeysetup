#SingleInstance force
Persistent

; Main control script for managing Numpad and Transport scripts
; Uses the same keyboard as defined in the config 
; post revert

#include "Lib\AutoHotInterception.ahk"
#include "AuxFunction\codetokey.ahk"
#include "AuxFunction\AutoSetup.ahk"
#include "KeyFunction\FKeys.ahk"
#include "KeyFunction\Numpad.ahk"
#include "KeyFunction\NumberRow.ahk"
#include "KeyFunction\QwertyRow.ahk"
#include "KeyFunction\AsdfRow.ahk"
#include "KeyFunction\ZxcvRow.ahk"
#include "KeyFunction\CtrlSpaceRow.ahk"
#include "KeyFunction\TransportKeys.ahk"
#include "KeyFunction\EscKey.ahk"

;############### AUTO-GENERATE MISSING FILES ########################
; Create necessary files/folders if they don't exist (useful for compiled .exe)
EnsureRequiredFilesExist()

;############### LOAD CONFIGURATION ########################
configFile := A_ScriptDir . "\config.ini"

; Load keyboard settings from config
vendorId := IniRead(configFile, "KeyboardSettings", "vendorId",)
productId := IniRead(configFile, "KeyboardSettings", "productId",)

; Convert hex string values to 16-bit integers
vendorIdInt := Integer(vendorId) & 0xFFFF
productIdInt := Integer(productId) & 0xFFFF

; Load all application configurations
LoadAppConfig()

;############### CONFIG LOADER FUNCTION ########################
; Function to load all app locations and identifiers from config.ini
LoadAppConfig() {
    global configFile
    global app1Location, app2Location, app3Location, app4Location, app5Location
    global app6Location, app7Location, app8Location, app9Location, app10Location, app11Location, app12Location
    global app1Identifier, app2Identifier, app3Identifier, app4Identifier, app5Identifier
    global app6Identifier, app7Identifier, app8Identifier, app9Identifier, app10Identifier, app11Identifier, app12Identifier

    
    ; Load app locations from config - NumPad Key Bindings:
    app1Location := IniRead(configFile, "AppLocations", "app1", "")      ; NumPad 0
    app2Location := IniRead(configFile, "AppLocations", "app2", "")      ; NumPad 1
    app3Location := IniRead(configFile, "AppLocations", "app3", "")      ; NumPad 2
    app4Location := IniRead(configFile, "AppLocations", "app4", "")      ; NumPad 3
    app5Location := IniRead(configFile, "AppLocations", "app5", "")      ; NumPad 4
    app6Location := IniRead(configFile, "AppLocations", "app6", "")      ; NumPad 5
    app7Location := IniRead(configFile, "AppLocations", "app7", "")      ; NumPad 6
    app8Location := IniRead(configFile, "AppLocations", "app8", "")      ; NumPad 7
    app9Location := IniRead(configFile, "AppLocations", "app9", "")      ; NumPad 8
    app10Location := IniRead(configFile, "AppLocations", "app10", "")    ; NumPad 9
    app11Location := IniRead(configFile, "AppLocations", "app11", "")    ; ./delete
    app12Location := IniRead(configFile, "AppLocations", "app12", "")    ; Mouse without Borders

    ; Load app identifiers from config
    app1Identifier := IniRead(configFile, "AppIdentifiers", "app1", "")
    app2Identifier := IniRead(configFile, "AppIdentifiers", "app2", "")
    app3Identifier := IniRead(configFile, "AppIdentifiers", "app3", "")
    app4Identifier := IniRead(configFile, "AppIdentifiers", "app4", "")
    app5Identifier := IniRead(configFile, "AppIdentifiers", "app5", "")
    app6Identifier := IniRead(configFile, "AppIdentifiers", "app6", "")
    app7Identifier := IniRead(configFile, "AppIdentifiers", "app7", "")
    app8Identifier := IniRead(configFile, "AppIdentifiers", "app8", "")
    app9Identifier := IniRead(configFile, "AppIdentifiers", "app9", "")
    app10Identifier := IniRead(configFile, "AppIdentifiers", "app10", "")
    app11Identifier := IniRead(configFile, "AppIdentifiers", "app11", "")
    app12Identifier := IniRead(configFile, "AppIdentifiers", "app12", "")

}


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
transportKeysEnabled := true
numberRowEnabled := true
qwertyRowEnabled := true
asdfRowEnabled := true
zxcvRowEnabled := true
ctrlSpaceRowEnabled := true
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
    global numpadEnabled, transportKeysEnabled, numberRowEnabled
    global qwertyRowEnabled, asdfRowEnabled, zxcvRowEnabled, ctrlSpaceRowEnabled
    global debugKeysEnabled
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
        
        ; Remove minimum hold time requirement for now till fixed
        ; if (holdDuration < 50) {
        ;     return
        ; }
        
        ; Show debug info when key is released and will activate
        if (debugKeysEnabled) {
            MouseGetPos(&mouseX, &mouseY)
            ToolTip("ACTIVATING: " . CodeToKey(code) . " held for " . holdDuration . "ms", mouseX + 10, mouseY + 10)
            SetTimer(() => ToolTip(), -3000)
        }
        
        ; Escape key always active (cannot be disabled)
        if (EscKey_HandleEvent(code, 1)) {
            return
        }
        
        ; Delegate to number row handler if enabled (now activates on release)
        if (numberRowEnabled) {
            if (NumberRow_HandleEvent(code, 1)) {
                return
            }
        }
        
        ; Delegate to qwerty row handler if enabled (now activates on release)
        if (qwertyRowEnabled) {
            if (QwertyRow_HandleEvent(code, 1)) {
                return
            }
        }
        
        ; Delegate to asdf row handler if enabled (now activates on release)
        if (asdfRowEnabled) {
            if (AsdfRow_HandleEvent(code, 1)) {
                return
            }
        }
        
        ; Delegate to zxcv row handler if enabled (now activates on release)
        if (zxcvRowEnabled) {
            if (ZxcvRow_HandleEvent(code, 1)) {
                return
            }
        }
        
        ; Delegate to ctrl/space row handler if enabled (now activates on release)
        if (ctrlSpaceRowEnabled) {
            if (CtrlSpaceRow_HandleEvent(code, 1)) {
                return
            }
        }
        
        ; Delegate to transport keys handler if enabled (now activates on release)
        if (transportKeysEnabled) {
            if (TransportKeys_HandleEvent(code, 1)) {
                return
            }
        }
        
        ; Delegate to numpad functions if enabled (now activates on release)
        if (numpadEnabled) {
            needsReinit := HandleNumpadKey(code, 1) ; Pass state as 1 since functions expect press event
            if (needsReinit) {
                ; Steam or other app needs keyboard reinitialization
                ReinitializeKeyboard()
            }
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