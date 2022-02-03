#IfWinActive ahk_class UnityWndClass ; 【宏条件】用于检测3D游戏窗口的指令，使程序仅在游戏运行时生效

;-------------------------------------------------------------------------------------------------------------

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

;-------------------------------------------------------------------------------------------------------------

*!LButton::LButton ; 按住ALT以正常使用鼠标左键

RButton:: ; 点按鼠标右键以发动闪避/冲刺
Send, {k Down}
KeyWait, RButton
Send, {k Up}
return

LShift:: ; 按下键盘左侧Shift键以发动闪避/冲刺
SendEvent, {k Down}
KeyWait, LShift
SendEvent, {k Up}
return

e:: ; 按下键盘E键以发动武器技/ 后崩坏书必杀技
Send, u
SendEvent, MButton
return

q::i ; 按下键盘Q键以发动必杀技（若设置视角跟随会唤醒U键或L键）

LCtrl:: L ; 按下键盘左侧Ctrl键以发动人偶技（若设置视角跟随会唤醒U键）

;-------------------------------------------------------------------------------------------------------------

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

;-------------------------------------------------------------------------------------------------------------

; 目前就这些，可根据需要自行修改
