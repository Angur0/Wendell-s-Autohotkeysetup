CodeToKey(keyCode) {
    static keyCodeMap := LoadKeyCodeMap()
    
    ; Return the key name if found, otherwise return the code
    return keyCodeMap.Has(keyCode) ? keyCodeMap[keyCode] : "Unknown Key (" . keyCode . ")"
}

; Function to load the key mappings from the keyconfig.ini file
LoadKeyCodeMap() {
    keyCodeMap := Map()
    configFile := A_ScriptDir . "\keyconfig.ini"
    
    ; Check if the config file exists
    if (!FileExist(configFile)) {
        MsgBox("Key configuration file not found: " . configFile)
        return keyCodeMap
    }
    
    ; Read the file contents directly
    fileContent := FileRead(configFile)
    inKeyCodeMapSection := false
    
    ; Parse the file content line by line
    Loop Parse, fileContent, "`n", "`r" {
        line := Trim(A_LoopField)
        
        ; Skip empty lines
        if (line = "")
            continue
        
        ; Check for section headers
        if (SubStr(line, 1, 1) = "[" && SubStr(line, -1) = "]") {
            sectionName := SubStr(line, 2, StrLen(line) - 2)
            inKeyCodeMapSection := (sectionName = "KeyCodeMap")
            continue
        }
        
        ; Process key-value pairs in the KeyCodeMap section
        if (inKeyCodeMapSection) {
            ; Split the line into key and value
            parts := StrSplit(line, "=", , 2)
            if (parts.Length = 2) {
                keyPart := Trim(parts[1])
                ; Check if this is a valid number (skips actual comment lines)
                if (RegExMatch(keyPart, "^\d+$")) {
                    keyCode := Integer(keyPart)
                    keyName := Trim(parts[2])
                    keyCodeMap[keyCode] := keyName
                }
            }
        }
    }
    
    return keyCodeMap
}


; Function that converts AHI key codes to readable key names
; Uses keyconfig.ini file to map key codes to readable names
; Usage: keyName := CodeToKey(keyCode)