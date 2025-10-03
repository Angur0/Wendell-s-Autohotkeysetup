# Unbound Keys Summary

## F-Key Assignments
- **F1** - Toggle Numpad Functions ON/OFF
- **F2** - Toggle Transport Keys ON/OFF
- **F3** - Toggle Number Row ON/OFF
- **F4** - Toggle QWERTY Row ON/OFF
- **F5** - Toggle ASDF Row ON/OFF
- **F6** - Toggle ZXCV Row ON/OFF
- **F7** - Toggle Ctrl/Space Row ON/OFF
- **F8** - Toggle Escape Key ON/OFF
- **F9** - ⚠️ **UNBOUND** (Available for future use)
- **F10** - ⚠️ **UNBOUND** (Available for future use)
- **F11** - Toggle Debug Mode ON/OFF
- **F12** - Show Status Tooltip (hold to view)

---

## Numpad Keys - All Bound ✓
All numpad keys (0-9, operators, etc.) are bound in `Numpad.ahk` to launch various applications.

---

## Transport Keys Section - Partially Bound
### Bound Keys:
- **PrtSc** - Send Ctrl+Shift+| (mute toggle)
- **ScrLk** - Send Ctrl+Shift+> (deafen toggle)
- **Pause** - Send Ctrl+Shift+L (disconnect)

### Unbound Keys:
- **Insert** - ⚠️ UNBOUND
- **Home** - ⚠️ UNBOUND
- **Page Up** - ⚠️ UNBOUND
- **Delete** - ⚠️ UNBOUND
- **End** - ⚠️ UNBOUND
- **Page Down** - ⚠️ UNBOUND
- **Up Arrow** - ⚠️ UNBOUND
- **Down Arrow** - ⚠️ UNBOUND
- **Left Arrow** - ⚠️ UNBOUND
- **Right Arrow** - ⚠️ UNBOUND

---

## Number Row - All Unbound ⚠️
All keys in this row have placeholder functions in `NumberRow.ahk`:
- **~** (Tilde) - UNBOUND
- **1** - UNBOUND
- **2** - UNBOUND
- **3** - UNBOUND
- **4** - UNBOUND
- **5** - UNBOUND
- **6** - UNBOUND
- **7** - UNBOUND
- **8** - UNBOUND
- **9** - UNBOUND
- **0** - UNBOUND
- **-** (Minus) - UNBOUND
- **=** (Equals) - UNBOUND
- **\\** (Backslash) - UNBOUND
- **Backspace** - UNBOUND

---

## QWERTY Row - All Unbound ⚠️
All keys in this row have placeholder functions in `QwertyRow.ahk`:
- **Tab** - UNBOUND
- **Q** - UNBOUND
- **W** - UNBOUND
- **E** - UNBOUND
- **R** - UNBOUND
- **T** - UNBOUND
- **Y** - UNBOUND
- **U** - UNBOUND
- **I** - UNBOUND
- **O** - UNBOUND
- **P** - UNBOUND
- **[** (Left Bracket) - UNBOUND
- **]** (Right Bracket) - UNBOUND

---

## ASDF Row - All Unbound ⚠️
All keys in this row have placeholder functions in `AsdfRow.ahk`:
- **CapsLock** - UNBOUND
- **A** - UNBOUND
- **S** - UNBOUND
- **D** - UNBOUND
- **F** - UNBOUND
- **G** - UNBOUND
- **H** - UNBOUND
- **J** - UNBOUND
- **K** - UNBOUND
- **L** - UNBOUND
- **;** (Semicolon) - UNBOUND
- **'** (Apostrophe) - UNBOUND
- **Enter** - UNBOUND

---

## ZXCV Row - All Unbound ⚠️
All keys in this row have placeholder functions in `ZxcvRow.ahk`:
- **Left Shift** - UNBOUND
- **Z** - UNBOUND
- **X** - UNBOUND
- **C** - UNBOUND
- **V** - UNBOUND
- **B** - UNBOUND
- **N** - UNBOUND
- **M** - UNBOUND
- **,** (Comma) - UNBOUND
- **.** (Period) - UNBOUND
- **/** (Slash) - UNBOUND
- **Right Shift** - UNBOUND

---

## Ctrl/Space Row - All Unbound ⚠️
All keys in this row have placeholder functions in `CtrlSpaceRow.ahk`:
- **Left Ctrl** - UNBOUND
- **Windows** - UNBOUND
- **Left Alt** - UNBOUND
- **Space** - UNBOUND
- **Right Alt** - UNBOUND
- **Left Win** - UNBOUND
- **Menu** - UNBOUND
- **Right Ctrl** - UNBOUND

---

## Escape Key
- **Esc** - Bound to Reload Script (in `EscKey.ahk`)

---

## Summary Statistics
- **Total Trackable Keys**: ~97 keys
- **Bound Keys**: ~25 keys (Numpad: 17, Transport: 3, F-keys: 4, Esc: 1)
- **Unbound Keys**: ~72 keys
- **Percentage Bound**: ~26%

## Files with Unbound Functions:
1. `NumberRow.ahk` - 15 unbound keys
2. `QwertyRow.ahk` - 13 unbound keys
3. `AsdfRow.ahk` - 13 unbound keys
4. `ZxcvRow.ahk` - 12 unbound keys
5. `CtrlSpaceRow.ahk` - 8 unbound keys
6. `TransportKeys.ahk` - 10 unbound keys (arrow keys and nav cluster)
7. `FKeys.ahk` - 2 unbound keys (F9, F10)

---

## Notes:
- All unbound keys have placeholder functions with `; Add your function here` comments
- You can add custom functionality to any unbound key by editing its respective handler file
- Use F12 to view current status of all row toggles
- Use F11 to enable debug mode and see key codes/names when pressed
