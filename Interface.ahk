;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【函数 Function】界面状态栏
Disable( )
{
    WinGet, id, ID, A
    menu := DLLCall("user32\GetSystemMenu", "UInt", id, "UInt", 0)
    DLLCall("user32\DeleteMenu", "UInt", menu, "UInt", 0xF060, "UInt", 0x0)
    WinGetPos ,x, y, w, h, ahk_id %id%
    WinMove, ahk_id %id%,, %x%, %y%, %w%, % h-1
    WinMove, ahk_id %id%,, %x%, %y%, %w%, % h+1
}


;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【位置 Path】设定位置
Root_DIR = C:\BH3_Hotkey
;SetWorkingDir, C:\BH3_Hotkey

FileCreateDir, %Root_DIR%\Config
INI_DIR = %Root_DIR%\Config\BH3_Hotkey_%Version%.ini

FileCreateDir, %Root_DIR%\GUI\Changelogs
Changelog_DIR1 = %Root_DIR%\GUI\Changelogs\v0.1.+.txt
Changelog_DIR2 = %Root_DIR%\GUI\Changelogs\v0.2.+.txt
Changelog_DIR3 = %Root_DIR%\GUI\Changelogs\v0.3.+.txt



;【配置 INI】创建配置
IfNotExist, %INI_DIR%
{
    IniRead, Key_MainSkill1, %INI_DIR%, Key Maps, 必杀技1, Q
    IniRead, Key_MainSkill2, %INI_DIR%, Key Maps, 必杀技2, %A_Space%
    IniRead, Key_SecondSkill1, %INI_DIR%, Key Maps, 武器技/后崩技1, E
    IniRead, Key_SecondSkill2, %INI_DIR%, Key Maps, 武器技/后崩技2, %A_Space%
    IniRead, Key_DollSkill1, %INI_DIR%, Key Maps, 人偶技/月之环1, Z
    IniRead, Key_DollSkill2, %INI_DIR%, Key Maps, 人偶技/月之环2, %A_Space%
    IniRead, Key_Dodging1, %INI_DIR%, Key Maps, 闪避1, LShift
    IniRead, Key_Dodging2, %INI_DIR%, Key Maps, 闪避2, RButton
    IniRead, Key_NormalAttack1, %INI_DIR%, Key Maps, 普攻1, %A_Space%
    IniRead, Key_NormalAttack2, %INI_DIR%, Key Maps, 普攻2, LButton
    ;IniRead, Key_LeftClick, %INI_DIR%, Key Maps, 正常点击, LAlt + LButton
    IniRead, Key_ViewControl1, %INI_DIR%, Key Maps, 管理视角跟随1, %A_Space%
    IniRead, Key_ViewControl2, %INI_DIR%, Key Maps, 管理视角跟随2, MButton
    IniRead, Key_Suspend1, %INI_DIR%, Key Maps, 暂停/启用1, F1
    IniRead, Key_Suspend2, %INI_DIR%, Key Maps, 暂停/启用2, %A_Space%
    IniRead, Key_SurfaceCheck1, %INI_DIR%, Key Maps, 调出界面1, F3
    IniRead, Key_SurfaceCheck2, %INI_DIR%, Key Maps, 调出界面2, %A_Space%

    IniRead, RunAsAdmin, %INI_DIR%, CheckBox, 管理员权限, 1 ; Check by default
    IniRead, EnableAutoScale, %INI_DIR%, CheckBox, 全自动识别, 1 ; Check by default
    IniRead, EnableOcclusion, %INI_DIR%, CheckBox, 可隐藏光标, 0 ; Uncheck by default
    IniRead, EnableRestriction, %INI_DIR%, CheckBox, 限制性光标, 1 ; Check by default

    IniRead, FaultTolerance_Combat_Normal_Percentage1, %INI_DIR%, Slider, 正常战斗状态识别容错率1, 3
    IniRead, FaultTolerance_Combat_Normal_Percentage2, %INI_DIR%, Slider, 正常战斗状态识别容错率2, 3
    IniRead, FaultTolerance_Combat_Endangered_Percentage1, %INI_DIR%, Slider, 特殊战斗状态识别容错率1, 12
    IniRead, FaultTolerance_Combat_Endangered_Percentage2, %INI_DIR%, Slider, 特殊战斗状态识别容错率2, 12
    IniRead, FaultTolerance_Elysium_Percentage1, %INI_DIR%, Slider, 往世乐土大厅识别容错率1, 1
    IniRead, FaultTolerance_Elysium_Percentage2, %INI_DIR%, Slider, 往世乐土大厅识别容错率2, 1
}
Else
{
    IniRead, Key_MainSkill1, %INI_DIR%, Key Maps, 必杀技1
    IniRead, Key_MainSkill2, %INI_DIR%, Key Maps, 必杀技2
    IniRead, Key_SecondSkill1, %INI_DIR%, Key Maps, 武器技/后崩技1
    IniRead, Key_SecondSkill2, %INI_DIR%, Key Maps, 武器技/后崩技2
    IniRead, Key_DollSkill1, %INI_DIR%, Key Maps, 人偶技/月之环1
    IniRead, Key_DollSkill2, %INI_DIR%, Key Maps, 人偶技/月之环2
    IniRead, Key_Dodging1, %INI_DIR%, Key Maps, 闪避1
    IniRead, Key_Dodging2, %INI_DIR%, Key Maps, 闪避2
    IniRead, Key_NormalAttack1, %INI_DIR%, Key Maps, 普攻1
    IniRead, Key_NormalAttack2, %INI_DIR%, Key Maps, 普攻2
    ;IniRead, Key_LeftClick, %INI_DIR%, Key Maps, 正常点击
    IniRead, Key_ViewControl1, %INI_DIR%, Key Maps, 管理视角跟随1
    IniRead, Key_ViewControl2, %INI_DIR%, Key Maps, 管理视角跟随2
    IniRead, Key_Suspend1, %INI_DIR%, Key Maps, 暂停/启用1
    IniRead, Key_Suspend2, %INI_DIR%, Key Maps, 暂停/启用2
    IniRead, Key_SurfaceCheck1, %INI_DIR%, Key Maps, 调出界面1
    IniRead, Key_SurfaceCheck2, %INI_DIR%, Key Maps, 调出界面2

    IniRead, RunAsAdmin, %INI_DIR%, CheckBox, 管理员权限
    IniRead, EnableAutoScale, %INI_DIR%, CheckBox, 全自动识别
    IniRead, EnableOcclusion, %INI_DIR%, CheckBox, 可隐藏光标
    IniRead, EnableRestriction, %INI_DIR%, CheckBox, 限制性光标

    IniRead, FaultTolerance_Combat_Normal_Percentage1, %INI_DIR%, Slider, 正常战斗状态识别容错率1
    IniRead, FaultTolerance_Combat_Normal_Percentage2, %INI_DIR%, Slider, 正常战斗状态识别容错率2
    IniRead, FaultTolerance_Combat_Endangered_Percentage1, %INI_DIR%, Slider, 特殊战斗状态识别容错率1
    IniRead, FaultTolerance_Combat_Endangered_Percentage2, %INI_DIR%, Slider, 特殊战斗状态识别容错率2
    IniRead, FaultTolerance_Elysium_Percentage1, %INI_DIR%, Slider, 往世乐土大厅识别容错率1
    IniRead, FaultTolerance_Elysium_Percentage2, %INI_DIR%, Slider, 往世乐土大厅识别容错率2
}


