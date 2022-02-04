;-------------------------------------------------------------------------------------------------------------------------------------------------------------
;Version 0.1.0
;-------------------------------------------------------------------------------------------------------------------------------------------------------------

hidden :=! hidden
Gui, Start:Font, s12, 新宋体
Gui, Start:Margin , X, Y
Gui, Start:+Theme
Gui, Start:Add, Text, x+3, ; 集体缩进
Gui, Start:Add, Text,, F1:                     停用/启用
Gui, Start:Add, Text,, F2:                     重启
Gui, Start:Add, Text,, F3:                     退出
Gui, Start:Add, Text,, 左Alt+左键:             正常左键
Gui, Start:Add, Text,, 左Shift/右键:           闪避/冲刺
Gui, Start:Add, Text,, 左Ctrl:                 人偶技
Gui, Start:Add, Text,, Q:                      必杀技
Gui, Start:Add, Text,, E:                      武器技/后崩必杀技
Gui, Start:Add, Text,, 方向键:                 准心控制
Gui, Start:Add, Text,, 中键:                   视角跟随
Gui, Start:Add, Text,, 左键:                   普攻/吼姆跳
Gui, Start:Add, Link,, 源码查看:               <a href="https://github.com/Spartan711/Genshin-to-Honkai-PC-Control-Project/blob/main/BH3_Hotkey.ahk">传送门</a>
Gui, Start:Add, Text,,
Gui, Start:Add, Button, xn w333, 关闭
Gui, Start:Show, xCenter yCenter, 设置说明
WinSet, Transparent, 250, A
Return

StartButton关闭:
Gui, Start:Destroy
Return

;-------------------------------------------------------------------------------------------------------------------------------------------------------------

#IfWinActive ahk_class UnityWndClass ; 【宏条件】用于检测3D游戏窗口的指令，使程序仅在游戏运行时生效

;-------------------------------------------------------------------------------------------------------------------------------------------------------------

F1:: ; 停用/ 启用所有热键——若想正常使用鼠标请按该键或按住ALT键
Suspend    
WinSet AlwaysOnTop, Off, A
Send, {Click, Up}{Click, Up Middle}
SwitchIME(0x04090409) ; 切换至"中文(中国) 简体中文-美式键盘"
;Send, #{space} ; [未启用命令行] 微软拼音用户可用该命令
if (A_IsSuspended=1)
    ToolTip, 停用中, 0, 999 ; 可调校数值
else if (A_IsSuspended=0)
    ToolTip
return

SwitchIME(dwLayout) ; 该段用于管理输入法，请勿删改
{
    HKL:=DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
    ControlGetFocus,ctl,A
    SendMessage,0x50,0,HKL,%ctl%,A
}

F2:: ; 重启所有热键
Suspend Off
Reload 
return

F3::ExitApp ; 退出程序

;-------------------------------------------------------------------------------------------------------------------------------------------------------------

*!LButton::LButton ; 按住ALT以正常使用鼠标左键

RButton:: ; 点按鼠标右键以发动闪避/冲刺
SendEvent, {k Down}
KeyWait, RButton
SendEvent, {k Up}
return

LShift:: ; 按下键盘左侧Shift键以发动闪避/冲刺
SendEvent, {k Down}
KeyWait, LShift
SendEvent, {k Up}
return

e:: ; 按下键盘E键以发动武器技/ 后崩坏书必杀技，长按E键进入瞄准模式时可通过键盘右侧方向键操控准心
GetKeyState, State, e, T
Send, {u Down}
KeyWait, e
if (State="D")
{
    up::w
    return
}
if (State="D")
{
    down::s
    return
}
if (State="D")
{
    left::a
    return
}
if (State="D")
{
    right::d
    return
}
Send, {u Up}
SendEvent, MButton
return

q:: ; 按下键盘Q键以发动必杀技（若设置视角跟随会唤醒U键，目前尝试各种block禁用指令无果）
GetKeyState, State, q, T
Send, {i Down}
KeyWait, q
Send, {i Up}
if (State="U")
{
    GetKeyState, State, e, P
    if (State="U")
    {
        *u::return
    }
    else
        SendEvent, MButton
}
return

LCtrl::l ; 按下键盘左侧Ctrl键以发动人偶技（若设置视角跟随会唤醒U键，同上）

;-------------------------------------------------------------------------------------------------------------------------------------------------------------

MButton:: ; 点击鼠标中键以激活视角跟随
SendInput, {Click, Up Middle}
return

MButton Up:: 
SendInput, {Click, Down}
return

LButton:: ; 点按鼠标左键以发动普攻
Send, {j Down}
KeyWait, LButton
Send, {j Up}
SendInput, {Click, Up Middle}
Loop := True
SetTimer, ViewControl, -99 ; [可调校数值] 设定视角跟随命令的每执行间隔时间(ms)
return

ViewControl:
if WinActive("ahk_class UnityWndClass")
{
    SendInput, {Click, Down Middle}
    WinGetPos, X, Y, Width, Height, ahk_class UnityWndClass
    MouseMove, Width/2, Height/2, 0 ; [建议保持数值]
}
return

;-------------------------------------------------------------------------------------------------------------------------------------------------------------
;目前就这些，可根据需要自行修改
;-------------------------------------------------------------------------------------------------------------------------------------------------------------
