;---------------------------------------------------------------------------------------------------------------------------------------------------------------
;Version 0.1.0 精简版
;---------------------------------------------------------------------------------------------------------------------------------------------------------------

Disable( ) ; 该段用于设置界面状态栏，请勿删改
{
    WinGet, id, ID, A
    menu := DLLCall( "user32\GetSystemMenu", "UInt", id, "UInt", 0)
    DLLCall( "user32\DeleteMenu", "UInt", menu, "UInt", 0xF060, "UInt", 0x0)
    WinGetPos ,x, y, w, h, ahk_id %id%
    WinMove, ahk_id %id%,, %x%, %y%, %w%, % h-1
    WinMove, ahk_id %id%,, %x%, %y%, %w%, % h+1
}

Gui, Start: Font, s12, 新宋体
Gui, Start: Margin , X, Y
Gui, Start: + Theme
Gui, Start: Add, Text, x+3, ; 集体缩进
Gui, Start: Add, Text,, F1:                     暂停/启用
Gui, Start: Add, Text,, F3:                     查看说明
Gui, Start: Add, Text,, 左Alt+左键:             正常左键
Gui, Start: Add, Text,, 中键:                   视角跟随
Gui, Start: Add, Text,, 左键:                   普攻/吼姆跳
Gui, Start: Add, Link,, 源码查看:               <a href="https://github.com/Spartan711/Genshin-to-Honkai-PC-Control-Project/blob/main/BH3_Hotkey.ahk">传送门</a>
Gui, Start: Add, Text,, 
Gui, Start: Add, Text,, 其它键位请在游戏设置界面内自行更改
Gui, Start: Add, Text,, 
Gui, Start: Add, Button, xn w333, 开启
Gui, Start: Show, xCenter yCenter, 设置说明
Disable( )
Suspend, On
Return

StartButton开启:
Suspend, Off
Gui, Start: Destroy
SetTimer, AutoFadeMsgbox, -1200
MsgBox, 0, 提示, 程序已开始运行（在游戏内按F1以停用）
SetTimer, AutoFadeMsgbox, Off
Return

AutoFadeMsgbox:
DLLCall( "AnimateWindow", UInt, WinExist( "提示 ahk_class #32770"), Int, 500, UInt, 0x90000)
Return

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

#IfWinActive ahk_exe BH3.exe ; 【宏条件】检测崩坏3游戏窗口，使程序仅在崩坏3游戏运行时生效

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

SwitchIME(dwLayout) ; 该段用于管理输入法，请勿删改
{
    HKL := DllCall( "LoadKeyboardLayout", Str, dwLayout, UInt, 1)
    ControlGetFocus, ctl, A
    SendMessage, 0x50, 0, HKL, %ctl%, A
}

F1:: ; 暂停/ 启用程序——若想正常使用鼠标请按该键或按住ALT键
Suspend, Toggle    
WinSet, AlwaysOnTop, Off, A
Send, {Click, Up}{Click, Up Middle}
SwitchIME(0x04090409) ; 切换至"中文(中国) 简体中文-美式键盘"
;Send, #{space} ; [未启用命令行] 微软拼音用户可用该命令
if (A_IsSuspended=1)
    ToolTip, 暂停中, 0, 999 ; 可调校数值
else if (A_IsSuspended=0)
{
    ToolTip, 已启用, 0, 999 ; 可调校数值
    Sleep 210 ; 可调校数值
    ToolTip
}
Return

F3:: ; 重启程序以呼出操作说明界面
Suspend, Off
Reload 
Return

#Tab::
Suspend, On    
WinSet, AlwaysOnTop, Off, A
Send, {Click, Up}{Click, Up Middle}
SwitchIME(0x04090409) ; 切换至"中文(中国) 简体中文-美式键盘"
;Send, #{Space} ; [未启用命令行] 微软拼音用户可用该命令
if (A_IsSuspended=1)
    ToolTip, 暂停中, 0, 999 ; 可调校数值
Sleep 99 ; 可调校数值
SendEvent, #{Tab}
Return

!Tab::
Suspend, On    
WinSet, AlwaysOnTop, Off, A
Send, {Click, Up}{Click, Up Middle}
SwitchIME(0x04090409) ; 切换至"中文(中国) 简体中文-美式键盘"
;Send, #{Space} ; [未启用命令行] 微软拼音用户可用该命令
if (A_IsSuspended=1)
    ToolTip, 暂停中, 0, 999 ; 可调校数值
Sleep 99 ; 可调校数值
SendEvent, !{Tab}
Return

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

*!LButton::LButton ; 按住ALT以正常使用鼠标左键

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

MButton:: ; 点击鼠标中键以激活视角跟随
SendInput, {Click, Up Middle}
Return

MButton Up:: 
SendInput, {Click, Down}
Return

LButton:: ; 点按鼠标左键以发动普攻
Send, {j Down}
KeyWait, LButton
Send, {j Up}
SendInput, {Click, Up Middle}
Loop := True
SetTimer, ViewControl, -99 ; [可调校数值] 设定视角跟随命令的每执行间隔时间(ms)
Return

ViewControl:
if WinActive("ahk_exe BH3.exe")
{
    SendInput, {Click, Down Middle}
    CoordMode, Window
    WinGetPos, X, Y, Width, Height, ahk_exe BH3.exe
    MouseMove, Width/2, Height/2, 0 ; [建议保持数值]
}
Return

;---------------------------------------------------------------------------------------------------------------------------------------------------------------
;目前就这些，可根据需要自行修改
;---------------------------------------------------------------------------------------------------------------------------------------------------------------