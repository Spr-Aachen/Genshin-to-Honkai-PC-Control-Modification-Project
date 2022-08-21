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
Gui, Start: Add, GroupBox, W333 H105, 战斗 Combat
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Text, Xp Yp+15, 左键:                   普攻
Gui, Start: Add, Text, Xp Yp+33, 其它键位请在游戏设置界面内自行更改
Gui, Start: Add, Text, Xm+18 Yp+39 ; 控距
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
Gui, Start: Add, CheckBox, Xp Yp+33 Checked vEnableScreenScale, 启用全自动识别（推荐）

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

;【函数 Function】自动识别
AutoScale()
{
    If WinActive("ahk_exe BH3.exe")
    {
        WinGetPos, ClientUpperLeftCorner_X, ClientUpperLeftCorner_Y, Client_Width, Client_Height, ahk_exe BH3.exe
        If (Client_Width / Client_Height == 1920 / 1080)
        { ; 默认数值源于1920*1080分辨率下的测试结果
            UpperLeftCorner_X := ClientUpperLeftCorner_X
            UpperLeftCorner_Y := ClientUpperLeftCorner_Y
            LowerRightCorner_X := UpperLeftCorner_X + Round(69 * 2 * Client_Width / 1920)
            LowerRightCorner_Y := UpperLeftCorner_Y + Round(51 * 2 * Client_Height / 1080)
            Switch Client_Height
            {
                Case "1080": ;[已测试 tested]（颜色相似二值化100% + 灰度差值240）
                    Icon := "|<CombatEscIcon>0xFFFFFF@1.00$106.000400000000000030001U000000000000C00060000000000000s001U0000000000000s00C00000000000003U00s0000000000000C00700000000000000w01w00000000000003k07k0000000000000D00Q00000000000000w03k00000000000003k0D00000000000000D00w00000000000000w03k00000000000003k0C00000000000000T01s00000000000003s0DU0000000000000DU0y00000000000000y03s00000000000003s0D00000000000000DU0s00000000000000y07U00000000000007U0S00000000000000S01s00000000000001s07U00000000000007U0Q00000000000000y03k00000000000007s0T00000000000000T01w00000000000001w07k00000000000007k0Q00000000000000T01k00000000000003w0D00000000000000DU0w00000000000000w03k00000000000003k0D00000000000000D00s00000000000000w07U0000000000000Dk0y00000000000000y03s00000000000003s0D00000000000000DU0s00000000000000y03U00000000000003s0S00000000000000T01s00000000000001s07U00000000000007U0Q00000000000000S01k00000000000001s0700000000000000TU1w00000000000001w07k00000000000007k0S00000000000000T01k00000000000001w07000000000000007k0Q00000000000000z03k00000000000003k0D00000000000000D00w00000000000000w01k0000000000000DU0700000000000000y00Q00000000000003s01w0000000000000S003k0000000000001s00700000000000007000A0000000000001k000k00000000000070000U000000000000U0000U000000000000000000000000000010000000000Dw0000000000000000s00000000000000003U0000000000000000C00000000000000000s0DUT0000000000003U3W7g000000000000DwA0s0000000000000zkk300000000000003U3kQ0000000000000C03lk0000000000000s03b00000000000003U06A0000000000000C00Ms0000000000000zsz1z0000000000003zVk1k000000U"
                    Icon .= "|<ElysianRealmIcon>*240$89.zzzvzzzzzzzzzzzzzzbzzzzzzzzzzzzzyDzzzzzzzzzzzzzsTzzzzzzzzzzzzzUzzzzzzzzzzzzzy1zzzzzzzzzzzzzs3zzzzzzzzzzzzzU7zzzzzzzzzzzzy0DzzzzzzzzzzzzsATzzzzzzzzzzzzUQzzzzzzzzzzzzy1xzzzzzzzzzzzzsDvzzzzzzzzzzzzUTzzzzzzzzzzzzy1zzzzzzzzzzzzzs7zzzzzzzzzzzzzUTzzzzzzzzzzzzy1zzzzzzzzzzzzzs7zzzzzzzzzzzzzUTzzzzzzzzzzzzy1zzzzzzzzzzzzzs3zzzzzzzzzzzzzk7zzzzzzzzzzzzzk7zzzzzzzzzzzzzsDzzzzzzzzzzzzzk7zzzzzzzzzzzzzk7zzzzzzzzzzzzzsDzzzzzzzzzzzzzkDzzzzzzzzzzzzzkDzzzzzzzzzzzzzsDvzzzzzzzzzzzzkDrzzzzzzzzzzzzkDjzzzzzzzzzzzzsCTzzzzzzzzzzzzk0zzzzzzzzzzzzzk1zzzzzzzzzzzzzs3zzzzzzzzzzzzzk7zzzzzzzzzzzzzkDzzzzzzzzzzzzzsTzzzzzzzzzzzzzkzzzzzzzzzzzzzzlzzzzzzzzzzzzzzvzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzdzzzzzzzzzzzzzyyc"

                Case "720": ;[未测试 untested]（颜色相似二值化100% + 灰度差值240）
                    Icon := "|<CombatEscIcon>0xFFFFFF@1.00$72.001U0000001U00600000000s00Q00000000Q00s00000000S01k00000000C03k00000000D07U00000000D07U00000000D0D000000000D0D000000000D0D000000000D0C000000000T0S000000000S0S000000000S0S000000000S0w000000000y0w000000000w0w000000000w0s000000000w1s000000001s1s000000001s1s000000001s1k000000003s3k000000003k3k000000003k3k000000003k3U000000007k7U000000007U7U000000007U70000000007UD000000000DUD000000000D0D000000000D0C000000000T0S000000000T0S000000000S0Q000000000S0Q000000000y0w000000000y0w000000000w0w000000001w0Q000000001s0S000000003k0C000000003k0C000000007U0700000000C003U0000000Q000k0000001k0000007k0000000000400000000000400000000000410E000000007X0U0000000041100000000040l000000000409000000000408U000000007lUQ0000U"
                    Icon .= "|<ElysianRealmIcon>*240$60.zzrzzzzzzzzzbzzzzzzzzz7zzzzzzzzy7zzzzzzzzw7zzzzzzzzs7zzzzzzzzk7zzzzzzzzUbzzzzzzzz1rzzzzzzzy3zzzzzzzzw7zzzzzzzzsDzzzzzzzzkTzzzzzzzzUzzzzzzzzz1zzzzzzzzz1zzzzzzzzzUzzzzzzzzzkTzzzzzzzzsDzzzzzzzzw7zzzzzzzzy3zzzzzzzzz1rzzzzzzzzUrzzzzzzzzk7zzzzzzzzs7zzzzzzzzw7zzzzzzzzy7zzzzzzzzz7zzzzzzzzzbzzzzzzzzzrzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyU"
                    UpperLeftCorner_X := Round(UpperLeftCorner_X * 2 / 3)
                    UpperLeftCorner_Y := Round(UpperLeftCorner_Y * 2 / 3)
                    LowerRightCorner_X := Round(LowerRightCorner_X * 2 / 3)
                    LowerRightCorner_Y := Round(LowerRightCorner_Y * 2 / 3)

                Case "900": ;[未测试 untested]（颜色相似二值化100% + 灰度差值222）
                    Icon := "|<CombatEscIcon>0xFFFFFF@1.00$89.000U0000000000U00600000000001U00A00000000003000U00000000003U0300000000000700A00000000000D01s00000000000S03k00000000000w07000000000001s0S000000000003k0w000000000007U1s00000000000D03U00000000000S0D000000000001s0S000000000003k0w000000000007U1k00000000000D03000000000000y0C000000000001k0Q000000000003U0s00000000000701U00000000000S07000000000001w0S000000000003k0w000000000007U1k00000000000D03U00000000000y0D000000000001s0S000000000003k0w000000000007U1k00000000000D07U00000000000y0D000000000001s0S000000000003k0s000000000007U1U00000000000T07000000000000w0C000000000001k0Q000000000003U0k00000000000701U00000000000y0D000000000001w0S000000000003k0s000000000007U1k00000000000D03U00000000000y0D000000000001s0S000000000003k0w000000000007U0s00000000000S01k00000000000w03k00000000003U03U0000000000700300000000000Q00200000000001k002000000000040001000000000000000000000000100000000100000000000000200000000000000400000000000000800000000000000E00000000000000U0000000000000100200000000000200400000000000400000000000000800000000000000TU00000004"
                    Icon .= "|<ElysianRealmIcon>*222$74.zzzTzzzzzzzzzzzbzzzzzzzzzzzlzzzzzzzzzzzsTzzzzzzzzzzw7zzzzzzzzzzy1zzzzzzzzzzz0TzzzzzzzzzzU7zzzzzzzzzzkFzzzzzzzzzzsDTzzzzzzzzzw7rzzzzzzzzzy3xzzzzzzzzzz1zzzzzzzzzzzUTzzzzzzzzzzkDzzzzzzzzzzs7zzzzzzzzzzw3zzzzzzzzzzy1zzzzzzzzzzz0zzzzzzzzzzzs7zzzzzzzzzzz0zzzzzzzzzzzs7zzzzzzzzzzz0zzzzzzzzzzzs7zzzzzzzzzzz1zzzzzzzzzzzs7rzzzzzzzzzz0xzzzzzzzzzzs6Tzzzzzzzzzz07zzzzzzzzzzs1zzzzzzzzzzz0Tzzzzzzzzzzs7zzzzzzzzzzz1zzzzzzzzzzzsTzzzzzzzzzzz7zzzzzzzzzzztzzzzzzzzzzzzTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzDzzzzzzzzzzzjc"
                    UpperLeftCorner_X := Round(UpperLeftCorner_X * 5 / 6)
                    UpperLeftCorner_Y := Round(UpperLeftCorner_Y * 5 / 6)
                    LowerRightCorner_X := Round(LowerRightCorner_X * 5 / 6)
                    LowerRightCorner_Y := Round(LowerRightCorner_Y * 5 / 6)

                Case "1440":
                    Icon := 
                    Icon .= 
                    UpperLeftCorner_X := Round(UpperLeftCorner_X * 4 / 3)
                    UpperLeftCorner_Y := Round(UpperLeftCorner_Y * 4 / 3)
                    LowerRightCorner_X := Round(LowerRightCorner_X * 4 / 3)
                    LowerRightCorner_Y := Round(LowerRightCorner_Y * 4 / 3)

                Case "2160":
                    Icon := 
                    Icon .= 
                    UpperLeftCorner_X *= 2
                    UpperLeftCorner_Y *= 2
                    LowerRightCorner_X *= 2
                    LowerRightCorner_Y *= 2

                Default:
                    Icon := 
                    Icon .= 
                    UpperLeftCorner_X := ClientUpperLeftCorner_X
                    UpperLeftCorner_Y := ClientUpperLeftCorner_Y
                    LowerRightCorner_X += UpperLeftCorner_X + Client_Width
                    LowerRightCorner_Y := UpperLeftCorner_Y + Client_Height
            }
        }
        Else If (Client_Width / Client_Height == 1360 / 768)
        {
            UpperLeftCorner_X := ClientUpperLeftCorner_X
            UpperLeftCorner_Y := ClientUpperLeftCorner_Y
            LowerRightCorner_X := UpperLeftCorner_X + Round(48 * 2 * Client_Width / 1360)
            LowerRightCorner_Y := UpperLeftCorner_Y + Round(36 * 2 * Client_Height / 768)
            Switch Client_Height
            {
                Case "768": ;[未测试 untested]（颜色相似二值化100%）
                    Icon := "|<CombatEscIcon>0xFFFFFF@1.00$76.000000000000U00U000000003004000000000600k000000000M060000000001k0s000000000703U000000000Q0A0000000001k1k0000000007070000000000Q0M0000000001k3U000000000C0C0000000000s0s0000000003U30000000000C0Q0000000001k1k0000000007070000000000Q0M0000000003k3U000000000C0C0000000000s0s0000000007U30000000000y0Q0000000003k1k000000000D070000000000w0M0000000003k3U000000000S0C0000000001s0k0000000007U30000000000S0Q0000000003k1k000000000D060000000000w0s0000000007k7U000000000S0S0000000001k1k0000000007070000000000w0w0000000003k3k000000000C0D0000000000s0Q000000000701k000000000Q03U000000003U06000000000A008000000001U00E000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000E000002"
                    Icon .= "|<ElysianRealmIcon>*234$60.zzrzzzzzzzzzbzzzzzzzzz7zzzzzzzzy7zzzzzzzzw7zzzzzzzzs7zzzzzzzzkbzzzzzzzzVzzzzzzzzz3zzzzzzzzy7zzzzzzzzw7zzzzzzzzsDzzzzzzzzkTzzzzzzzzUzzzzzzzzz1zzzzzzzzz1zzzzzzzzzUzzzzzzzzzkTzzzzzzzzsDzzzzzzzzw7zzzzzzzzy3zzzzzzzzz3zzzzzzzzzVrzzzzzzzzkbzzzzzzzzs7zzzzzzzzw7zzzzzzzzy7zzzzzzzzz7zzzzzzzzzbzzzzzzzzzrzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyU"

                Default:
                    Icon := 
                    Icon .= 
                    UpperLeftCorner_X := ClientUpperLeftCorner_X
                    UpperLeftCorner_Y := ClientUpperLeftCorner_Y
                    LowerRightCorner_X += UpperLeftCorner_X + Client_Width
                    LowerRightCorner_Y := UpperLeftCorner_Y + Client_Height
            }
        }
        Else If (Client_Width / Client_Height == 1440 / 900)
        {
            UpperLeftCorner_X := ClientUpperLeftCorner_X
            UpperLeftCorner_Y := ClientUpperLeftCorner_Y
            LowerRightCorner_X := UpperLeftCorner_X + Round(51 * 2 * Client_Width / 1440)
            LowerRightCorner_Y := UpperLeftCorner_Y + Round(39 * 2 * Client_Height / 900)
            Switch Client_Height
            {
                Case "900": ;[未测试 untested]（颜色相似二值化100%）
                    Icon := "|<CombatEscIcon>0xFFFFFF@1.00$80.00200000000020030000000000k01U000000000600k0000000001U0Q0000000000Q060000000000703U0000000001k0k0000000000Q0Q000000000070700000000001k1k0000000000Q0s0000000000C0S00000000003U7U0000000000s1s0000000000C0Q00000000003UD00000000001k3k0000000000Q0w000000000070C00000000003k7U0000000000s1s0000000000C0S00000000003U700000000000s1k0000000000w0w0000000000D0D00000000003k300000000000w1k0000000000T0Q00000000007U700000000001s1U0000000000S0M00000000007UC00000000003k3U0000000000w0k0000000000D0A00000000007k700000000001w1k0000000000Q0M000000000070600000000001k3U0000000000w0s0000000000C0C00000000003U3U0000000001k0M0000000000Q060000000000701k0000000003U0A0000000001k010000000000s008000000000M000000000000000000000000000000000200000000000000000000000000000000000000000000000000000U0000000000000010000000000000E000000000000400000000000000000000000200000000U"
                    Icon .= "|<ElysianRealmIcon>*222$65.zzxzzzzzzzzzznzzzzzzzzzz7zzzzzzzzzwDzzzzzzzzzkTzzzzzzzzz0zzzzzzzzzw1zzzzzzzzzk3zzzzzzzzz1bzzzzzzzzw7jzzzzzzzzkTTzzzzzzzz1zzzzzzzzzw3zzzzzzzzzkDzzzzzzzzz1zzzzzzzzzw7zzzzzzzzzkDzzzzzzzzzkTzzzzzzzzzkTzzzzzzzzzkTzzzzzzzzzkTzzzzzzzzzkTzzzzzzzzzkTzzzzzzzzzkyzzzzzzzzzkxzzzzzzzzzkHzzzzzzzzzk7zzzzzzzzzkDzzzzzzzzzkTzzzzzzzzzkzzzzzzzzzzlzzzzzzzzzznzzzzzzzzzzrzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyzzzzzzzzzzzE"
                Default:
                    Icon := 
                    Icon .= 
                    UpperLeftCorner_X := ClientUpperLeftCorner_X
                    UpperLeftCorner_Y := ClientUpperLeftCorner_Y
                    LowerRightCorner_X += UpperLeftCorner_X + Client_Width
                    LowerRightCorner_Y := UpperLeftCorner_Y + Client_Height
            }
        }

        Else
        { ; 其它比率尚未测试,暂通过扩大原识别范围(21px)处理
            UpperLeftCorner_X := ClientUpperLeftCorner_X
            UpperLeftCorner_Y := ClientUpperLeftCorner_Y
            LowerRightCorner_X := UpperLeftCorner_X + Round((69 * 2 + 21) * Client_Width / 1920)
            LowerRightCorner_Y := UpperLeftCorner_Y + Round((51 * 2 + 21) * Client_Height / 1080)
            Switch Client_Height
            {
                Case "1080":
                    Icon := 
                    Icon .= 

                Case "720":
                    Icon := 
                    Icon .= 
                    UpperLeftCorner_X := Round(UpperLeftCorner_X * 2 / 3)
                    UpperLeftCorner_Y := Round(UpperLeftCorner_Y * 2 / 3)
                    LowerRightCorner_X := Round(LowerRightCorner_X * 2 / 3)
                    LowerRightCorner_Y := Round(LowerRightCorner_Y * 2 / 3)

                Case "900":
                    Icon := 
                    Icon .= 
                    UpperLeftCorner_X := Round(UpperLeftCorner_X * 5 / 6)
                    UpperLeftCorner_Y := Round(UpperLeftCorner_Y * 5 / 6)
                    LowerRightCorner_X := Round(LowerRightCorner_X * 5 / 6)
                    LowerRightCorner_Y := Round(LowerRightCorner_Y * 5 / 6)

                Case "1440":
                    Icon := 
                    Icon .= 
                    UpperLeftCorner_X := Round(UpperLeftCorner_X * 4 / 3)
                    UpperLeftCorner_Y := Round(UpperLeftCorner_Y * 4 / 3)
                    LowerRightCorner_X := Round(LowerRightCorner_X * 4 / 3)
                    LowerRightCorner_Y := Round(LowerRightCorner_Y * 4 / 3)

                Case "2160":
                    Icon := 
                    Icon .= 
                    UpperLeftCorner_X *= 2
                    UpperLeftCorner_Y *= 2
                    LowerRightCorner_X *= 2
                    LowerRightCorner_Y *= 2

                Default:
                    Icon := 
                    Icon .= 
                    UpperLeftCorner_X := ClientUpperLeftCorner_X
                    UpperLeftCorner_Y := ClientUpperLeftCorner_Y
                    LowerRightCorner_X += UpperLeftCorner_X + Client_Width
                    LowerRightCorner_Y := UpperLeftCorner_Y + Client_Height
            }
        }
        ; ScreenScale
        If (FindText(X, Y, UpperLeftCorner_X, UpperLeftCorner_Y, LowerRightCorner_X, LowerRightCorner_Y, 0.003, 0.003, Icon)[1].id == "CombatEscIcon")
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
                If (FindText(X, Y, UpperLeftCorner_X, UpperLeftCorner_Y, LowerRightCorner_X, LowerRightCorner_Y, 0.003, 0.003, Icon)[1].id == "ElysianRealmIcon")
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