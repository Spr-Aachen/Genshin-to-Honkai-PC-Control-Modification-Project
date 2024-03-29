﻿;---------------------------------------------------------------------------------------------------------------------------------------------------------------
; 这里用于存放战斗功能相关的函数
;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【函数 Function】隐藏光标
Occlusion(Status_Occlusion)
{
    If WinActive("ahk_exe BH3.exe")
    {
        If (Toggle_Occlusion)
        {
            If (Status_Occlusion)
            {
                MouseGetPos, , , HWND
                Gui, Cursor: +Owner%HWND%
                DllCall("ShowCursor", "UInt", 0)
            } 
            Else 
            {
                DllCall("ShowCursor", "UInt", 1)
            }
        }
    }
}


;【函数 Function】定位光标
ZoneDetect()
{
    If WinActive("ahk_exe BH3.exe")
    {
        If (FirstTime_ZoneDetect)
        {
            WinGetPos, X, Y, W, H, ahk_exe BH3.exe
            ClientUpperLeftCorner_X := X
            ClientUpperLeftCorner_Y := Y
            Client_Width := W
            Client_Height := H

            FirstTime_ZoneDetect := !FirstTime_ZoneDetect
        }
        MouseGetPos, x1, y1
        If (x1 > (ClientUpperLeftCorner_X + Client_Width / 2 + Client_Width / 4) || x1 < (ClientUpperLeftCorner_X + Client_Width / 2 - Client_Width / 4) || y1 > (ClientUpperLeftCorner_Y + Client_Height / 2 + Client_Height / 4) || y1 < (ClientUpperLeftCorner_Y + Client_Height / 2 - Client_Height / 4))
        {
            If (!IsZoneInteractive)
                IsZoneInteractive := True
        }
        Else
        {
            If (IsZoneInteractive)
                IsZoneInteractive := False
        }
    }
}


;【函数 Function】重置光标
CoordReset()
{
    If WinActive("ahk_exe BH3.exe")
    {
        CoordMode, Mouse, Client
        Try
            MouseMove, Client_Width/2, Client_Height/2, 0 ; [建议保持数值] 使鼠标回正，居中于窗口
        Catch
        {
            WinGetPos, , , W, H, ahk_exe BH3.exe ; 获取崩坏3游戏窗口参数（同样适用于非全屏）
            Client_Width := W
            Client_Height := H
            CoordReset()
        }
    }
}


;【函数 Function】限制光标
Restriction()
{
    ZoneDetect()
    If WinActive("ahk_exe BH3.exe")
    {
        If (Toggle_Restriction)
        {
            If (Status_Restriction)
            {
                If (IsZoneInteractive)
                {
                    If (Status_ViewControl)
                    {
                        SendInput, {Click, Up Middle}
                        Status_ViewControl := !Status_ViewControl
                    }
                    CoordReset()
                }
            }
        }
    }
}


;【函数 Function】光标定位
MouseDetect()
{
    If WinActive("ahk_exe BH3.exe")
    {
        Restriction()
        Sleep, 1 ; [可调校数值 adjustable parameters] 设定采集当前光标坐标值的时间间隔(ms)
        MouseGetPos, x2, y2
    }
}


;【函数 Function】冲突检测
ConflictDetect()
{
    If WinActive("ahk_exe BH3.exe")
    {
        If (Status_ViewControl)
        {
            If GetKeyState("MButton")
            {
                List := ["LButton", "RButton"] ;在光标位于非交互区时，其它鼠标键会打断中键的逻辑状态
                LEN := List.Length()
                IsConflictDetected := False
                While (Status_ViewControl)
                {
                    If (A_Index <= LEN)
                        NUM := A_Index
                    Else
                        NUM := abs(Mod(A_Index, LEN) - LEN)

                    If GetKeyState(List[NUM])
                    {
                        If (!IsConflictDetected)
                            IsConflictDetected := True
                        SendInput, {Click, Up Middle} ;SendEvent, MButton

                        ConflictKey := List[NUM]
                        KeyWait, %ConflictKey% ;KeyWait, %ConflictKey%, L

                        ZoneDetect()
                        If (!IsZoneInteractive)
                            SendInput, {Click, Down Middle}
                        Else
                            Break
                    }
                    Else If (!IsConflictDetected && NUM == LEN)
                        Break
                }
            }
            Else
                SendInput, {Click, Down Middle}
        }
        Else
        {
            If (!BreakFlag_View)
                BreakFlag_View := !BreakFlag_View
            ;Return
        }
    }
    Else
    {
        If (Status_ViewControl)
        {
            SendInput, {Click, Up Middle}
            Status_ViewControl := !Status_ViewControl
        }
    }
}


;【函数 Function】视角跟随
ViewControl()
{
    MouseDetect()
    If WinActive("ahk_exe BH3.exe")
    {
        If (x1 != x2 or y1 != y2)
        {
            If (!Status_ViewControl)
            {
                Status_ViewControl := !Status_ViewControl
                ;SendInput, {Click, Down Middle}
                Switch ViewControl_Mod
                {
                    Case "Mod1":
                        ConflictDetect()

                    Case "Mod2":
                        SetTimer, ConflictDetect, %Timer_ConflictDetect%
                        Loop, 120
                        {
                            If (BreakFlag_View)
                            {
                                BreakFlag_View := !BreakFlag_View
                                Break
                            }
                            Sleep, 10
                        }
                        SetTimer, ConflictDetect, Delete
                    
                    Default :
                        ;ConflictDetect()
                }
            }
        }
        Else
        {
            If (Status_ViewControl)
            {
                SendInput, {Click, Up Middle}
                Status_ViewControl := !Status_ViewControl
            }
        }
    }
}


;【函数 Function】临时视角跟随
ViewControlTemp()
{
    MouseDetect()
    If WinActive("ahk_exe BH3.exe")
    {
        Threshold := 33 ; [可调校数值 adjustable parameters] 设定切换两种视角跟随模式的像素阈值
        If (abs(x1 - x2) > Threshold or abs(y1 - y2) > Threshold)
        {
            If (!Status_ViewControl)
            {
                Status_ViewControl := !Status_ViewControl
                ;SendInput, {Click, Down Middle}
                ConflictDetect()
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
            If (Status_ViewControl)
            {
                SendInput, {Click, Up Middle}
                Status_ViewControl := !Status_ViewControl
            }
        }
    }
}


;【函数 Function】准星控制
AimControl()
{
    MouseDetect()
    If WinActive("ahk_exe BH3.exe")
    {
        Loop
        {
            If (x1 != x2 or y1 != y2)
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
            Sleep, %Timer_AimControl%
            If (BreakFlag_Aim) ; (Abort the function when BreakFlag_Aim == 1)
            {
                BreakFlag_Aim := !BreakFlag_Aim
                break
            }
        } Until Not GetKeyState(A_ThisHotkey, "P")
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
    If Not GetKeyState("E")
    {
        Try
            SetTimer, AimControl, Delete
        Catch
            SetTimer, AimControl, -1
    }
    Try
    {
        If GetKeyState("MButton")
        {
            If (Status_ViewControl)
            {
                If (!BreakFlag_View)
                    BreakFlag_View := !BreakFlag_View
                Status_ViewControl := !Status_ViewControl
            }
            SendInput, {Click, Up Middle}
        }
        SetTimer, ViewControlTemp, Delete
    }
    Catch
        SetTimer, ViewControlTemp, -1
}


;---------------------------------------------------------------------------------------------------------------------------------------------------------------