;【菜单 Menu】托盘菜单
Menu, Tray, NoStandard ; 删除原有托盘菜单

Menu, Else, Add, 查看配置文件, Config_Check
Menu, Else, Add, 删除配置文件, Config_Delete
;Menu, Else, Add, 调试日志, Debug
Menu, Else, Add, 敬请期待, Nothing

Menu, Tray, Add, 其它, :Else
Menu, Tray, Add, 重启, Menu_Reload
Menu, Tray, Add, 退出, Menu_Exit

;【界面 GUI】说明界面
;Gui, Start: Color, FFFFFF
Gui, Start: +LastFound
WinSet, TransColor, FEFFFF 222 ; WinSet, Transparent, 222
Gui, Start: Font, s12, 新宋体
Gui, Start: Add, Tab3, , 键位|功能|设置

Gui, Start: Tab, 键位
;Gui, Start: Add, Picture,Xm+18 Ym+18 W333 H-1, C:\Users\Spr_Aachen\Desktop\p1.jpg
Gui, Start: Add, Text, Xm+18 Ym+18 +BackgroundTrans ; 控距
Gui, Start: Add, GroupBox, W333 H201,                                            战斗 Combat
Gui, Start: Add, Text, Xp+18 Yp+18 +BackgroundTrans ; 集体缩进
Gui, Start: Add, Text, Xp Yp+15 +BackgroundTrans,        :                       必杀技
Gui, Start: Add, Hotkey, Xp Yp W84 +BackgroundTrans vKey_MainSkill1,             %Key_MainSkill1%
Gui, Start: Add, Text, Xp+87 Yp +BackgroundTrans, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 +BackgroundTrans vKey_MainSkill2,    %Key_MainSkill2%||%Key_Dodging2%|%Key_NormalAttack2%|%Key_ViewControl2%
Gui, Start: Add, Text, Xp-99 Yp+33 +BackgroundTrans,     :                       武器技/后崩技
Gui, Start: Add, Hotkey, Xp Yp W84 +BackgroundTrans vKey_SecondSkill1,           %Key_SecondSkill1%
Gui, Start: Add, Text, Xp+87 Yp +BackgroundTrans, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 +BackgroundTrans vKey_SecondSkill2,  %Key_SecondSkill2%||%Key_NormalAttack2%|%Key_ViewControl2%|%Key_Dodging2%
Gui, Start: Add, Text, Xp-99 Yp+33 +BackgroundTrans,     :                       人偶技/月之环
Gui, Start: Add, Hotkey, Xp Yp W84 +BackgroundTrans vKey_DollSkill1,             %Key_DollSkill1%
Gui, Start: Add, Text, Xp+87 Yp +BackgroundTrans, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 +BackgroundTrans vKey_DollSkill2,    %Key_DollSkill2%||%Key_NormalAttack2%|%Key_ViewControl2%|%Key_Dodging2%
Gui, Start: Add, Text, Xp-99 Yp+33 +BackgroundTrans,     :                       闪避
Gui, Start: Add, Hotkey, Xp Yp W84 +BackgroundTrans vKey_Dodging1,               %Key_Dodging1%
Gui, Start: Add, Text, Xp+87 Yp +BackgroundTrans, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 +BackgroundTrans vKey_Dodging2,      %Key_Dodging2%||%Key_NormalAttack2%|%Key_ViewControl2%|%A_Space%
Gui, Start: Add, Text, Xp-99 Yp+33 +BackgroundTrans,     :                       普攻
Gui, Start: Add, Hotkey, Xp Yp W84 +BackgroundTrans vKey_NormalAttack1,          %Key_NormalAttack1%
Gui, Start: Add, Text, Xp+87 Yp +BackgroundTrans, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 +BackgroundTrans vKey_NormalAttack2, %Key_NormalAttack2%||%Key_ViewControl2%|%Key_Dodging2%|%A_Space%
Gui, Start: Add, Text, Xm+18 Yp+36 +BackgroundTrans ; 控距
Gui, Start: Add, GroupBox, W333 H168,                                            其它 Others
Gui, Start: Add, Text, Xp+18 Yp+18 +BackgroundTrans ; 集体缩进
Gui, Start: Add, Text, Xp Yp+15 +BackgroundTrans,        左Alt      +      左键: 正常点击
;Gui, Start: Add, Hotkey, Xp Yp W84 vKey_LeftClick,             %Key_LeftClick%
Gui, Start: Add, Text, Xp Yp+33 +BackgroundTrans,        :                       管理视角跟随
Gui, Start: Add, Hotkey, Xp Yp W84 +BackgroundTrans vKey_ViewControl1,           %Key_ViewControl1%
Gui, Start: Add, Text, Xp+87 Yp +BackgroundTrans, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 +BackgroundTrans vKey_ViewControl2,  %Key_ViewControl2%||%Key_NormalAttack2%|%Key_Dodging2%|%A_Space%
Gui, Start: Add, Text, Xp-99 Yp+33 +BackgroundTrans,     :                       暂停/启用
Gui, Start: Add, Hotkey, Xp Yp W84 +BackgroundTrans vKey_Suspend1,               %Key_Suspend1%
Gui, Start: Add, Text, Xp+87 Yp +BackgroundTrans, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 +BackgroundTrans vKey_Suspend2,      %Key_Suspend2%||%Key_NormalAttack2%|%Key_ViewControl2%|%Key_Dodging2%
Gui, Start: Add, Text, Xp-99 Yp+33 +BackgroundTrans,     :                       调出界面
Gui, Start: Add, Hotkey, Xp Yp W84 +BackgroundTrans vKey_SurfaceCheck1,          %Key_SurfaceCheck1%
Gui, Start: Add, Text, Xp+87 Yp +BackgroundTrans, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 +BackgroundTrans vKey_SurfaceCheck2, %Key_SurfaceCheck2%||%Key_NormalAttack2%|%Key_ViewControl2%|%Key_Dodging2%
Gui, Start: Add, Text, Xm+18 Yp+36 +BackgroundTrans ; 控距

