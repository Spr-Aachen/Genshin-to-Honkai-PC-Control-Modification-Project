;---------------------------------------------------------------------------------------------------------------------------------------------------------------
;Version 0.2.9
;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【宏指令】修改AHK的默认掩饰键
#MenuMaskKey vkE8  ; vkE8尚未映射
#UseHook

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【函数】管理输入法
SwitchIME(dwLayout)
{
    HKL := DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
    ControlGetFocus, ctl, A
    SendMessage, 0x50, 0, HKL, %ctl%, A
}

;【函数】界面状态栏
Disable( )
{
    WinGet, id, ID, A
    menu := DLLCall( "user32\GetSystemMenu", "UInt", id, "UInt", 0)
    DLLCall( "user32\DeleteMenu", "UInt", menu, "UInt", 0xF060, "UInt", 0x0)
    WinGetPos ,x, y, w, h, ahk_id %id%
    WinMove, ahk_id %id%,, %x%, %y%, %w%, % h-1
    WinMove, ahk_id %id%,, %x%, %y%, %w%, % h+1
}

;【GUI】说明界面
Gui, Start: + Theme
Gui, Start: Font, s12, 新宋体
Gui, Start: Add, Tab3,, 键位一览|参数设置|更新链接

Gui, Start: Tab, 键位一览
Gui, Start: Add, Text, X+15, ; 集体缩进
Gui, Start: Add, Text,, 左键:                   普攻
Gui, Start: Add, Text,, 左Alt+左键:             正常左键
Gui, Start: Add, Text,, 中键:                   管理视角跟随
Gui, Start: Add, Text,, F1:                     暂停/启用
Gui, Start: Add, Text,, F3:                     查看说明
Gui, Start: Add, Text,, 
Gui, Start: Add, Text,, 其它键位请在游戏设置界面内自行更改
Gui, Start: Add, Text,, 

Gui, Start: Tab, 参数设置
Gui, Start: Add, Text, X+15, ; 集体缩进
Gui, Start: Add, CheckBox, Checked vRunAsAdmin, 启用管理员权限（推荐）
Gui, Start: Add, CheckBox, Checked vEnableScreenScale, 启用全自动识别（推荐）
Gui, Start: Add, Text,,

Gui, Start: Tab, 更新链接
Gui, Start: Add, Text, X+15, ; 集体缩进
Gui, Start: Add, Link,, 百度云:               <a href="https://pan.baidu.com/s/1KK1B-r-hx_s3yTRl_h_oOg">提取码：2022</a>
Gui, Start: Add, Link,, Github:               <a href="https://github.com/Spartan711/Genshin-to-Honkai-PC-Control-Project/blob/main/BH3_Hotkey.ahk">Latest Release</a>
Gui, Start: Add, Text,,

Gui, Start: Tab
Gui, Start: Add, Button, Default W345, 开启
Gui, Start: Add, Button, W345, 退出
Gui, Start: Show, xCenter yCenter, 设置说明
Disable( )
Return

