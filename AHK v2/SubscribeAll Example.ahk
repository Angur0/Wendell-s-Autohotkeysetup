#SingleInstance force
Persistent
#include Lib\AutoHotInterception.ahk

AHI := AutoHotInterception()

keyboardId := AHI.GetKeyboardId(0x03F0, 0x344A)
AHI.SubscribeKeyboard(keyboardId, true, KeyEvent)


KeyEvent(code, state){
	ToolTip("Keyboard Key - Code: " code ", State: " state)
}

^Esc::
{
	ExitApp
}