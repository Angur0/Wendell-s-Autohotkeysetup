# Wendell's AutoHotkey Setup

A modular AutoHotkey v2 setup that transforms a second keyboard into a powerful macro and application launcher device using the AutoHotInterception library.

## 🎯 Overview

This setup uses AutoHotInterception to isolate a specific keyboard, allowing you to create custom hotkeys that won't interfere with your primary keyboard. Turn any spare USB keyboard into a custom control deck with over 97 programmable keys organized into logical rows.

**Key Features:**
- 🎹 **Modular Row-Based Architecture** - Each keyboard row has its own handler file
- ⚡ **Activate on Release** - Keys trigger on release for deliberate control
- 🛡️ **Rapid-Fire Protection** - Prevents accidental double-triggers
- 🔄 **Auto-Setup** - Automatically generates config files when compiled to .exe
- 🎯 **Toggle Rows** - F-keys enable/disable entire keyboard rows
- 🐛 **Debug Mode** - Built-in key code detection and testing
- 📦 **Portable** - Works as compiled .exe with zero manual setup

## 📁 File Structure

### Core Scripts
- **`Main.ahk`** - Main control script and key event handler
- **`AutoSetup.ahk`** - Auto-generates missing config files
- **`codetokey.ahk`** - Converts key codes to readable names

### Row Handlers (All Customizable)
- **`FKeys.ahk`** - F1-F12 toggle controls and debug mode
- **`NumberRow.ahk`** - Tilde, 1-9, 0, -, =, \, Backspace (15 keys) ⚠️ UNBOUND
- **`QwertyRow.ahk`** - Tab, Q-P, [, ] (13 keys) ⚠️ UNBOUND
- **`AsdfRow.ahk`** - CapsLock, A-L, ;, ', Enter (13 keys) ⚠️ UNBOUND
- **`ZxcvRow.ahk`** - Shifts, Z-M, comma, period, / (12 keys) ⚠️ UNBOUND
- **`CtrlSpaceRow.ahk`** - Ctrl, Win, Alt, Space, etc. (8 keys) ⚠️ UNBOUND
- **`TransportKeys.ahk`** - PrtSc/ScrLk/Pause + Arrow/Nav keys (13 keys, 3 bound)
- **`EscKey.ahk`** - Escape (reloads script, always active)
- **`Numpad.ahk`** - NumPad 0-9 + operators (17 keys, all bound)

### Configuration Files
- **`config.ini`** - Application paths, window identifiers, keyboard VID/PID
- **`keyconfig.ini`** - Key code to key name mappings

### Libraries
- **`Lib/AutoHotInterception.ahk`** - AutoHotInterception library
- **`Lib/x64/interception.dll`** - Interception driver DLL
- **`Lib/AutoHotInterception.dll`** - AutoHotInterception DLL

## 🚀 Quick Start

