;---------------------------------------------------------------------------------------------------------------------------------------------------------------
;Version 0.3.0 beta
;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【指令】引用库文件FindText.ahk
#include <FindText>

;【指令】修改AHK的默认掩饰键
#MenuMaskKey vkE8  ; vkE8尚未映射
#UseHook

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

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
Gui, Start: Font, s12, 新宋体
Gui, Start: Margin , X, Y
Gui, Start: + Theme
Gui, Start: Add, Text, x+3, ; 集体缩进
Gui, Start: Add, Text,, Q:                      必杀技
Gui, Start: Add, Text,, E:                      武器技/后崩技能
Gui, Start: Add, Text,, Z:                      人偶技
Gui, Start: Add, Text,, 左ShIft/右键:           闪避
Gui, Start: Add, Text,, 左键:                   普攻
Gui, Start: Add, Text,, 左Alt+左键:             正常左键
Gui, Start: Add, Text,, 中键:                   管理视角跟随
Gui, Start: Add, Text,, F1:                     暂停/启用
Gui, Start: Add, Text,, F3:                     查看说明
Gui, Start: Add, Link,, 源码查看:               <a href="https://github.com/Spartan711/Genshin-to-Honkai-PC-Control-Project/blob/main/BH3_Hotkey.ahk">传送门</a>
Gui, Start: Add, Text,,
Gui, Start: Add, Button, xn w333, 开启
Gui, Start: Show, xCenter yCenter, 设置说明
Disable( )
Suspend, On
Return

