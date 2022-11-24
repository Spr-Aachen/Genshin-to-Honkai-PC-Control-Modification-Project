;---------------------------------------------------------------------------------------------------------------------------------------------------------------
; 这里用于存放安装功能相关的代码。记得在打包成可执行（EXE）文件后要放到EXE文件夹中哦
;---------------------------------------------------------------------------------------------------------------------------------------------------------------


#SingleInstance, Force


;SetWorkingDir, %A_WorkingDir%


full_command_line := DllCall("GetCommandLine", "str")
If Not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    Try
    {
        If A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        Else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}


Try
    RunWait, PowerShell.exe -Command "Move-Item -Path ./Temp/BH3_Hotkey.exe -Destination ./ -Force", , Hide
Catch
	MsgBox, 16, Warning, Failed to run Shell!
Finally
    Run, ../BH3_Hotkey.exe
ExitApp


;---------------------------------------------------------------------------------------------------------------------------------------------------------------