### Prerequisites
1. **AutoHotkey v2** - Download from [autohotkey.com](https://www.autohotkey.com/)
2. **Second USB Keyboard** - Any USB keyboard will work
3. **Administrator Access** - Required for Interception driver installation

### Installation

1. **Install Interception Driver:**
   ```powershell
   cd "Interception/command line installer/"
   ./install-interception.exe
   # Restart computer after installation
   ```

2. **Find Your Keyboard IDs:**
   - Run `Scripts/Monitor.ahk`
   - Press keys on your second keyboard
   - Note the **Vendor ID** (VID) and **Product ID** (PID)
   - Example: `VID: 0x03F0, PID: 0x344A`

3. **Configure Keyboard Settings:**
   - Edit `Scripts/config.ini`
   - Update `[KeyboardSettings]` section:
     ```ini
     vendorId=0x03F0
     productId=0x344A
     ```

4. **Run the Script:**
   - Double-click `Scripts/Main.ahk`
   - Or compile to .exe (see Compilation section)

### First Run (Compiled .exe)
If running as a compiled .exe, the script will automatically:
- Create `config.ini` with default settings
- Create `keyconfig.ini` with key mappings
- Show a message to update keyboard VID/PID
- Use your Windows username in application paths

## 🎮 Current Keybinds

### F-Keys (Toggle Controls)
| Key | Function | Description |
|-----|----------|-------------|
| **F1** | Toggle Numpad | Enable/disable numpad functions |
| **F2** | Toggle Transport | Enable/disable transport keys |
| **F3** | Toggle Number Row | Enable/disable number row |
| **F4** | Toggle QWERTY Row | Enable/disable QWERTY row |
| **F5** | Toggle ASDF Row | Enable/disable ASDF row |
| **F6** | Toggle ZXCV Row | Enable/disable ZXCV row |
| **F7** | Toggle Ctrl/Space | Enable/disable Ctrl/Space row |
| **F8** | Unassigned | Available for custom use |
| **F9** | Unassigned | Available for custom use |
| **F10** | Unassigned | Available for custom use |
| **F11** | Debug Mode | Toggle key code display |
| **F12** | Status Display | Hold to show all toggle states |

*Note: All F-keys show preview tooltip while held, toggle on release*

### NumPad (Application Launchers)
| Key | Application | Action |
|-----|-------------|--------|
| **0** | Media Share Folder | Open/activate folder in Explorer |
| **1** | Obsidian | Launch/switch to Obsidian |
| **2** | Discord | Launch/switch to Discord |
| **3** | Zen Browser | Launch/switch to Zen |
| **4** | Reaper DAW | Launch/switch to Reaper |
| **5** | Steam | Launch/switch to Steam |
| **6** | VS Code | Launch/switch to VS Code |
| **7** | File Explorer | Launch/switch to Explorer |
| **8** | Clip Studio Paint | Launch/switch to CSP |
| **9** | DaVinci Resolve | Launch/switch to Resolve |
| **+** | Screenshot | Send Print Screen |
| **-** | Minimize Window | Minimize active window |
| ***** | Show Desktop | Minimize all windows |
| **Enter** | Mouse Back | XButton1 (back button) |
| **Del** | OBS Studio | Launch/switch to OBS |
| **NumLock** | YouTube | Navigate to YouTube in Zen |
| **/** | Facebook | Navigate to Facebook in Zen |

### Transport Keys (Discord Controls)
| Key | Function | Shortcut |
|-----|----------|----------|
| **PrtSc** | Toggle Mute | Ctrl+Shift+\| |
| **ScrLk** | Toggle Deafen | Ctrl+Shift+> |
| **Pause** | Disconnect | Ctrl+Shift+L |
| **Insert** | Unassigned | - |
| **Home** | Unassigned | - |
| **PgUp** | Unassigned | - |
| **Delete** | Unassigned | - |
| **End** | Unassigned | - |
| **PgDn** | Unassigned | - |
| **Arrow Keys** | Unassigned | - |

### Escape Key
| Key | Function | Toggle |
|-----|----------|--------|
| **Esc** | Reload Script | Always ON |

*Note: Escape key cannot be disabled - it's your failsafe!*

## 📊 Binding Statistics

- **Total Keys**: ~97 programmable keys
- **Bound Keys**: ~25 keys (26%)
- **Unbound Keys**: ~72 keys (74%)

### Unbound Rows (Ready for Customization)
- Number Row: 15 keys
- QWERTY Row: 13 keys
- ASDF Row: 13 keys
- ZXCV Row: 12 keys
- Ctrl/Space Row: 8 keys
- Transport Navigation: 10 keys

See `UNBOUND_KEYS.md` for complete list.

## ⚙️ Customization

### Adding Functions to Unbound Keys

1. Open the appropriate row handler file (e.g., `NumberRow.ahk`)
2. Find the handler function (e.g., `NumberRow_Handle1(state)`)
3. Replace `; Add your function here` with your code:

```ahk
NumberRow_Handle1(state) {
    if (state != 1)
        return false

    ; Your custom function here
    Send("^c")  ; Example: Copy
    
    return true
}
```

### Modifying Application Paths

Edit `config.ini` under `[AppLocations]`:
```ini
obsidian=C:\Path\To\Your\Obsidian.lnk
```

### Changing Key Mappings

Edit `keyconfig.ini` to remap scan codes:
```ini
[KeyCodeMap]
82=NumPad0  ; Change to any key name
```

## 🔧 Debug Mode

### Enable Debug Mode
1. Press **F11** on your second keyboard
2. Tooltip shows: "Key Debug: OFF → Will toggle to: ON"
3. Release F11 to activate
4. Press any key to see its name and code

### Debug Output Example
```
Key: NumPad1 (Code: 79) State: 1
ACTIVATING: NumPad1 held for 245ms
```

### View Status
- Hold **F12** to see all row toggle states
- Release to hide tooltip

## 📦 Compilation

### Using AutoHotkey Dash

1. **Install AutoHotkey Dash:**
   - Download from [https://www.autohotkey.com/](https://www.autohotkey.com/)
   - Or use the AutoHotkey installer that includes Dash

2. **Open in Dash:**
   - Right-click `Main.ahk`
   - Select "Open with AutoHotkey Dash"
   - Or drag `Main.ahk` into Dash window

3. **Configure Compilation:**
   - Click the **"Compile"** button (or press F7)
   - In the compile dialog:
     - **Source (script file)**: Should auto-fill with `Main.ahk`
     - **Destination (.exe file)**: Choose output location
     - **Base File**: Select `AutoHotkey64.exe` (for 64-bit)
     - **Use MPRESS**: Optional (compresses .exe)

4. **Advanced Options** (Optional):
   - Click "Advanced" to set:
     - Custom icon (.ico file)
     - Company name, version, description
     - Administrator rights requirement

5. **Compile:**
   - Click **"Compile"** button
   - Wait for completion message
   - Your .exe is ready!

### Using Command Line (Alternative)

If you prefer command line compilation:

```powershell
# Using Ahk2Exe compiler directly
"C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in "Scripts\Main.ahk" /out "MyKeyboard.exe" /base "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe"
```

### Important Notes for Compilation

1. **Include All Files:**
   - Make sure the .exe is in the same folder as:
     - `Lib/` folder (with all DLLs)
     - All row handler `.ahk` files
     - `codetokey.ahk`, `AutoSetup.ahk`
   
2. **Auto-Generated Files:**
   - `config.ini` and `keyconfig.ini` will be created automatically on first run
   - Edit them after first launch to configure your keyboard

3. **Distribution:**
   - Package the `.exe` with the `Lib/` folder
   - Users will need to install the Interception driver separately
   - Config files will be created automatically

## 🛠️ Troubleshooting

### Keyboard Not Detected
- Run `Monitor.ahk` to verify VID/PID
- Check `config.ini` has correct values
- Ensure Interception driver is installed
- Restart computer after driver installation

### Keys Not Responding
- Press **F11** to enable debug mode
- Verify keys are being detected
- Check if row is enabled (press corresponding F-key)
- Ensure `keyconfig.ini` has correct mappings

### Application Won't Launch
- Verify path in `config.ini` exists
- Check application identifier in `[AppIdentifiers]`
- Use debug mode to test key presses

### Steam Requires Reinitialization
- This is normal - Steam interferes with input
- Script automatically reinitializes keyboard connection
- Brief pause expected when switching to/from Steam

## 🔄 Recent Updates

- ✅ Modular row-based architecture
- ✅ F-key toggle controls for each row
- ✅ Auto-setup for compiled .exe
- ✅ Hold-to-preview toggle behavior
- ✅ Escape key always active (undisableable)
- ✅ Moved tilde to number row
- ✅ Combined arrow/navigation keys into TransportKeys
- ✅ Removed old Transport.ahk and PrintScreenKeys.ahk
- ✅ Fixed rapid-fire prevention for F-keys

## 📝 License

This setup is based on the AutoHotInterception library and the AutoHotkey community's work.

## 🙏 Credits

- **AutoHotInterception** - For keyboard isolation functionality
- **Interception Driver** - For low-level keyboard hooking
- **AutoHotkey Community** - For the amazing scripting language

---

**Need Help?** Check `UNBOUND_KEYS.md` for a complete list of available keys to customize!
