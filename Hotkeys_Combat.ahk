;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【热键 Hotkey】点击自定义键以激活视角跟随
Key_ViewControl:
If GetKeyState(Key_ViewControl, "P") ; 通过行为检测防止被部分函数 Function唤醒
{
    Toggle_MouseFunction := !Toggle_MouseFunction
    If (Toggle_MouseFunction)
    {
        CoordReset()
        SetTimer, ViewControl, %Timer_ViewControl%
        ToolTip, 视角跟随已手动激活, 0, 999 ; [可调校数值 adjustable parameters]
        Sleep 999 ; [可调校数值 adjustable parameters]
        ToolTip
    }
    Else
    {
        SetTimer, ViewControl, Delete
        InputReset()
        ToolTip, 视角跟随已手动关闭, 0, 999 ; [可调校数值 adjustable parameters]
        Sleep 999 ; [可调校数值 adjustable parameters]
        ToolTip
    }
}
Return


;【热键 Hotkey】点按自定义键以发动普攻
Key_NormalAttack:
If GetKeyState(Key_NormalAttack, "P") ; 通过行为检测防止被ViewControlTemp函数唤醒
{
    SendInput, {j Down}
    If (Toggle_MouseFunction)
    {
        SetTimer, ViewControl, Off
        Loop
        {
            ViewControlTemp()
        }Until Not GetKeyState(A_ThisHotkey, "P")
        SetTimer, ViewControl, On
    }
    Else
        KeyWait, %Key_NormalAttack%
    SendInput, {j Up}
}
Return


;【热键 Hotkey】按下自定义键以发动必杀技
Key_MainSkill:
If GetKeyState(Key_MainSkill, "P") ; 通过行为检测防止被ViewControlTemp函数唤醒
{
    SendInput, {i Down}
    If (Toggle_MouseFunction)
    {
        SetTimer, ViewControl, Off
        Loop
        {
            ViewControlTemp()
        }Until Not GetKeyState(A_ThisHotkey, "P")
        SetTimer, ViewControl, On
    }
    Else
        KeyWait, %Key_MainSkill%
    SendInput, {i Up}
}
Return


;【热键 Hotkey】按下自定义键以发动武器技/后崩坏书必杀技，长按自定义键进入瞄准模式时可用鼠标键操控准心
Key_SecondSkill:
If GetKeyState(Key_SecondSkill, "P") ; 通过行为检测防止被ViewControlTemp函数唤醒
{
    SendInput, {u Down}
    If (Toggle_MouseFunction)
        AimControl()
    Else
        KeyWait, %Key_SecondSkill%
    SendInput, {u Up}
}
Return


;【热键 Hotkey】按下自定义键以发动人偶技
Key_DollSkill:
SendInput, {l Down}
KeyWait, %Key_DollSkill%
SendInput, {l Up}
Return


;【热键 Hotkey】按下自定义键以发动闪避/冲刺
Key_Dodging:
SendInput, {k Down}
KeyWait, %Key_Dodging1%
SendInput, {k Up}
Return


;【热键 Hotkey】按住键盘左侧ALT以正常使用鼠标左键
 ; ~*!LButton::LButton
~LAlt::
Hotkey, LButton, Off
If (Toggle_AutoScale)
{
    If (Toggle_MouseFunction)
    {
        SetTimer, ViewControl, Delete
        If GetKeyState(Key_SecondSkill, "P")
            BreakFlag_Aim := !BreakFlag_Aim
        InputReset()
        Toggle_MouseFunction := !Toggle_MouseFunction
    }
    If (Status_Occlusion)
        Occlusion(Status_Occlusion := !Status_Occlusion)
    KeyWait, LAlt
    If (Status_CombatIcon)
    {
        If (!Status_Occlusion)
            Occlusion(Status_Occlusion := !Status_Occlusion)
        If (!Toggle_MouseFunction)
        {
            Toggle_MouseFunction := !Toggle_MouseFunction
            CoordReset()
            SetTimer, ViewControl, %Timer_ViewControl%
        }
    }
}
Else If (Toggle_MouseFunction)
{
    SetTimer, ViewControl, Delete
    If GetKeyState(Key_SecondSkill, "P")
        BreakFlag_Aim := !BreakFlag_Aim
    InputReset()
    KeyWait, LAlt
    SetTimer, ViewControl, %Timer_ViewControl%
}
Else
    KeyWait, LAlt
Hotkey, LButton, On
Return


;---------------------------------------------------------------------------------------------------------------------------------------------------------------