Gui, Start: Tab, 功能
Gui, Start: Add, Text, Xm+18 Ym+18 +BackgroundTrans ; 控距
Gui, Start: Add, GroupBox, W333 H174,                                                               选项 Options
Gui, Start: Add, Text, Xp+18 Yp+18 +BackgroundTrans ; 集体缩进
Gui, Start: Add, CheckBox, Xp Yp+15 +BackgroundTrans vRunAsAdmin Checked%RunAsAdmin%,               启用管理员权限（推荐）
Gui, Start: Add, CheckBox, Xp Yp+33 +BackgroundTrans vEnableAutoScale Checked%EnableAutoScale%,     启用全自动识别（推荐）
Gui, Start: Add, CheckBox, Xp Yp+33 +BackgroundTrans vEnableOcclusion Checked%EnableOcclusion%,     启用可隐藏光标（实验）
Gui, Start: Add, CheckBox, Xp Yp+33 +BackgroundTrans vEnableRestriction Checked%EnableRestriction%, 启用限制性光标（推荐）
Gui, Start: Add, Text, Xm+18 Yp+39 +BackgroundTrans ; 控距
Gui, Start: Add, GroupBox, W333 H222,                                                                高级 Advance
Gui, Start: Font, s9, 新宋体
Gui, Start: Add, Text, Xp+18 Yp+18 +BackgroundTrans ; 集体缩进
Gui, Start: Add, Text, Xp Yp+15 +BackgroundTrans, 正常战斗状态识别容错率1
Gui, Start: Add, Slider, Xp+159 Yp +BackgroundTrans Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_Combat_Normal_Percentage1, %FaultTolerance_Combat_Normal_Percentage1%
Gui, Start: Add, Text, Xp-159 Yp+33 +BackgroundTrans, 正常战斗状态识别容错率2
Gui, Start: Add, Slider, Xp+159 Yp +BackgroundTrans Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_Combat_Normal_Percentage2, %FaultTolerance_Combat_Normal_Percentage2%
Gui, Start: Add, Text, Xp-159 Yp+33 +BackgroundTrans, 特殊战斗状态识别容错率2
Gui, Start: Add, Slider, Xp+159 Yp +BackgroundTrans Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_Combat_Endangered_Percentage1, %FaultTolerance_Combat_Endangered_Percentage1%
Gui, Start: Add, Text, Xp-159 Yp+33 +BackgroundTrans, 特殊战斗状态识别容错率2
Gui, Start: Add, Slider, Xp+159 Yp +BackgroundTrans Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_Combat_Endangered_Percentage2, %FaultTolerance_Combat_Endangered_Percentage2%
Gui, Start: Add, Text, Xp-159 Yp+33 +BackgroundTrans, 往世乐土大厅识别容错率2
Gui, Start: Add, Slider, Xp+159 Yp +BackgroundTrans Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_Elysium_Percentage1, %FaultTolerance_Elysium_Percentage1%
Gui, Start: Add, Text, Xp-159 Yp+33 +BackgroundTrans, 往世乐土大厅识别容错率2
Gui, Start: Add, Slider, Xp+159 Yp +BackgroundTrans Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_Elysium_Percentage2, %FaultTolerance_Elysium_Percentage2%
Gui, Start: Font, s12, 新宋体