;【标签】“开启”按钮的执行语句
StartButton开启:
Gui, Submit, NoHide
Gui, Start: Destroy
If (RunAsAdmin)
{
    full_command_line := DllCall("GetCommandLine", "str")
    If not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
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
}
If (EnableScreenScale)
{
    If (!Toggle_ScreenScale)
    {
        Toggle_ScreenScale := !Toggle_ScreenScale
        SetTimer, ScreenScale, 90 ; [可调校数值] 设定自动识别命令的每执行时间间隔(ms)，如果值过小可能不好使
    }
    Else
    {
        MsgBox, 0, 警告, 检测到异常参数，即将退出程序
        ExitApp
    }
}
SetTimer, AutoFadeMsgbox, -3000 ; [可调校数值] 使消息弹窗仅存在一段时间(ms)
MsgBox, 0, 提示, 程序进入运行状态,可在游戏内按F1键停用`n（PS：当前对话框将于3秒后自动消失）
SetTimer, AutoFadeMsgbox, Off
Return

;【标签】让对话框自动消失
AutoFadeMsgbox:
DLLCall("AnimateWindow", UInt, WinExist("提示 ahk_class #32770"), Int, 500, UInt, 0x90000)
Return

;【标签】“退出”按钮的执行语句
StartButton退出:
MsgBox, 4,, 是否确认退出当前程序？
IfMsgBox, Yes
    ExitApp
Return

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【宏条件】检测崩坏3游戏窗口，使程序仅在崩坏3游戏运行时生效
#IfWinActive ahk_exe BH3.exe

;【常量】对管理鼠标控制功能的全局常量进行赋值
Global Toggle_MouseFunction := 0

;【常量】对管理视角跟随功能的全局常量进行赋值
Global Status_MButton := 0

;【常量】对管理自动识别功能的全局常量进行赋值
Global Toggle_ScreenScale := 0

;【常量】对管理手动暂停功能的全局常量进行赋值
Global Toggle_ManualSuspend := 0

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【函数】重置光标
CoordReset()
{
    If WinActive("ahk_exe BH3.exe")
    {
        CoordMode, Window
        WinGetPos, X, Y, Width, Height, ahk_exe BH3.exe ; 获取崩坏3游戏窗口参数（同样适用于非全屏）
        MouseMove, Width/2, Height/2, 0 ; [建议保持数值] 使鼠标回正，居中于窗口
    }
}

;【函数】视角跟随
ViewControl()
{
    If WinActive("ahk_exe BH3.exe")
    {
        MouseGetPos, x1, y1
        Sleep, 10 ; [可调校数值] 设定采集当前光标坐标值的时间间隔(ms)
        MouseGetPos, x2, y2
        If (x1 != x2 or y1 != y2)
        {
            If (!Status_MButton)
            {
                Status_MButton := !Status_MButton
                SendInput, {Click, Down Middle}
            }
        }
        Else
        {
            If (Status_MButton)
            {
                SendInput, {Click, Up Middle}
                Status_MButton := !Status_MButton
            }
        }
    }
}

;【函数】临时视角跟随
ViewControlTemp()
{
    If WinActive("ahk_exe BH3.exe")
    {
        Threshold := 33 ; [可调校数值] 设定切换两种视角跟随模式的像素阈值
        MouseGetPos, x1, y1
        Sleep, 10 ; [可调校数值] 设定采集当前光标坐标值的时间间隔(ms)
        MouseGetPos, x2, y2
        If (abs(x1 - x2) > Threshold or abs(y1 - y2) > Threshold)
        {
            If (!Status_MButton)
            {
                Status_MButton := !Status_MButton
                SendInput, {Click, Down Middle}
            }
        }
        Else If (y1 > y2)
        {
            SendInput, {n Down}
            Sleep, 1
            SendInput, {n Up}
        }
        Else If (y1 < y2)
        {
            SendInput, {m Down}
            Sleep, 1
            SendInput, {m Up}
        }
        Else If (x1 > x2)
        {
            SendInput, {q Down}
            Sleep, 1
            SendInput, {q Up}
        }
        Else If (x1 < x2)
        {
            SendInput, {e Down}
            Sleep, 1
            SendInput, {e Up}
        }
        Else If (x1 > x2 and y1 > y2)
        {
            SendInput, {q Down}{n Down}
            Sleep, 1
            SendInput, {q Up}{n Up}
        }
        Else If (x1 < x2 and y1 > y2)
        {
            SendInput, {e Down}{n Down}
            Sleep, 1
            SendInput, {e Up}{n Up}
        }
        Else If (x1 > x2 and y1 < y2)
        {
            SendInput, {q Down}{m Down}
            Sleep, 1
            SendInput, {q Up}{m Up}
        }
        Else If (x1 < x2 and y1 < y2)
        {
            SendInput, {e Down}{m Down}
            Sleep, 1
            SendInput, {e Up}{m Up}
        }
        Else
        {
            If (Status_MButton)
            {
                SendInput, {Click, Up Middle}
                Status_MButton := !Status_MButton
            }
        }
    }
}

;【函数】输入重置
InputReset()
{
    If (Status_MButton)
    {
        SendInput, {Click, Up Middle}
        Status_MButton := !Status_MButton
    }
}

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【函数】不同分辨率下参数的初始化
ScreenScale()
{ ; 默认数值源于1920*1080分辨率下的测试结果
    WinGetPos, ClientCorner_X, ClientCorner_Y, Client_Width, Client_Height, ahk_exe BH3.exe
    Global Esc_X := ClientCorner_X
    Global Esc_Y := ClientCorner_Y
    Global Esc_X2 := Esc_X + 2 * Round(66 * Client_Width / 1920)
    Global Esc_Y2 := Esc_Y + 2 * Round(57 * Client_Height / 1080)
    Global EscIcon := "|<EscIcon>0xFFFFFF@1.00$133.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000k000000030000000000000Q00000001U000000000000C0000000300000000000001k0000003U0000000000000s0000001k0000000000000Q0000001k0000000000000D0000003s00000000000007U000001w00000000000003k000000s00000000000001s000000w00000000000000w000000S00000000000000S000000D00000000000000D0000007U00000000000007U000003U00000000000007k000003k00000000000007k000003s00000000000003s000001w00000000000001w000000y00000000000000y000000S00000000000000T000000C00000000000000DU00000D00000000000000D0000007U00000000000007U000003k00000000000003k000001s00000000000001s000000s00000000000001w000000w00000000000001y000000y00000000000000y000000T00000000000000T000000DU0000000000000DU000007000000000000007k000003U00000000000007s000003k00000000000003s000001s00000000000001s000000w00000000000000w000000S00000000000000S000000C00000000000000D000000D00000000000000TU00000DU0000000000000DU000007k00000000000007k000003k00000000000003s000001k00000000000001w000000s00000000000000y000000w00000000000000y000000S00000000000000S000000D00000000000000D0000007000000000000007U000003U00000000000003k000001k00000000000007s000003s00000000000003s000001w00000000000001w000000w00000000000000y000000Q00000000000000T000000C00000000000000DU00000700000000000000Dk000007U00000000000007U000003k00000000000003k000001s00000000000001s000000Q00000000000003s000000C00000000000001w000000700000000000000y0000003s0000000000000w0000000w0000000000000S0000000C0000000000000C000000030000000000000Q00000001U000000000000C00000000800000000000080000000010000000000000000000000000000000000E00000000000000Ts00000000000000000000C00000000000000000000070000000000000000000003U000000000000000000001k0T0y00000000000000000s0sVv00000000000000000TsM1k00000000000000000DwA0k00000000000000000707Us000000000000000003U0wQ000000000000000001k07C000000000000000000s01X000000000000000000Q00lk00000000000000000DyDkTk00000000000000007z3U3U000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000E"
    Switch A_ScreenHeight
    {
        case "1440":
            EscIcon :=
            Esc_X := Round(Esc_X * 4 / 3)
            Esc_Y := Round(Esc_Y * 4 / 3)
            Esc_X2 := Round(Esc_X2 * 4 / 3)
            Esc_Y2 := Round(Esc_Y2 * 4 / 3)
        case "2160":
            EscIcon := 
            Esc_X *= 2
            Esc_Y *= 2
            Esc_X2 *= 2
            Esc_Y2 *= 2
        defult:
            EscIcon :=
            Esc_X := ClientCorner_X
            Esc_Y := ClientCorner_Y
            Esc_X2 := Esc_X + Client_Width
            Esc_Y2 := Esc_Y + Client_Height
    }
    If (ok := FindText(X, Y, Esc_X, Esc_Y, Esc_X2, Esc_Y2, 0, 0, EscIcon))
    {
        If (A_IsSuspended and !Toggle_ManualSuspend)
        {
            Suspend, Off
            If (!Toggle_MouseFunction)
            {
                Toggle_MouseFunction := !Toggle_MouseFunction
                CoordReset()
                SetTimer, ViewControl, 0 ; [可调校数值] 设定视角跟随命令的每执行时间间隔(ms)
            }
        }
    }
    Else
    {
        If (!A_IsSuspended)
        {
            Suspend, On
            If (Toggle_MouseFunction)
            {
                SetTimer, ViewControl, Off
                InputReset()
                Toggle_MouseFunction := !Toggle_MouseFunction
            }
        }
    }
    Return
}

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【热键】点击鼠标中键以激活视角跟随
MButton::
If GetKeyState("MButton", "P") ; 通过行为检测防止中键被部分函数唤醒
{
    Toggle_MouseFunction := !Toggle_MouseFunction
    If (Toggle_MouseFunction)
    {
        CoordReset()
        SetTimer, ViewControl, 0 ; [可调校数值] 设定视角跟随命令的每执行时间间隔(ms)
        ToolTip, 视角跟随已激活, 0, 999 ; [可调校数值]
        Sleep 999 ; [可调校数值]
        ToolTip
    }
    Else
    {
        SetTimer, ViewControl, Off
        InputReset()
        ToolTip, 视角跟随已关闭, 0, 999 ; [可调校数值]
        Sleep 999 ; [可调校数值]
        ToolTip
    }
}
Return

;【热键】点按鼠标左键以发动普攻
LButton::
SendInput, {j Down}
If (Toggle_MouseFunction)
{
    If GetKeyState("LButton", "P")
    {
        SetTimer, ViewControl, Off
        InputReset()
        SetTimer, ViewControlTemp, 0
    }
}
KeyWait, LButton
SendInput, {j Up}
If (Toggle_MouseFunction)
{
    SetTimer, ViewControlTemp, Off
    SetTimer, ViewControl, On
}
Return

;【热键】按住键盘左侧ALT以正常使用鼠标左键
LAlt:: ; *!LButton::LButton
SetTimer, LAltTab, 0
Hotkey, LButton, Off
If (Toggle_MouseFunction)
{
    SetTimer, ViewControl, Off
    InputReset()
}
KeyWait, LAlt
SetTimer, LAltTab, Off
Hotkey, LButton, On
If (Toggle_MouseFunction)
    SetTimer, ViewControl, On
Return

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【热键】暂停/启用程序——若想正常使用鼠标请按该键或按住ALT键
F1::
Suspend, Toggle
Toggle_ManualSuspend := !Toggle_ManualSuspend
If (Toggle_ManualSuspend)
{
    If (Toggle_ScreenScale)
    {
        If (ok := FindText(X, Y, Esc_X, Esc_Y, Esc_X2, Esc_Y2, 0, 0, EscIcon))
            SendEvent, {Esc}
        SetTimer, ScreenScale, Off
        Toggle_ScreenScale := !Toggle_ScreenScale
    }
    If (Toggle_MouseFunction)
    {
        SetTimer, ViewControl, Off
        InputReset()
        Toggle_MouseFunction := !Toggle_MouseFunction
    }
    ToolTip, 暂停中, 0, 999 ; [可调校数值]
    SwitchIME(0x04090409) ; 切换至"中文(中国) 简体中文-美式键盘"
    ;SendInput, #{Space} ; [未启用命令行] 微软拼音用户可用该命令
}
Else
{
    If (!Toggle_ScreenScale)
    {
        Toggle_ScreenScale := !Toggle_ScreenScale
        SetTimer, ScreenScale, On
        If (ok := FindText(X, Y, Esc_X, Esc_Y, Esc_X2, Esc_Y2, 0, 0, EscIcon))
            If (!Toggle_MouseFunction)
            {
                Toggle_MouseFunction := !Toggle_MouseFunction
                SetTimer, ViewControl, 0 ; [可调校数值] 设定视角跟随命令的每执行时间间隔(ms)
            }
    }
    ToolTip, 已启用, 0, 999 ; [可调校数值]
    Sleep 210 ; [可调校数值]
    ToolTip
}
Return

;【热键】重启程序以呼出操作说明界面
F3::
If (!A_IsSuspended && !Toggle_ManualSuspend)
{
    Toggle_ManualSuspend := !Toggle_ManualSuspend
    Suspend, On
    If (Toggle_ScreenScale)
    {
        If (ok := FindText(X, Y, Esc_X, Esc_Y, Esc_X2, Esc_Y2, 0, 0, EscIcon))
            SendEvent, {Esc}
        SetTimer, ScreenScale, Off
        Toggle_ScreenScale := !Toggle_ScreenScale
    }
    If (Toggle_MouseFunction)
    {
        SetTimer, ViewControl, Off
        InputReset()
        Toggle_MouseFunction := !Toggle_MouseFunction
    }
}
Reload
Return

;【热键】对Win+Tab快捷键的支持命令
#Tab::
If (!A_IsSuspended && !Toggle_ManualSuspend)
{
    Toggle_ManualSuspend := !Toggle_ManualSuspend
    Suspend, On
    If (Toggle_ScreenScale)
    {
        If (ok := FindText(X, Y, Esc_X, Esc_Y, Esc_X2, Esc_Y2, 0, 0, EscIcon))
            SendEvent, {Esc}
        SetTimer, ScreenScale, Off
        Toggle_ScreenScale := !Toggle_ScreenScale
    }
    If (Toggle_MouseFunction)
    {
        SetTimer, ViewControl, Off
        InputReset()
        Toggle_MouseFunction := !Toggle_MouseFunction
    }
    ToolTip, 暂停中, 0, 999 ; [可调校数值]
    Sleep 99 ; [可调校数值]
}
WinSet, AlwaysOnTop, Off, A
SendInput, #{Tab}
Return

;【热键】对Alt+Tab快捷键的支持命令
LAltTab()
{
    If GetKeyState("Tab", "P")
    {
        If (!A_IsSuspended && !Toggle_ManualSuspend)
        {
            Toggle_ManualSuspend := !Toggle_ManualSuspend
            Suspend, On
            If (Toggle_ScreenScale)
            {
                If (ok := FindText(X, Y, Esc_X, Esc_Y, Esc_X2, Esc_Y2, 0, 0, EscIcon))
                    SendEvent, {Esc}
                SetTimer, ScreenScale, Off
                Toggle_ScreenScale := !Toggle_ScreenScale
            }
            If (Toggle_MouseFunction)
            {
                SetTimer, ViewControl, Off
                InputReset()
                Toggle_MouseFunction := !Toggle_MouseFunction
            }
            ToolTip, 暂停中, 0, 999 ; [可调校数值]
            Sleep 99 ; [可调校数值]
        }
        WinSet, AlwaysOnTop, Off, A
        SendInput, !{Tab}
    }
    Return
}

;---------------------------------------------------------------------------------------------------------------------------------------------------------------
;目前就这些，可根据需要自行修改
;---------------------------------------------------------------------------------------------------------------------------------------------------------------