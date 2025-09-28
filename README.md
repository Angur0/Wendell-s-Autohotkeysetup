# Wendell's AutoHotkey Setup

This repository contains a personalized AutoHotkey setup designed to enhance productivity by using a second keyboard as a dedicated macro and shortcut device.

## Overview

The core of this setup is the `Secondkeyboard.ahk` script, which uses the `AutoHotInterception` library to isolate a specific keyboard. This allows for the creation of custom hotkeys that won't interfere with the primary keyboard, turning any spare USB keyboard into a powerful, custom control deck.

The scripts are written for **AutoHotkey v2**.

## Features

- **Second Keyboard Isolation:** Hotkeys are only triggered by a designated second keyboard, leaving your primary keyboard's functionality unchanged.
- **Application Launcher:** Quickly launch your favorite applications using the numpad keys.
- **Window Management:** Switch between running applications with dedicated keys.
- **Highly Customizable:** All application paths, identifiers, and keyboard settings are managed through a simple `config.ini` file.
- **Cheatsheet Included:** A `Cheatsheet.ahk` file is provided with a list of key codes for easy customization.

## File Structure

- **`Scripts/`**
  - `Secondkeyboard.ahk`: The main script that runs the setup.
  - `config.ini`: The configuration file. **This is the main file you need to edit.**
  - `Cheatsheet.ahk`: A reference guide for AutoHotkey key codes.
  - `keyboardclip.clip`: A file for creating physical stickers for your keyboard keys.

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
    
3.  **Configure `config.ini`:**
    - Open `Scripts/config.ini` in a text editor.
    - Under `[KeyboardSettings]`, replace the `vendorId` and `productId` with the ones you found in the previous step.
    - Under `[AppLocations]`, customize the paths to your applications.
    - Under `[AppIdentifiers]`, you can set window identifiers (like `ahk_exe`) for more robust window switching.

4.  **Run the Script:**
    - Double-click `Scripts/Secondkeyboard.ahk` to run it. Your second keyboard should now trigger the custom hotkeys.

## Customization

You can change the hotkeys and their actions by editing `Secondkeyboard.ahk`. The `Cheatsheet.ahk` file provides the necessary key codes to assign new actions to different keys on your second keyboard.

## Keyboard Stickers

The `keyboardclip.clip` file can be used to print stickers for your second keyboard, helping you remember your custom layout.

---

*This setup is based on the work of the AutoHotInterception library creators and the broader AutoHotkey community.*