Gui, Start: Tab, 设置
Gui, Start: Add, Text, Xm+18 Ym+18 +BackgroundTrans ; 控距
Gui, Start: Add, GroupBox, W333 H78,                                             配置 Config
Gui, Start: Add, Text, Xp+18 Yp+18 +BackgroundTrans ; 集体缩进
Gui, Start: Add, Radio, Xp Yp+15 +BackgroundTrans gConfigReset,                  重置为默认配置
Gui, Start: Add, Text, Xm+18 Yp+39 +BackgroundTrans ; 控距
Gui, Start: Add, GroupBox, W333 H150,                                            更新 Update
Gui, Start: Add, Text, Xp+18 Yp+18 +BackgroundTrans ; 集体缩进
Gui, Start: Add, Link, Xp Yp+15 +BackgroundTrans,        百度云:                 <a href="https://pan.baidu.com/s/1KK1B-r-hx_s3yTRl_h_oOg">提取码:2022</a>
Gui, Start: Add, Link, Xp Yp+33 +BackgroundTrans,        Github:                 <a href="https://github.com/Spartan711/Genshin-to-Honkai-PC-Control-Project/releases">New Release</a>
Gui, Start: Add, Text, Xp Yp+33 +BackgroundTrans,        版本日志:
Gui, Start: Add, DDL, Xp+192 Yp W87 +BackgroundTrans gSelectVersion vVersion, v0.3.+|v0.2.+|v0.1.+
Gui, Start: Add, Text, Xp+18 Yp+18 +BackgroundTrans ; 集体缩进


