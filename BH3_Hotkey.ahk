;---------------------------------------------------------------------------------------------------------------------------------------------------------------
;Version 0.1.0
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
Gui, Start: Add, Text,, 左ShIft/右键:           闪避/冲刺
Gui, Start: Add, Text,, Z:                      人偶技
Gui, Start: Add, Text,, Q:                      必杀技
Gui, Start: Add, Text,, E:                      武器技/后崩必杀技
Gui, Start: Add, Text,, 方向键:                 准心控制
Gui, Start: Add, Text,, 中键:                   视角跟随
Gui, Start: Add, Text,, 左键:                   普攻/吼姆跳
Gui, Start: Add, Link,, 源码查看:               <a href="https://github.com/Spartan711/Genshin-to-Honkai-PC-Control-Project/blob/main/BH3_Hotkey.ahk">传送门</a>
Gui, Start: Add, Text,,
Gui, Start: Add, Button, xn w333, 开启
Gui, Start: Show, xCenter yCenter, 设置说明
Disable( )
Suspend, On
Return

StartButton开启:
Suspend, Off
Gui, Start: Destroy
SetTimer, AutoFadeMsgbox, -1200 ; [可调校数值] 使消息弹窗仅存在一段时间(ms)
MsgBox, 0, 提示, 程序已开始运行（在游戏内按F1以停用）
SetTimer, AutoFadeMsgbox, Off
Return

AutoFadeMsgbox:
DLLCall( "AnimateWindow", UInt, WinExist( "提示 ahk_class #32770"), Int, 500, UInt, 0x90000)
Return

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

#IfWinActive ahk_exe BH3.exe ; 【宏条件】检测崩坏3游戏窗口，使程序仅在崩坏3游戏运行时生效

Global M_Toggle=0

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
SetTimer, ViewControlTemp, Off
SendInput, {Click, Up Middle}
SwitchIME(0x04090409) ; 切换至"中文(中国) 简体中文-美式键盘"
;Send, #{Space} ; [未启用命令行] 微软拼音用户可用该命令
If (A_IsSuspended)
    ToolTip, 暂停中, 0, 999 ; [可调校数值]
Else If (A_IsSuspended=0)
{
    If (M_Toggle)
        M_Toggle:=!M_Toggle
    ToolTip, 已启用, 0, 999 ; [可调校数值]
    Sleep 210 ; [可调校数值]
    ToolTip
}
Return

F3:: ; 重启程序以呼出操作说明界面
Suspend, Off
SetTimer, ViewControlTemp, Off
SendInput, {Click, Up Middle}
Reload 
Return

#Tab::
If (A_IsSuspended=0)
{
    Suspend, On
    WinSet, AlwaysOnTop, Off, A
    SetTimer, ViewControlTemp, Off
    Send, {Click, Up Middle}
    SwitchIME(0x04090409) ; 切换至"中文(中国) 简体中文-美式键盘"
    ;Send, #{Space} ; [未启用命令行] 微软拼音用户可用该命令
    If (A_IsSuspended)
        ToolTip, 暂停中, 0, 999 ; [可调校数值]
    Sleep 99 ; [可调校数值]
    Send, #{Tab}
    Return
}
Else
    Send, #{Tab}
Return

!Tab::
If (A_IsSuspended=0)
{
    Suspend, On
    WinSet, AlwaysOnTop, Off, A
    SetTimer, ViewControlTemp, Off
    SendInput, {Click, Up Middle}
    SwitchIME(0x04090409) ; 切换至"中文(中国) 简体中文-美式键盘"
    ;Send, #{Space} ; [未启用命令行] 微软拼音用户可用该命令
    If (A_IsSuspended)
        ToolTip, 暂停中, 0, 999 ; [可调校数值]
    Sleep 99 ; [可调校数值]
    Send, !{Tab}
    Return
}
Else
    Send, !{Tab}
Return

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

ViewControl:
If WinActive("ahk_exe BH3.exe")
{
    CoordMode, Window
    WinGetPos, X, Y, Width, Height, ahk_exe BH3.exe ; 获取崩坏3游戏窗口参数（同样适用于非全屏）
    MouseMove, Width/2, Height/2, 0 ; [建议保持数值] 使鼠标回正，居中于窗口
    SendInput, {Click, Down Middle}
}
Return

ViewControlTemp:
If WinActive("ahk_exe BH3.exe")
{
    MouseGetPos, x1, y1
    Sleep, 1
    MouseGetPos, x2, y2
    If (x1<x2)
    {
        SendInput, {e Down}
        Sleep, 1
        SendInput, {e Up}
        Return
    }
    If (x1>x2)
    {
        SendInput, {q Down}
        Sleep, 1
        SendInput, {q Up}
        Return
    }
    If (y1<y2)
    {
        SendInput, {m Down}
        Sleep, 1
        SendInput, {m Up}
        Return
    }
    If (y1>y2)
    {
        SendInput, {n Down}
        Sleep, 1
        SendInput, {n Up}
        Return
    }
}
Return

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

MButton:: ; 点击鼠标中键以激活视角跟随
M_Toggle:=!M_Toggle
If (M_Toggle)
{
    SetTimer, ViewControlTemp, Off
    SetTimer, ViewControl, -99 ; [[可调校数值]] 设定视角跟随命令的每执行间隔时间(ms) 
    ToolTip, 视角跟随已激活, 0, 999 ; [可调校数值]
    Sleep 999 ; [可调校数值]
    ToolTip
}
Else
{
    SetTimer, ViewControlTemp, Off
    SetTimer, ViewControl, Off
    SendInput, {Click, Up Middle}
    ToolTip, 视角跟随已关闭, 0, 999 ; [可调校数值]
    Sleep 999 ; [可调校数值]
    ToolTip
}
Return

LButton:: ; 点按鼠标左键以发动普攻
Send, {j Down}
If (M_Toggle)
{
    If GetKeyState("LButton", "P")
    {
        SetTimer, ViewControl, Off
        SetTimer, ViewControlTemp, 0 ; [[可调校数值]] 设定视角跟随命令的每执行间隔时间(ms)
    }
}
KeyWait, LButton
Send, {j Up}
Return

q:: ; 按下键盘Q键以发动必杀技
Send, {i Down}
If (M_Toggle)
{
    If GetKeyState("q", "P")
    {
        SetTimer, ViewControl, Off
        SetTimer, ViewControlTemp, 0 ; [[可调校数值]] 设定视角跟随命令的每执行间隔时间(ms)
    }
}
KeyWait, q
Send, {i Up}
Return


e:: ; 按下键盘E键以发动武器技/ 后崩坏书必杀技，长按E键进入瞄准模式时可通过键盘右侧方向键操控准心
GetKeyState, State, e, P
Send, {u Down}
If (State=1)
{
    up::w
    down::s
    left::a
    right::d
}
If (M_Toggle)
{
    If GetKeyState("e", "P")
    {
        SetTimer, ViewControl, Off
        SetTimer, ViewControlTemp, 0 ; [[可调校数值]] 设定视角跟随命令的每执行间隔时间(ms)
    }
}
KeyWait, e
Send, {u Up}
Return

z::l ; 按下键盘Z键以发动人偶技

LShIft::k ; 按下键盘左侧ShIft键以发动闪避/冲刺

RButton::k ; 点按鼠标右键以发动闪避/冲刺

*!LButton::LButton ; 按住ALT以正常使用鼠标左键

;---------------------------------------------------------------------------------------------------------------------------------------------------------------
;目前就这些，可根据需要自行修改
;---------------------------------------------------------------------------------------------------------------------------------------------------------------