;【标签】“开启”按钮的执行语句
StartButton开启:
If (!A_IsAdmin)
{
    MsgBox, 4,, 是否以管理员身份运行该程序？
    IfMsgBox, Yes
    {
        If (A_IsCompiled)
        {
            RegWrite, REG_SZ, HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers,%A_ScriptFullPath%, ~ RUNASADMIN
            RegWrite, REG_SZ, HKCR\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers,%A_ScriptFullPath%, ~ RUNASADMIN
        }
        Else
        {
            RegWrite, REG_SZ, HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers,%A_AhkPath%, ~ RUNASADMIN
            RegWrite, REG_SZ, HKCR\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers,%A_AhkPath%, ~ RUNASADMIN
        }
    } 
    Else
    {
        If (A_IsCompiled)
        {
            RegDelete, HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers,%A_ScriptFullPath%, ~ RUNASADMIN
            RegDelete, HKCR\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers,%A_ScriptFullPath%, ~ RUNASADMIN
        }
        Else
        {
            RegDelete, HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers,%A_AhkPath%, ~ RUNASADMIN
            RegDelete, HKCR\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers,%A_AhkPath%, ~ RUNASADMIN
       }
   }
}
Suspend, Off
Gui, Start: Destroy
SetTimer, AutoFadeMsgbox, -3000 ; [可调校数值] 使消息弹窗仅存在一段时间(ms)
MsgBox, 0, 提示, 程序进入运行状态,可在游戏内按F1键停用`n（PS：当前对话框将于3秒后自动消失）
SetTimer, AutoFadeMsgbox, Off
SetTimer, ScreenScale, 90 ; [可调校数值] 设定自动识别命令的每执行时间间隔(ms)，如果值过小可能不好使
Return

;【标签】让对话框自动消失
AutoFadeMsgbox:
DLLCall( "AnimateWindow", UInt, WinExist( "提示 ahk_class #32770"), Int, 500, UInt, 0x90000)
Return

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【宏条件】检测崩坏3游戏窗口，使程序仅在崩坏3游戏运行时生效
#IfWinActive ahk_exe BH3.exe

;【常量】对管理鼠标控制功能的全局常量进行赋值
Global Toggle_MouseFunction := 0

;【常量】对管理视角跟随功能的全局常量进行赋值
Global Status_MButton := 0

;【常量】对管理准星跟随功能的全局常量进行赋值
Global BreakFlag_Aim := 0
Global Status_w := 0
Global Status_a := 0
Global Status_s := 0
Global Status_d := 0

;【常量】对管理自动识别功能的全局常量进行赋值
Global Toggle_ScreenScale := 1

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
        If (x1 != x2 || y1 != y2)
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
        If (abs(x1 - x2) > Threshold || abs(y1 - y2) > Threshold)
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
        Else If (x1 > x2 && y1 > y2)
        {
            SendInput, {q Down}{n Down}
            Sleep, 1
            SendInput, {q Up}{n Up}
        }
        Else If (x1 < x2 && y1 > y2)
        {
            SendInput, {e Down}{n Down}
            Sleep, 1
            SendInput, {e Up}{n Up}
        }
        Else If (x1 > x2 && y1 < y2)
        {
            SendInput, {q Down}{m Down}
            Sleep, 1
            SendInput, {q Up}{m Up}
        }
        Else If (x1 < x2 && y1 < y2)
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

;【函数】准星控制
AimControl()
{
    If WinActive("ahk_exe BH3.exe")
    {
        Loop
        {
            MouseGetPos, x1, y1
            Sleep, 10 ; [可调校数值] 设定采集当前光标坐标值的时间间隔(ms)
            MouseGetPos, x2, y2
            If (x1 != x2 || y1 != y2) ; 采用层级指令覆盖结构
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
            Sleep, 12 ; [可调校数值] 设定准星跟随命令的每执行间隔时间(ms)
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
                If GetKeyState("e", "P")
                BreakFlag_Aim := !BreakFlag_Aim
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

;【热键】按下键盘Q键以发动必杀技
q::
If GetKeyState("q", "P") ; 通过行为检测防止Q键被ViewControlTemp函数唤醒
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

;【热键】按下键盘E键以发动武器技/后崩坏书必杀技，长按E键进入瞄准模式时可用鼠标键操控准心
e::
If GetKeyState("e", "P") ; 通过行为检测防止E键被ViewControlTemp函数唤醒
{
    SendInput, {u Down}
    If (Toggle_MouseFunction)
        AimControl()
    Else
        KeyWait, e
    SendInput, {u Up}
}
Return

;【热键】按下键盘Z键以发动人偶技
z::l

;【热键】按下键盘左侧ShIft键以发动闪避/冲刺
LShIft::
SendInput, {k Down}
KeyWait, LShIft
SendInput, {k Up}
Return

;【热键】点按鼠标右键以发动闪避/冲刺
RButton::
SendInput, {k Down}
KeyWait, RButton
SendInput, {k Up}
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

;【函数】该段用于管理输入法
SwitchIME(dwLayout)
{
    HKL := DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
    ControlGetFocus, ctl, A
    SendMessage, 0x50, 0, HKL, %ctl%, A
}

;【热键】暂停/启用程序
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
        If GetKeyState("e", "P")
            BreakFlag_Aim := !BreakFlag_Aim
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
        If GetKeyState("e", "P")
            BreakFlag_Aim := !BreakFlag_Aim
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
        If GetKeyState("e", "P")
            BreakFlag_Aim := !BreakFlag_Aim
        InputReset()
        Toggle_MouseFunction := !Toggle_MouseFunction
    }
    ToolTip, 暂停中, 0, 999 ; [可调校数值]
    Sleep 99 ; [可调校数值]
    SwitchIME(0x04090409) ; 切换至"中文(中国) 简体中文-美式键盘"
    ;SendInput, #{Space} ; [未启用命令行] 微软拼音用户可用该命令
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
                If GetKeyState("e", "P")
                    BreakFlag_Aim := !BreakFlag_Aim
                InputReset()
                Toggle_MouseFunction := !Toggle_MouseFunction
            }
            ToolTip, 暂停中, 0, 999 ; [可调校数值]
            Sleep 99 ; [可调校数值]
            SwitchIME(0x04090409) ; 切换至"中文(中国) 简体中文-美式键盘"
            ;SendInput, #{Space} ; [未启用命令行] 微软拼音用户可用该命令
        }
        WinSet, AlwaysOnTop, Off, A
        SendInput, !{Tab}
    }
    Return
}

;---------------------------------------------------------------------------------------------------------------------------------------------------------------
;目前就这些，可根据需要自行修改
;---------------------------------------------------------------------------------------------------------------------------------------------------------------