Gui, Start: Tab
Gui, Start: Add, Button, Default W366, 开启
Gui, Start: Add, Button, W366, 退出
Gui, Start: Show, xCenter yCenter, 启动界面
Disable( )
Suspend, On
Return


;【例程 Gosub】
ConfigReset:
MsgBox, 4, 询问, 是否确认对当前配置进行重置？
IfMsgBox, Yes
{
    IfExist, %INI_DIR%
    {
        Try
        {
            FileSetAttrib, -R, %INI_DIR%
        }
        FileDelete, %INI_DIR%
    }
    /*
    对variable的百分号进行转义后会在compile时报错:
    FileInstall, Config\Preset_Keyboard\BH3_Hotkey_`%Version`%.ini, %INI_DIR%, 1
    */
    FileInstall, Config\Preset_Keyboard\BH3_Hotkey_0.3.9.ini, %INI_DIR%, 1
    MsgBox, 0, 提示, 已成功载入默认配置
    Reload
}
Else
    Reload
Return


;【例程 Gosub】“版本”选项的执行语句
SelectVersion:
GuiControlGet, Version
Switch Version
{
    Case "v0.3.+":
        FileInstall, GUI\Changelogs\v0.3.+.txt, %Changelog_DIR3%, 1
        Run, open %Changelog_DIR3%
    Case "v0.2.+":
        FileInstall, GUI\Changelogs\v0.2.+.txt, %Changelog_DIR2%, 1
        Run, open %Changelog_DIR2%
    Case "v0.1.+":
        FileInstall, GUI\Changelogs\v0.1.+.txt, %Changelog_DIR1%, 1
        Run, open %Changelog_DIR1%
}
Return


