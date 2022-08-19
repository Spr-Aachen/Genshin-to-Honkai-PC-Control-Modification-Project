;---------------------------------------------------------------------------------------------------------------------------------------------------------------
;Version 0.3.0 beta
;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【命令 Directive】引用库文件FindText.ahk
#include <FindText>

;【命令 Directive】修改AHK的默认掩饰键
#MenuMaskKey vkE8  ; vkE8尚未映射
#UseHook

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【函数 Function】管理输入法
SwitchIME(dwLayout)
{
    HKL := DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
    ControlGetFocus, ctl, A
    SendMessage, 0x50, 0, HKL, %ctl%, A
}

;【函数 Function】界面状态栏
Disable( )
{
    WinGet, id, ID, A
    menu := DLLCall( "user32\GetSystemMenu", "UInt", id, "UInt", 0)
    DLLCall( "user32\DeleteMenu", "UInt", menu, "UInt", 0xF060, "UInt", 0x0)
    WinGetPos ,x, y, w, h, ahk_id %id%
    WinMove, ahk_id %id%,, %x%, %y%, %w%, % h-1
    WinMove, ahk_id %id%,, %x%, %y%, %w%, % h+1
}

;【界面 GUI】说明界面
Gui, Start: + Theme
Gui, Start: Font, s12, 新宋体
Gui, Start: Add, Tab3,, 说明|设置|更新

Gui, Start: Tab, 说明
Gui, Start: Add, Text, Xm+18 Ym+18 ; 控距
Gui, Start: Add, GroupBox, W333 H201, 战斗 Combat
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Text, Xp Yp+15, Q:                      必杀技
Gui, Start: Add, Text, Xp Yp+33, E:                      武器技/后崩技
Gui, Start: Add, Text, Xp Yp+33, Z:                      人偶技
Gui, Start: Add, Text, Xp Yp+33, 左ShIft/右键:           闪避
Gui, Start: Add, Text, Xp Yp+33, 左键:                   普攻
Gui, Start: Add, Text, Xm+18 Yp+36 ; 控距
Gui, Start: Add, GroupBox, W333 H168, 其它 Others
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Text, Xp Yp+15, 左Alt+左键:             正常点击
Gui, Start: Add, Text, Xp Yp+33, 中键:                   管理视角跟随
Gui, Start: Add, Text, Xp Yp+33, F1:                     暂停/启用
Gui, Start: Add, Text, Xp Yp+33, F3:                     调出界面
Gui, Start: Add, Text, Xm+18 Yp+36 ; 控距

Gui, Start: Tab, 设置
Gui, Start: Add, Text, Xm+18 Ym+18 ; 控距
Gui, Start: Add, GroupBox, W333 H105, 选项 Options
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, CheckBox, Xp Yp+15 Checked vRunAsAdmin, 启用管理员权限（推荐）
Gui, Start: Add, CheckBox, Xp Yp+33 Checked vEnableAutoScale, 启用全自动识别（推荐）

Gui, Start: Tab, 更新
Gui, Start: Add, Text, Xm+18 Ym+18 ; 控距
Gui, Start: Add, GroupBox, W333 H105, 链接 Links
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Link, Xp Yp+15, 百度云:                 <a href="https://pan.baidu.com/s/1KK1B-r-hx_s3yTRl_h_oOg">提取码:2022</a>
Gui, Start: Add, Link, Xp Yp+33, Github:                 <a href="https://github.com/Spartan711/Genshin-to-Honkai-PC-Control-Project/releases">New Release</a>
Gui, Start: Add, Text, Xm+18 Yp+39 ; 控距
Gui, Start: Add, GroupBox, W333 H78, 日志 Logs
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Text, Xp Yp+15, 版本:
Gui, Start: Add, DDL, Xp+192 Yp W87 gSelectVersion vVersion, v0.3.0|v0.2.+|v0.1.+

Gui, Start: Tab
Gui, Start: Add, Button, Default W366, 开启
Gui, Start: Add, Button, W366, 退出
Gui, Start: Show, xCenter yCenter, 启动界面
Disable( )
Return

;【例程 Gosub】“版本”选项的执行语句
SelectVersion:
GuiControlGet, Version
Switch Version
{
    Case "v0.3.0":

    Case "v0.2.+":

    Case "v0.1.+":

}
Return

