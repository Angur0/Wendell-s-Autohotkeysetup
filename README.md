# Wendell's AutoHotkey Setup

This repository contains a personalized AutoHotkey setup designed to enhance productivity by using a second keyboard as a dedicated macro and shortcut device.

## Overview

The core of this setup is the `Main.ahk` script, which uses the `AutoHotInterception` library to isolate a specific keyboard. This allows for the creation of custom hotkeys that won't interfere with the primary keyboard, turning any spare USB keyboard into a powerful, custom control deck. The setup is now more modular and configurable through separate configuration files.

The scripts are written for **AutoHotkey v2**.

## Features

- **Second Keyboard Isolation:** Hotkeys are only triggered by a designated second keyboard, leaving your primary keyboard's functionality unchanged.
- **Activate on Release:** Keys activate their functions when released rather than when pressed, providing more deliberate control and preventing accidental activation.
- **Rapid-Fire Protection:** Advanced handling of rapid-fire key events from AutoHotInterception to ensure accurate hold duration detection.
- **Application Launcher:** Quickly launch your favorite applications using the numpad keys.
- **Window Management:** Switch between running applications with dedicated keys.
- **Highly Customizable:** Application paths and identifiers are managed through `config.ini`, while key mappings are in `keyconfig.ini`.
- **Modular Design:** The code is split into separate modules for easier maintenance and customization.
- **Configurable Key Codes:** All key code mappings can be edited in the `keyconfig.ini` file without modifying the code.
- **CodeChecker Tool:** Built-in tool to identify key codes and test your configuration without editing code.

## File Structure

- **`Scripts/`**
  - `Main.ahk`: The main script that runs the setup.
  - `config.ini`: Configuration file for application paths and keyboard settings.
  - `keyconfig.ini`: Key code mapping configuration. **Edit this file to change key mappings.**
   - `codetokey.ahk`: Script that handles key code to key name conversion.
   - `FKeys.ahk`: Logic for the F-key row (F1, F2, F11, F12).
   - `Numpad.ahk`: Script that handles numpad functionality.
   - `Transport.ahk`: Script that handles transport controls.
  - `keyboardclip.clip`: A file for creating physical stickers for your keyboard keys.
  - `CodeChecker`: A script used to check actual keycodes thrown by the Interception Driver.

- **`AHK v2/`**
  - Contains the `AutoHotInterception` library and related examples.

- **`Interception/`**
  - Contains the `install-interception.exe` driver, which is necessary for `AutoHotInterception` to work.

## Setup Instructions