;【标签 Label】“开启”按钮的执行语句
StartButton开启:

Gui, Submit

;【配置 INI】写入配置
IniWrite, %Key_MainSkill1%, %INI_DIR%, Key Maps, 必杀技1
IniWrite, %Key_MainSkill2%, %INI_DIR%, Key Maps, 必杀技2
IniWrite, %Key_SecondSkill1%, %INI_DIR%, Key Maps, 武器技/后崩技1
IniWrite, %Key_SecondSkill2%, %INI_DIR%, Key Maps, 武器技/后崩技2
IniWrite, %Key_DollSkill1%, %INI_DIR%, Key Maps, 人偶技/月之环1
IniWrite, %Key_DollSkill2%, %INI_DIR%, Key Maps, 人偶技/月之环2
IniWrite, %Key_Dodging1%, %INI_DIR%, Key Maps, 闪避1
IniWrite, %Key_Dodging2%, %INI_DIR%, Key Maps, 闪避2
IniWrite, %Key_NormalAttack1%, %INI_DIR%, Key Maps, 普攻1
IniWrite, %Key_NormalAttack2%, %INI_DIR%, Key Maps, 普攻2
;IniWrite, Key_LeftClick, %INI_DIR%, Key Maps, 正常点击
IniWrite, %Key_ViewControl1%, %INI_DIR%, Key Maps, 管理视角跟随1
IniWrite, %Key_ViewControl2%, %INI_DIR%, Key Maps, 管理视角跟随2
IniWrite, %Key_Suspend1%, %INI_DIR%, Key Maps, 暂停/启用1
IniWrite, %Key_Suspend2%, %INI_DIR%, Key Maps, 暂停/启用2
IniWrite, %Key_SurfaceCheck1%, %INI_DIR%, Key Maps, 调出界面1
IniWrite, %Key_SurfaceCheck2%, %INI_DIR%, Key Maps, 调出界面2

IniWrite, %RunAsAdmin%, %INI_DIR%, CheckBox, 管理员权限
IniWrite, %EnableAutoScale%, %INI_DIR%, CheckBox, 全自动识别
IniWrite, %EnableOcclusion%, %INI_DIR%, CheckBox, 可隐藏光标
IniWrite, %EnableRestriction%, %INI_DIR%, CheckBox, 限制性光标

IniWrite, %FaultTolerance_Combat_Normal_Percentage1%, %INI_DIR%, Slider, 正常战斗状态识别容错率1
IniWrite, %FaultTolerance_Combat_Normal_Percentage2%, %INI_DIR%, Slider, 正常战斗状态识别容错率2
IniWrite, %FaultTolerance_Combat_Endangered_Percentage1%, %INI_DIR%, Slider, 特殊战斗状态识别容错率1
IniWrite, %FaultTolerance_Combat_Endangered_Percentage2%, %INI_DIR%, Slider, 特殊战斗状态识别容错率2
IniWrite, %FaultTolerance_Elysium_Percentage1%, %INI_DIR%, Slider, 往世乐土大厅识别容错率1
IniWrite, %FaultTolerance_Elysium_Percentage2%, %INI_DIR%, Slider, 往世乐土大厅识别容错率2

Gui, Start: Destroy