;【标签 Label】“开启”按钮的执行语句
StartButton开启:
Gui, Submit
Gui, Start: Destroy
If (RunAsAdmin)
{
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
}
If (EnableAutoScale)
{
    If (!Toggle_AutoScale)
    {
        Toggle_AutoScale := !Toggle_AutoScale
        SetTimer, AutoScale, 90 ; [可调校数值 adjustable parameters] 设定自动识别命令的每执行时间间隔(ms)，如果值过小可能不好使
    }
    Else
    {
        MsgBox, 0, 警告, 检测到异常参数，即将退出程序
        ExitApp
    }
}
SetTimer, AutoFadeMsgbox, -3000 ; [可调校数值 adjustable parameters] 使消息弹窗仅存在一段时间(ms)
MsgBox, 0, 提示, 程序启动成功(/≧▽≦)/，祝游戏愉快！`n（当前对话框将于3秒后自动消失）
SetTimer, AutoFadeMsgbox, Off
Return

;【标签 Label】让对话框自动消失
AutoFadeMsgbox:
DLLCall("AnimateWindow", UInt, WinExist("提示 ahk_class #32770"), Int, 500, UInt, 0x90000)
Return

;【标签 Label】“退出”按钮的执行语句
StartButton退出:
If WinExist("ahk_exe BH3.exe")
{
    MsgBox, 4,, 检测到崩坏3正在运行\(≧□≦)/，真的要退出吗？
    IfMsgBox, Yes
        ExitApp
}
Else
{
    MsgBox, 4,, 是否确认退出当前程序(・-・*)？
    IfMsgBox, Yes
        ExitApp
}
Return
;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【命令 Directive】检测崩坏3游戏窗口，使程序仅在崩坏3游戏运行时生效
#IfWinActive ahk_exe BH3.exe

;【常量 Const】对管理自动控制功能的全局常量 Const进行赋值
Global Toggle_AutoScale := 0

;【常量 Const】对管理鼠标控制功能的全局常量 Const进行赋值
Global Toggle_MouseFunction := 0

;【常量 Const】对管理视角跟随功能的全局常量 Const进行赋值
Global Status_MButton := 0

;【常量 Const】对管理准星跟随功能的全局常量 Const进行赋值
Global BreakFlag_Aim := 0
Global Status_w := 0
Global Status_a := 0
Global Status_s := 0
Global Status_d := 0

;【常量 Const】对管理图像识别功能的全局常量 Const进行赋值
Global Status_CombatEscIcon := 0
Global Status_ElysianRealmIcon := 0

;【常量 Const】对管理手动暂停功能的全局常量 Const进行赋值
Global Toggle_ManualSuspend := 0

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【函数 Function】重置光标
CoordReset()
{
    If WinActive("ahk_exe BH3.exe")
    {
        CoordMode, Window
        WinGetPos, X, Y, Width, Height, ahk_exe BH3.exe ; 获取崩坏3游戏窗口参数（同样适用于非全屏）
        MouseMove, Width/2, Height/2, 0 ; [建议保持数值] 使鼠标回正，居中于窗口
    }
}

;【函数 Function】视角跟随
ViewControl()
{
    If WinActive("ahk_exe BH3.exe")
    {
        MouseGetPos, x1, y1
        Sleep, 1 ; [可调校数值 adjustable parameters] 设定采集当前光标坐标值的时间间隔(ms)
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

;【函数 Function】临时视角跟随
ViewControlTemp()
{
    If WinActive("ahk_exe BH3.exe")
    {
        Threshold := 33 ; [可调校数值 adjustable parameters] 设定切换两种视角跟随模式的像素阈值
        MouseGetPos, x1, y1
        Sleep, 1 ; [可调校数值 adjustable parameters] 设定采集当前光标坐标值的时间间隔(ms)
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

;【函数 Function】准星控制
AimControl()
{
    If WinActive("ahk_exe BH3.exe")
    {
        Loop
        {
            MouseGetPos, x1, y1
            Sleep, 1 ; [可调校数值 adjustable parameters] 设定采集当前光标坐标值的时间间隔(ms)
            MouseGetPos, x2, y2
            If (x1 != x2 or y1 != y2) ; 采用层级指令覆盖结构
            {
                If (y1 > y2)
                {
                    If (!Status_w)
                    {
                        Status_w := !Status_w
                        SendInput, {w Down}
                    }
                    Else
                    {
                        If (Status_s)
                        {
                            SendInput, {s Up}
                            Status_s := !Status_s
                        }
                        If (Status_a)
                        {
                            SendInput, {a Up}
                            Status_a := !Status_a
                        }
                        If (Status_d)
                        {
                            SendInput, {d Up}
                            Status_d := !Status_d
                        }
                    }
                }
                If (y1 < y2)
                {
                    If (!Status_s)
                    {
                        Status_s := !Status_s
                        SendInput, {s Down}
                    }
                    Else
                    {
                        If (Status_w)
                        {
                            SendInput, {w Up}
                            Status_w := !Status_w
                        }
                        If (Status_a)
                        {
                            SendInput, {a Up}
                            Status_a := !Status_a
                        }
                        If (Status_d)
                        {
                            SendInput, {d Up}
                            Status_d := !Status_d
                        }
                    }
                }
                If (x1 > x2)
                {
                    If (!Status_a)
                    {
                        Status_a := !Status_a
                        SendInput, {a Down}
                    }
                    Else
                    {
                        If (Status_w)
                        {
                            SendInput, {w Up}
                            Status_w := !Status_w
                        }
                        If (Status_s)
                        {
                            SendInput, {s Up}
                            Status_s := !Status_s
                        }
                        If (Status_d)
                        {
                            SendInput, {d Up}
                            Status_d := !Status_d
                        }
                    }
                }
                If (x1 < x2)
                {
                    If (!Status_d)
                    {
                        Status_d := !Status_d
                        SendInput, {d Down}
                    }
                    Else
                    {
                        If (Status_w)
                        {
                            SendInput, {w Up}
                            Status_w := !Status_w
                        }
                        If (Status_s)
                        {
                            SendInput, {s Up}
                            Status_s := !Status_s
                        }
                        If (Status_a)
                        {
                            SendInput, {a Up}
                            Status_a := !Status_a
                        }
                    }
                }
            }
            Else
            {
                If (Status_w)
                {
                    SendInput, {w Up}
                    Status_w := !Status_w
                }
                If (Status_s)
                {
                    SendInput, {s Up}
                    Status_s := !Status_s
                }
                If (Status_a)
                {
                    SendInput, {a Up}
                    Status_a := !Status_a
                }
                If (Status_d)
                {
                    SendInput, {d Up}
                    Status_d := !Status_d
                }
            }
            Sleep, 20 ; [可调校数值 adjustable parameters] 设定准星跟随命令的每执行间隔时间(ms)
            If (BreakFlag_Aim) ; (Abort the function when BreakFlag_Aim == 1)
            {
                BreakFlag_Aim := !BreakFlag_Aim
                break
            }
        }Until Not GetKeyState("e", "P")
        If (Status_w)
        {
            SendInput, {w Up}
            Status_w := !Status_w
        }
        If (Status_s)
        {
            SendInput, {s Up}
            Status_s := !Status_s
        }
        If (Status_a)
        {
            SendInput, {a Up}
            Status_a := !Status_a
        }
        If (Status_d)
        {
            SendInput, {d Up}
            Status_d := !Status_d
        }
    }
}

;【函数 Function】输入重置
InputReset()
{
    If (Status_MButton)
    {
        SendInput, {Click, Up Middle}
        Status_MButton := !Status_MButton
    }
}

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【函数 Function】不同分辨率下参数的初始化
AutoScale()
{
    If WinActive("ahk_exe BH3.exe")
    { ; 默认数值源于1920*1080分辨率下的测试结果
        WinGetPos, ClientUpperLeftCorner_X, ClientUpperLeftCorner_Y, Client_Width, Client_Height, ahk_exe BH3.exe
        Global UpperLeftCorner_X := ClientUpperLeftCorner_X
        Global UpperLeftCorner_Y := ClientUpperLeftCorner_Y
        Global LowerRightCorner_X := UpperLeftCorner_X + Round(69 * 2 * Client_Width / 1920)
        Global LowerRightCorner_Y := UpperLeftCorner_Y + Round(51 * 2 * Client_Height / 1080)
        Global Icon := "|<CombatEscIcon>0xFFFFFF@1.00$106.000400000000000030001U000000000000C00060000000000000s001U0000000000000s00C00000000000003U00s0000000000000C00700000000000000w01w00000000000003k07k0000000000000D00Q00000000000000w03k00000000000003k0D00000000000000D00w00000000000000w03k00000000000003k0C00000000000000T01s00000000000003s0DU0000000000000DU0y00000000000000y03s00000000000003s0D00000000000000DU0s00000000000000y07U00000000000007U0S00000000000000S01s00000000000001s07U00000000000007U0Q00000000000000y03k00000000000007s0T00000000000000T01w00000000000001w07k00000000000007k0Q00000000000000T01k00000000000003w0D00000000000000DU0w00000000000000w03k00000000000003k0D00000000000000D00s00000000000000w07U0000000000000Dk0y00000000000000y03s00000000000003s0D00000000000000DU0s00000000000000y03U00000000000003s0S00000000000000T01s00000000000001s07U00000000000007U0Q00000000000000S01k00000000000001s0700000000000000TU1w00000000000001w07k00000000000007k0S00000000000000T01k00000000000001w07000000000000007k0Q00000000000000z03k00000000000003k0D00000000000000D00w00000000000000w01k0000000000000DU0700000000000000y00Q00000000000003s01w0000000000000S003k0000000000001s00700000000000007000A0000000000001k000k00000000000070000U000000000000U0000U000000000000000000000000000010000000000Dw0000000000000000s00000000000000003U0000000000000000C00000000000000000s0DUT0000000000003U3W7g000000000000DwA0s0000000000000zkk300000000000003U3kQ0000000000000C03lk0000000000000s03b00000000000003U06A0000000000000C00Ms0000000000000zsz1z0000000000003zVk1k000000U"
        Global Icon .= "|<ElysianRealmIcon>0xFFFFFF@1.00$89.000400000000000000M00000000000000k00000000000007U0000000000000T00000000000000y00000000000007w0000000000000Ts0000000000000zk0000000000007lU000000000000S10000000000000w20000000000007k0000000000000S00000000000000w00000000000007k0000000000000S00000000000000w00000000000007k0000000000000S00000000000000w00000000000007s00000000000003k00000000000007U00000000000007k00000000000003k00000000000007U00000000000007k00000000000003k00000000000007U00000000000007k00000000000003k80000000000007UE0000000000007kU0000000000003z00000000000007y00000000000007w00000000000003s00000000000007k00000000000007U0000000000000300000000000000600000000000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000E000000000000010M"
        Switch A_ScreenHeight
        {
            Case "1080":
                ;测试所得默认参数
            Case "720":
                Icon :=
                UpperLeftCorner_X := Round(UpperLeftCorner_X * 2 / 3)
                UpperLeftCorner_Y := Round(UpperLeftCorner_Y * 2 / 3)
                LowerRightCorner_X := Round(LowerRightCorner_X * 2 / 3)
                LowerRightCorner_Y := Round(LowerRightCorner_Y * 2 / 3)
            Case "1440":
                Icon :=
                UpperLeftCorner_X := Round(UpperLeftCorner_X * 4 / 3)
                UpperLeftCorner_Y := Round(UpperLeftCorner_Y * 4 / 3)
                LowerRightCorner_X := Round(LowerRightCorner_X * 4 / 3)
                LowerRightCorner_Y := Round(LowerRightCorner_Y * 4 / 3)
            Case "2160":
                Icon := 
                UpperLeftCorner_X *= 2
                UpperLeftCorner_Y *= 2
                LowerRightCorner_X *= 2
                LowerRightCorner_Y *= 2
            Default:
                Icon :=
                UpperLeftCorner_X := ClientUpperLeftCorner_X
                UpperLeftCorner_Y := ClientUpperLeftCorner_Y
                LowerRightCorner_X := UpperLeftCorner_X + Client_Width
                LowerRightCorner_Y := UpperLeftCorner_Y + Client_Height
        }
        If (FindText(X, Y, UpperLeftCorner_X, UpperLeftCorner_Y, LowerRightCorner_X, LowerRightCorner_Y, 0.001, 0.001, Icon)[1].id == "CombatEscIcon")
        {
            If (!Toggle_ManualSuspend)
            {
                If(A_IsSuspended)
                {
                    Suspend, Off
                    If (!Toggle_MouseFunction)
                    {
                        Toggle_MouseFunction := !Toggle_MouseFunction
                        CoordReset()
                        SetTimer, ViewControl, 10 ; [可调校数值 adjustable parameters] 设定视角跟随命令的每执行时间间隔(ms)
                    }
                }
            }
            If (!Status_CombatEscIcon)
                Status_CombatEscIcon := !Status_CombatEscIcon
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
            Else If (!Toggle_ManualSuspend)
            {
                If (FindText(X, Y, UpperLeftCorner_X, UpperLeftCorner_Y, LowerRightCorner_X, LowerRightCorner_Y, 0.001, 0.001, Icon)[1].id == "ElysianRealmIcon")
                {
                    If (!Toggle_MouseFunction)
                    {
                        Toggle_MouseFunction := !Toggle_MouseFunction
                        CoordReset()
                        SetTimer, ViewControl, 10 ; [可调校数值 adjustable parameters] 设定视角跟随命令的每执行时间间隔(ms)
                    }
                }
                Else
                {
                    If (Toggle_MouseFunction)
                    {
                        SetTimer, ViewControl, Off
                        InputReset()
                        Toggle_MouseFunction := !Toggle_MouseFunction
                    }
                }
            }
            If (Status_CombatEscIcon)
                Status_CombatEscIcon := !Status_CombatEscIcon
        }
    }
    Else
    {
        InputReset()
    }
    Return
}

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【热键 Hotkey】点击鼠标中键以激活视角跟随
MButton::
If GetKeyState("MButton", "P") ; 通过行为检测防止中键被部分函数 Function唤醒
{
    Toggle_MouseFunction := !Toggle_MouseFunction
    If (Toggle_MouseFunction)
    {
        CoordReset()
        SetTimer, ViewControl, 10 ; [可调校数值 adjustable parameters] 设定视角跟随命令的每执行时间间隔(ms)
        ToolTip, 视角跟随已手动激活, 0, 999 ; [可调校数值 adjustable parameters]
        Sleep 999 ; [可调校数值 adjustable parameters]
        ToolTip
    }
    Else
    {
        SetTimer, ViewControl, Off
        InputReset()
        ToolTip, 视角跟随已手动关闭, 0, 999 ; [可调校数值 adjustable parameters]
        Sleep 999 ; [可调校数值 adjustable parameters]
        ToolTip
    }
}
Return

;【热键 Hotkey】点按鼠标左键以发动普攻
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

;【热键 Hotkey】按下键盘Q键以发动必杀技
q::
If GetKeyState("q", "P") ; 通过行为检测防止Q键被ViewControlTemp函数 Function唤醒
{
    SendInput, {i Down}
    If (Toggle_MouseFunction)
    {
        SetTimer, ViewControl, Off
        InputReset()
        Loop
        {
            ViewControlTemp()
        }Until Not GetKeyState("q", "P")
        SetTimer, ViewControl, On
    }
    Else
        KeyWait, q
    SendInput, {i Up}
}
Return

;【热键 Hotkey】按下键盘E键以发动武器技/后崩坏书必杀技，长按E键进入瞄准模式时可用鼠标键操控准心
e::
If GetKeyState("e", "P") ; 通过行为检测防止E键被ViewControlTemp函数 Function唤醒
{
    SendInput, {u Down}
    If (Toggle_MouseFunction)
        AimControl()
    Else
        KeyWait, e
    SendInput, {u Up}
}
Return

;【热键 Hotkey】按下键盘Z键以发动人偶技
z::l

;【热键 Hotkey】按下键盘左侧ShIft键以发动闪避/冲刺
LShIft::
SendInput, {k Down}
KeyWait, LShIft
SendInput, {k Up}
Return

;【热键 Hotkey】点按鼠标右键以发动闪避/冲刺
RButton::
SendInput, {k Down}
KeyWait, RButton
SendInput, {k Up}
Return

;【热键 Hotkey】按住键盘左侧ALT以正常使用鼠标左键
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

;【热键 Hotkey】暂停/启用程序
F1::
Suspend, Toggle
Toggle_ManualSuspend := !Toggle_ManualSuspend
If (Toggle_ManualSuspend)
{
    If (Toggle_AutoScale)
    {
        If (Status_CombatEscIcon)
            SendEvent, {Esc}
        SetTimer, AutoScale, Off
        Toggle_AutoScale := !Toggle_AutoScale
    }
    If (Toggle_MouseFunction)
    {
        SetTimer, ViewControl, Off
        If GetKeyState("e", "P")
            BreakFlag_Aim := !BreakFlag_Aim
        InputReset()
        Toggle_MouseFunction := !Toggle_MouseFunction
    }
    ToolTip, 暂停中, 0, 999 ; [可调校数值 adjustable parameters]
}
Else
{
    If (!Toggle_AutoScale)
    {
        Toggle_AutoScale := !Toggle_AutoScale
        SetTimer, AutoScale, On
        If (Status_CombatEscIcon)
        {
            If (!Toggle_MouseFunction)
            {
                Toggle_MouseFunction := !Toggle_MouseFunction
                SetTimer, ViewControl, 10 ; [可调校数值 adjustable parameters] 设定视角跟随命令的每执行时间间隔(ms)
            }
        }
    }
    ToolTip, 已启用, 0, 999 ; [可调校数值 adjustable parameters]
    Sleep 210 ; [可调校数值 adjustable parameters]
    ToolTip
}
Return

;【热键 Hotkey】重启程序以呼出操作说明界面
F3::
If (!A_IsSuspended and !Toggle_ManualSuspend)
{
    Toggle_ManualSuspend := !Toggle_ManualSuspend
    Suspend, On
    If (Toggle_AutoScale)
    {
        If (Status_CombatEscIcon)
            SendEvent, {Esc}
        SetTimer, AutoScale, Off
        Toggle_AutoScale := !Toggle_AutoScale
    }
    If (Toggle_MouseFunction)
    {
        SetTimer, ViewControl, Off
        If GetKeyState("e", "P")
            BreakFlag_Aim := !BreakFlag_Aim
        InputReset()
        Toggle_MouseFunction := !Toggle_MouseFunction
    }
}
Reload
Return

;【热键 Hotkey】对Win+Tab快捷键的支持命令
#Tab::
If (!A_IsSuspended and !Toggle_ManualSuspend)
{
    Toggle_ManualSuspend := !Toggle_ManualSuspend
    Suspend, On
    If (Toggle_AutoScale)
    {
        If (Status_CombatEscIcon)
            SendEvent, {Esc}
        SetTimer, AutoScale, Off
        Toggle_AutoScale := !Toggle_AutoScale
    }
    If (Toggle_MouseFunction)
    {
        SetTimer, ViewControl, Off
        If GetKeyState("e", "P")
            BreakFlag_Aim := !BreakFlag_Aim
        InputReset()
        Toggle_MouseFunction := !Toggle_MouseFunction
    }
    ToolTip, 暂停中, 0, 999 ; [可调校数值 adjustable parameters]
    Sleep 99 ; [可调校数值 adjustable parameters]
}
WinSet, AlwaysOnTop, Off, A
SendInput, #{Tab}
Return

;【函数 Function】对Alt+Tab快捷键的支持命令
LAltTab()
{
    If GetKeyState("Tab", "P")
    {
        If (!A_IsSuspended and !Toggle_ManualSuspend)
        {
            Toggle_ManualSuspend := !Toggle_ManualSuspend
            Suspend, On
            If (Toggle_AutoScale)
            {
                If (Status_CombatEscIcon)
                    SendEvent, {Esc}
                SetTimer, AutoScale, Off
                Toggle_AutoScale := !Toggle_AutoScale
            }
            If (Toggle_MouseFunction)
            {
                SetTimer, ViewControl, Off
                If GetKeyState("e", "P")
                    BreakFlag_Aim := !BreakFlag_Aim
                InputReset()
                Toggle_MouseFunction := !Toggle_MouseFunction
            }
            ToolTip, 暂停中, 0, 999 ; [可调校数值 adjustable parameters]
            Sleep 99 ; [可调校数值 adjustable parameters]
        }
        WinSet, AlwaysOnTop, Off, A
        SendInput, !{Tab}
    }
    Return
}

;---------------------------------------------------------------------------------------------------------------------------------------------------------------
;目前就这些，可根据需要自行修改
;---------------------------------------------------------------------------------------------------------------------------------------------------------------