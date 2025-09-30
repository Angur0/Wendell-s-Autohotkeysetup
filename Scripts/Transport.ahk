; Transport.ahk
; Provides HandleTransportKey(code, state) used by Main.ahk
; Implements transport controls based on low-level key codes from AutoHotInterception.
; Uses the base mappings provided by the user request.

#include "codetokey.ahk"

; Returns: false (no reinit required). Kept for symmetry with Numpad handler.
HandleTransportKey(code, state) {
    ; Only act on key down (state == 1) – Main.ahk already filters, but keep it safe here.
    if (state != 1) {
        return false
    }

    ; PrintScreen -> Send Ctrl+Shift+| (mute toggle)
    if (CodeToKey(code) == "PrtSc") {
        ; Then send the mute toggle shortcut
        Send("^+|") ; Ctrl+Shift+M to toggle mute (per provided base)
        return false
    }

    ; Scroll Lock -> Send Ctrl+Shift+> (deafen toggle)
    if (CodeToKey(code) == "ScrLk") {
        ; Then send the deafen toggle shortcut
        Send("^+>")
        ; Close the overlay by sending the toggle shortcut again (left as-is per base)
        return false
    }

    ; Pause/Break -> Send Ctrl+Shift+L (disconnect)
    if (CodeToKey(code) == "Pause") {
        ; Send Ctrl+Shift+L to disconnect from Discord call
        Send("^+L") ; Ctrl+Shift+L (uppercase L for Discord)
        return false
    }

    return false
}