;【热键 Hotkey】重定义热键到标签
Loop, 2
{
    If (Key_MainSkill%A_Index% != "")
    {
        Key_MainSkill = % Key_MainSkill%A_Index%
        Hotkey, %Key_MainSkill%, Key_MainSkill
    }
    If (Key_SecondSkill%A_Index% != "")
    {
        Key_SecondSkill = % Key_SecondSkill%A_Index%
        Hotkey, %Key_SecondSkill%, Key_SecondSkill
    }
    If (Key_DollSkill%A_Index% != "")
    {
        Key_DollSkill = % Key_DollSkill%A_Index%
        Hotkey, %Key_DollSkill%, Key_DollSkill
    }
    If (Key_Dodging%A_Index% != "")
    {
        Key_Dodging = % Key_Dodging%A_Index%
        Hotkey, %Key_Dodging%, Key_Dodging
    }
    If (Key_NormalAttack%A_Index% != "")
    {
        Key_NormalAttack = % Key_NormalAttack%A_Index%
        Hotkey, %Key_NormalAttack%, Key_NormalAttack
    }
    ;Hotkey, %Key_LeftClick%, Key_LeftClick
    If (Key_ViewControl%A_Index% != "")
    {
        Key_ViewControl = % Key_ViewControl%A_Index%
        Hotkey, %Key_ViewControl%, Key_ViewControl
    }
    If (Key_Suspend%A_Index% != "")
    {
        Key_Suspend = % Key_Suspend%A_Index%
        Hotkey, %Key_Suspend%, Key_Suspend
    }
    If (Key_SurfaceCheck%A_Index% != "")
    {
        Key_SurfaceCheck = % Key_SurfaceCheck%A_Index%
        Hotkey, %Key_SurfaceCheck%, Key_SurfaceCheck
    }
}

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
        SetTimer, AutoScale, %Timer_AutoScale%
    }
    Else
    {
        MsgBox, 0, 警告, 检测到参数异常，即将退出程序
        ExitApp
    }
}
If (EnableOcclusion)
{
    If (!Toggle_Occlusion)
    {
        Toggle_Occlusion := !Toggle_Occlusion
    }
    Else
    {
        MsgBox, 0, 警告, 检测到参数异常，即将退出程序
        ExitApp
    }
}
If (EnableRestriction)
{
    If (!Toggle_Restriction)
    {
        Toggle_Restriction := !Toggle_Restriction
    }
    Else
    {
        MsgBox, 0, 警告, 检测到参数异常，即将退出程序
        ExitApp
    }
}

SetTimer, AutoFadeMsgbox, -3000 ; [可调校数值 adjustable parameters] 使消息弹窗仅存在一段时间(ms)
MsgBox, 0, 提示, 程序启动成功(/≧▽≦)/，祝游戏愉快！`n（当前对话框将于3秒后自动消失）
SetTimer, AutoFadeMsgbox, Delete
Suspend, Off
Return


;【标签 Label】让对话框自动消失
AutoFadeMsgbox:
DLLCall("AnimateWindow", UInt, WinExist("提示 ahk_class #32770"), Int, 500, UInt, 0x90000)
Return


;【标签 Label】“退出”按钮的执行语句
StartButton退出:
If WinExist("ahk_exe BH3.exe")
{
    MsgBox, 4, 询问, 检测到崩坏3正在运行\(≧□≦)/，真的要退出吗？
    IfMsgBox, Yes
        ExitApp
}
Else
{
    MsgBox, 4, 询问, 是否确认退出当前程序(・-・*)？
    IfMsgBox, Yes
        ExitApp
}
Return


;【标签 Label】
Config_Check:
IfNotExist, %INI_DIR%
{
    MsgBox, 0, 提示, 未找到配置文件，请先运行程序
}
Else
    Run, open %INI_DIR%
Return


;【标签 Label】
Config_Delete:
IfNotExist, %INI_DIR%
{
    MsgBox, 0, 提示, 未找到配置文件，请先运行程序
}
Else
{
    Try
    {
        FileSetAttrib, -R, %INI_DIR%
    }
    FileDelete, %INI_DIR%
    MsgBox, 0, 提示, 已成功移除配置文件
}
Return

/*
【标签 Label】
Debug:
OutputDebug, Text
Return
*/

;【标签 Label】
Nothing:
Return


;【标签 Label】
Menu_Reload:
Reload
Return


;【标签 Label】
Menu_Exit:
SplitPath, A_AhkPath, AHK_name
exe := A_IsCompiled ? A_ScriptName : AHK_name
Run, %ComSpec% /c taskkill /f /IM %exe%, , Hide
Return


;---------------------------------------------------------------------------------------------------------------------------------------------------------------