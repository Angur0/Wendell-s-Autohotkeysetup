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
    global mediashareLocation, obsidianLocation, discordLocation, zenLocation
    global reaperLocation, steamLocation, vscodeLocation, explorerLocation
    global clipstudiopaintLocation, davinciresolveLocation, obsLocation
    global discordIdentifier, obsidianIdentifier, zenIdentifier, reaperIdentifier
    global steamIdentifier, vscodeIdentifier, explorerIdentifier
    global clipstudiopaintIdentifier, davinciresolveIdentifier, obsIdentifier
    
    ; Load app locations from config - NumPad Key Bindings:
    mediashareLocation := IniRead(configFile, "AppLocations", "mediashare", "")      ; NumPad 0 - Media Share folder
    obsidianLocation := IniRead(configFile, "AppLocations", "obsidian", "")          ; NumPad 1 - Obsidian
    discordLocation := IniRead(configFile, "AppLocations", "discord", "")            ; NumPad 2 - Discord
    zenLocation := IniRead(configFile, "AppLocations", "zen", "")                    ; NumPad 3 - Zen Browser
    reaperLocation := IniRead(configFile, "AppLocations", "reaper", "")              ; NumPad 4 - Reaper DAW
    steamLocation := IniRead(configFile, "AppLocations", "steam", "")                ; NumPad 5 - Steam
    vscodeLocation := IniRead(configFile, "AppLocations", "vscode", "")              ; NumPad 6 - Visual Studio Code
    explorerLocation := IniRead(configFile, "AppLocations", "explorer", "")          ; NumPad 7 - File Explorer
    clipstudiopaintLocation := IniRead(configFile, "AppLocations", "clipstudiopaint", "") ; NumPad 8 - Clip Studio Paint
    davinciresolveLocation := IniRead(configFile, "AppLocations", "davinciresolve", "")   ; NumPad 9 - DaVinci Resolve
    obsLocation := IniRead(configFile, "AppLocations", "obs", "")                    ; ./delete - OBS Studio
    
    ; Load app identifiers from config
    discordIdentifier := IniRead(configFile, "AppIdentifiers", "discord", "")
    obsidianIdentifier := IniRead(configFile, "AppIdentifiers", "obsidian", "")
    zenIdentifier := IniRead(configFile, "AppIdentifiers", "zen", "")
    reaperIdentifier := IniRead(configFile, "AppIdentifiers", "reaper", "")
    steamIdentifier := IniRead(configFile, "AppIdentifiers", "steam", "")
    vscodeIdentifier := IniRead(configFile, "AppIdentifiers", "vscode", "")
    explorerIdentifier := IniRead(configFile, "AppIdentifiers", "explorer", "")
    clipstudiopaintIdentifier := IniRead(configFile, "AppIdentifiers", "clipstudiopaint", "")
    davinciresolveIdentifier := IniRead(configFile, "AppIdentifiers", "davinciresolve", "")
    obsIdentifier := IniRead(configFile, "AppIdentifiers", "obs", "")
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