1.  **Install the Interception Driver:**
    - Navigate to the `Interception/command line installer/` directory(open/run using commandline won't work otherwise).
    - Run `install-interception.exe`.
    - You may need to restart your computer after installation.

2.  **Find Your Keyboard's Vendor and Product ID:**
    - The script needs to know which keyboard to listen to. You can find the Vendor ID (VID) and Product ID (PID) for your second keyboard using Monitor.ahk.
    
3.  **Configure the Settings Files:**
    - Open `Scripts/config.ini` in a text editor.
      - Under `[KeyboardSettings]`, replace the `vendorId` and `productId` with the ones you found in the previous step.
      - Under `[AppLocations]`, customize the paths to your applications.
      - Under `[AppIdentifiers]`, you can set window identifiers (like `ahk_exe`) for more robust window switching.
    - Open `Scripts/keyconfig.ini` to customize key code mappings if needed.

4.  **Run the Script:**
    - Double-click `Scripts/Main.ahk` to run it. Your second keyboard should now trigger the custom hotkeys.

## Current Keybinds

Here are the current keybinds configured in the scripts:

### NumPad Application Launchers/Switchers
- **NumPad 0**: Media Share folder (opens/activates Explorer window)
- **NumPad 1**: Obsidian (launches/activates)
- **NumPad 2**: Discord (launches/activates)
- **NumPad 3**: Zen Browser (launches/activates)
- **NumPad 4**: Reaper DAW (launches/activates)
- **NumPad 5**: Steam (launches/activates)
- **NumPad 6**: Visual Studio Code (launches/activates)
- **NumPad 7**: File Explorer (launches/activates)
- **NumPad 8**: Clip Studio Paint (launches/activates)
- **NumPad 9**: DaVinci Resolve (launches/activates)

### System Controls
- **NumPad +**: Take screenshot (Print Screen)
- **NumPad -**: Minimize active window
- **NumPad ***: Minimize all windows
- **NumPad Enter**: Mouse back button (XButton1)
- **NumPad Delete**: OBS Studio (launches/activates)

### Discord Controls (Transport Keys)
- **Print Screen**: Toggle mute (Ctrl+Shift+L)
- **Scroll Lock**: Toggle deafen (Ctrl+Shift+>)
- **Pause**: Disconnect from call (Ctrl+Shift+L)

### Quick Web Navigation
- **NumLock**: Open/navigate to YouTube in Zen Browser
- **NumPad /**: Open/navigate to Facebook in Zen Browser

*Note: All keys now activate when **released** rather than when pressed, providing more deliberate control. All application launchers will switch to the app if it's already running, or launch it if it's not.*

## Customization

(MAY BE NEEDED WHEN KEY CODES DO NO ALIGN WITH ACTUAL KEYBOARD)

The setup has been designed for easy customization:

1. **Key Mappings:** 
   - Edit `keyconfig.ini` to change how key codes are mapped to key names. 
   - This file lets you remap keys without touching the code.

2. **Application Paths and Window Identifiers:** 
   - Edit `config.ini` to change application paths and window identifiers.

3. **Functionality:**
   - For more advanced customization, you can modify:
     - `Numpad.ahk` for numpad key functionality
     - `Transport.ahk` for transport control functionality
     - `Main.ahk` for core behavior and key event handling

## Keyboard Stickers

The `keyboardclip.clip` file can be used to print stickers for your second keyboard, helping you remember your custom layout.

---

*This setup is based on the work of the AutoHotInterception library creators and the broader AutoHotkey community.*

## CodeChecker Tool

The CodeChecker is a built-in debugging tool that helps identify key codes and test your configuration:

### How to Use CodeChecker

You can use the CodeChecker in two ways:

#### Option 1: As Part of the Main Script

1. **Enable Debug Mode:**
   - Run `Main.ahk` as normal
   - Press **F11** on your second keyboard to enable the Key Debug Mode.
   - A tooltip will appear confirming "Key Debug Mode: ON".

2. **Identify Key Codes:**
   - With debug mode enabled, press any key on your second keyboard.
   - A tooltip will appear showing the key name and code, e.g., "Key: NumPad1 (Code: 79)".

3. **Testing Your Configuration:**
   - Use the debug mode to verify that keys are properly mapped in your `keyconfig.ini` file.
   - If a key shows "Unknown Key (XX)" where XX is the code number, the key is not defined in your mapping.

4. **View System Status:**
   - Press **F12** to display the current status of all functions (Numpad, Transport, and Key Debug).

5. **Disable Debug Mode:**
   - Press **F11** again to disable the Key Debug Mode when finished.

#### Option 2: Run CodeChecker By Itself

If you only want to identify key codes without activating other functionality:

1. **Create a Simple CodeChecker Script:**
   - Create a new file in the Scripts folder called `CodeChecker.ahk` with the following content:
   ```ahk
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

   ; Key event handler - shows all key presses
   KeyEvent(code, state) {
       if (state == 1) {  ; Key down
           MouseGetPos(&mouseX, &mouseY)
           ToolTip("Key: " . CodeToKey(code) . " (Code: " . code . ")", mouseX + 10, mouseY + 10)
           SetTimer(() => ToolTip(), -3000)
       }
   }
   ```

2. **Run the CodeChecker:**
   - Double-click `CodeChecker.ahk` to run only the key code identification tool.
   - Press any key on your second keyboard to see its name and code.
   - The tooltip will display for 3 seconds and then disappear.
   - To exit, right-click the AutoHotkey icon in the system tray and select "Exit".

The CodeChecker makes it easy to configure your keyboard without having to edit code or guess key codes.

## Recent Updates

- **Activate on Release**: Keys now activate their functions when released rather than when pressed, providing more deliberate control
- **Rapid-Fire Protection**: Added logic to handle rapid-fire key events from AutoHotInterception properly
- **Updated Discord Controls**: Transport keys now use correct Discord keybinds (Ctrl+Shift+L for disconnect)
- **Modular Structure**: The code is now split into multiple files for better organization
- **Configuration Files**: Key mappings are now stored in `keyconfig.ini` for easy modification
- **Improved Error Handling**: Better handling of keyboard detection and reinitializing
- **Debug Mode**: Added F11 toggle for key debug mode to help with configuration
- **CodeChecker Tool**: Added built-in tool to identify key codes and test configuration
- **Consistent Key Detection**: All numpad keys now use CodeToKey() function for consistent key detection
