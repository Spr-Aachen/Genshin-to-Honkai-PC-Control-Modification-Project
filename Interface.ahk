;---------------------------------------------------------------------------------------------------------------------------------------------------------------
; 这里用于存放界面功能相关的代码
;---------------------------------------------------------------------------------------------------------------------------------------------------------------


Global ForceToOverwrite := False ; Turn it to "True" for config overwriting.


;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【函数 Function】禁用关闭按钮
DisableButtonX()
{
    WinGet, id, ID, A
    menu := DLLCall("user32/GetSystemMenu", "UInt", id, "UInt", 0)
    DLLCall("user32/DeleteMenu", "UInt", menu, "UInt", 0xF060, "UInt", 0x0)
    WinGetPos ,x, y, w, h, ahk_id %id%
    WinMove, ahk_id %id%,, %x%, %y%, %w%, % h-1
    WinMove, ahk_id %id%,, %x%, %y%, %w%, % h+1
}


;【函数 Function】对话框自动消失
AutoFadeMsgbox()
{
    DLLCall("AnimateWindow", UInt, WinExist("ahk_class #32770"), Int, 500, UInt, 0x90000)
}


;【函数 Function】终止进程
ForceQuit()
{
    SplitPath, A_AhkPath, AHK_name
    exe := A_IsCompiled ? A_ScriptName : AHK_name
    Run, %ComSpec% /c taskkill /f /IM %exe%, , Hide
}


;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【位置 Path】设定位置
Try
{
    RootDIR = C:/BH3_Hotkey

    FileCreateDir, %RootDIR%

    FileCreateDir, %RootDIR%/Config
    INI_DIR = %RootDIR%/Config/BH3_Hotkey.ini

    FileCreateDir, %RootDIR%/GUI
    FileCreateDir, %RootDIR%/GUI/Changelogs
    Changelog_DIR1 = %RootDIR%/GUI/Changelogs/v0.1.+.txt
    Changelog_DIR2 = %RootDIR%/GUI/Changelogs/v0.2.+.txt
    Changelog_DIR3 = %RootDIR%/GUI/Changelogs/v0.3.+.txt
    Changelog_DIR4 = %RootDIR%/GUI/Changelogs/v0.4.+.txt

    FileCreateDir, %RootDIR%/GUI/Images
    Image_DIR1 = %RootDIR%/GUI/Images/1.png
    Image_DIR2 = %RootDIR%/GUI/Images/2.png
    Image_DIR3 = %RootDIR%/GUI/Images/3.png
    FileInstall, GUI/Images/1.png, %Image_DIR1%, 1
    FileInstall, GUI/Images/2.png, %Image_DIR2%, 1
    FileInstall, GUI/Images/3.png, %Image_DIR3%, 1
}


;【配置 INI】创建配置
Try
    IniRead, TestString, %INI_DIR%, Initial, %执行初始化进程%
Catch
{
    Reload
}
Finally
{
    If (TestString == "ERROR" || ForceToOverwrite == True)
    {
        Try
            RunWait, PowerShell.exe -Command "Get-ChildItem -Path C:/ -Recurse -Filter '*BH3_Hotkey*.ini' | Remove-Item -Force" -Command "Exit", , Hide
        Catch
            MsgBox, 16, Warning, Failed to run Shell!
        /*
        TestString := %已执行%
        IniWrite, %TestString%, %INI_DIR%, Initial, %执行初始化进程%

        IniWrite, Q, %INI_DIR%, Keymaps, %必杀技%1
        IniWrite, %无%, %INI_DIR%, Keymaps, %必杀技%2
        IniWrite, E, %INI_DIR%, Keymaps, %武器技或后崩技%1
        IniWrite, %无%, %INI_DIR%, Keymaps, %武器技或后崩技%2
        IniWrite, Z, %INI_DIR%, Keymaps, %人偶技或月之环%1
        IniWrite, %无%, %INI_DIR%, Keymaps, %人偶技或月之环%2
        IniWrite, LShift, %INI_DIR%, Keymaps, %闪避%1
        IniWrite, RButton, %INI_DIR%, Keymaps, %闪避%2
        IniWrite, %无%, %INI_DIR%, Keymaps, %普攻%1
        IniWrite, LButton, %INI_DIR%, Keymaps, %普攻%2
        ;IniWrite, LAlt + LButton, %INI_DIR%, Keymaps, 正常点击
        IniWrite, %无%, %INI_DIR%, Keymaps, %管理鼠标功能%1
        IniWrite, MButton, %INI_DIR%, Keymaps, %管理鼠标功能%2
        IniWrite, F1, %INI_DIR%, Keymaps, %暂停或启用%1
        IniWrite, %无%, %INI_DIR%, Keymaps, %暂停或启用%2
        IniWrite, F3, %INI_DIR%, Keymaps, %重启%1
        IniWrite, %无%, %INI_DIR%, Keymaps, %重启%2

        IniWrite, 1, %INI_DIR%, Options, %管理员权限% ; Checked by default
        IniWrite, 1, %INI_DIR%, Options, %全自动识别% ; Checked by default
        IniWrite, 1, %INI_DIR%, Options, %可隐藏光标% ; Checked by default
        IniWrite, 1, %INI_DIR%, Options, %限制性光标% ; Checked by default

        IniWrite, 1, %INI_DIR%, Params, %正常战斗状态识别容错率_目标%
        IniWrite, 1, %INI_DIR%, Params, %正常战斗状态识别容错率_背景%
        IniWrite, 3, %INI_DIR%, Params, %濒危战斗状态识别容错率_目标%
        IniWrite, 3, %INI_DIR%, Params, %濒危战斗状态识别容错率_背景%
        IniWrite, 1, %INI_DIR%, Params, %往世乐土大厅识别容错率_目标%
        IniWrite, 1, %INI_DIR%, Params, %往世乐土大厅识别容错率_背景%
        */
        FileInstall, Config/Preset_Keyboard/BH3_Hotkey.ini, %INI_DIR%, 1
    }
    Try ;IfExist, %INI_DIR%
    {
        IniRead, Key_MainSkill1, %INI_DIR%, Keymaps, %必杀技%1
        IniRead, Key_MainSkill2, %INI_DIR%, Keymaps, %必杀技%2
        IniRead, Key_SecondSkill1, %INI_DIR%, Keymaps, %武器技或后崩技%1
        IniRead, Key_SecondSkill2, %INI_DIR%, Keymaps, %武器技或后崩技%2
        IniRead, Key_DollSkill1, %INI_DIR%, Keymaps, %人偶技或月之环%1
        IniRead, Key_DollSkill2, %INI_DIR%, Keymaps, %人偶技或月之环%2
        IniRead, Key_Dodging1, %INI_DIR%, Keymaps, %闪避%1
        IniRead, Key_Dodging2, %INI_DIR%, Keymaps, %闪避%2
        IniRead, Key_NormalAttack1, %INI_DIR%, Keymaps, %普攻%1
        IniRead, Key_NormalAttack2, %INI_DIR%, Keymaps, %普攻%2
        ;IniRead, Key_LeftClick, %INI_DIR%, Keymaps, 正常点击
        IniRead, Key_MouseFunction1, %INI_DIR%, Keymaps, %管理鼠标功能%1
        IniRead, Key_MouseFunction2, %INI_DIR%, Keymaps, %管理鼠标功能%2
        IniRead, Key_Suspend1, %INI_DIR%, Keymaps, %暂停或启用%1
        IniRead, Key_Suspend2, %INI_DIR%, Keymaps, %暂停或启用%2
        IniRead, Key_Reload1, %INI_DIR%, Keymaps, %重启%1
        IniRead, Key_Reload2, %INI_DIR%, Keymaps, %重启%2

        IniRead, RunAsAdmin, %INI_DIR%, Options, %管理员权限%
        IniRead, EnableAutoScale, %INI_DIR%, Options, %全自动识别%
        IniRead, EnableOcclusion, %INI_DIR%, Options, %可隐藏光标%
        IniRead, EnableRestriction, %INI_DIR%, Options, %限制性光标%

        IniRead, FaultTolerance_CombatScene_Normal_T_Percentage, %INI_DIR%, Params, %正常战斗状态识别容错率_目标%
        IniRead, FaultTolerance_CombatScene_Normal_B_Percentage, %INI_DIR%, Params, %正常战斗状态识别容错率_背景%
        IniRead, FaultTolerance_CombatScene_LowHealth_T_Percentage, %INI_DIR%, Params, %濒危战斗状态识别容错率_目标%
        IniRead, FaultTolerance_CombatScene_LowHealth_B_Percentage, %INI_DIR%, Params, %濒危战斗状态识别容错率_背景%
        IniRead, FaultTolerance_ElysiumLobby_T_Percentage, %INI_DIR%, Params, %往世乐土大厅识别容错率_目标%
        IniRead, FaultTolerance_ElysiumLobby_B_Percentage, %INI_DIR%, Params, %往世乐土大厅识别容错率_背景%
    }
    Finally
    {
        ; Not working with dict
        /*
        Dict := {"MouseKey1": "LButton", "MouseKey2": "MButton", "MouseKey3": "RButton", "MouseKey4": %无%}
        Counter := 0
        For Key, Value in Dict
        {
            Counter += 1
            If (Key_MainSkill2 == "%Value%")
                Key_MainSkill2_DDL := %Counter%
            If (Key_SecondSkill2 == "%Value%")
                Key_SecondSkill2_DDL := %Counter%
            If (Key_DollSkill2 == "%Value%")
                Key_DollSkill2_DDL := %Counter%
            If (Key_Dodging2 == "%Value%")
                Key_Dodging2_DDL := %Counter%
            If (Key_NormalAttack2 == "%Value%")
                Key_NormalAttack2_DDL := %Counter%
            If (Key_MouseFunction2 == "%Value%")
                Key_MouseFunction2_DDL := %Counter%
            If (Key_Suspend2 == "%Value%")
                Key_Suspend2_DDL := %Counter%
            If (Key_Reload2 == "%Value%")
                Key_Reload2_DDL := %Counter%
        }
        */
        ; But works with list
        List := ["LButton", "MButton", "RButton", %无%]
        Loop % List.Length()
        {
            If (Key_MainSkill2 == List[A_Index])
                Key_MainSkill2_DDL := A_Index
            If (Key_SecondSkill2 == List[A_Index])
                Key_SecondSkill2_DDL := A_Index
            If (Key_DollSkill2 == List[A_Index])
                Key_DollSkill2_DDL := A_Index
            If (Key_Dodging2 == List[A_Index])
                Key_Dodging2_DDL := A_Index
            If (Key_NormalAttack2 == List[A_Index])
                Key_NormalAttack2_DDL := A_Index
            If (Key_MouseFunction2 == List[A_Index])
                Key_MouseFunction2_DDL := A_Index
            If (Key_Suspend2 == List[A_Index])
                Key_Suspend2_DDL := A_Index
            If (Key_Reload2 == List[A_Index])
                Key_Reload2_DDL := A_Index
        }
    }
}


;【菜单 Menu】托盘菜单
Menu, Tray, NoStandard ; 删除原有托盘菜单

Menu, Else, Add, %查看配置文件%, Config_Check
Menu, Else, Add, %删除配置文件%, Config_Delete
;Menu, Else, Add, 调试日志, Debug
Menu, Else, Add, %敬请期待%, Nothing

Menu, Tray, Add, %其它%, :Else
Menu, Tray, Add, %重启%, Menu_Reload
Menu, Tray, Add, %退出%, Menu_Exit

;【界面 GUI】说明界面
;Gui, Start: Color, FFFFFF
Gui, Start: +LastFound
WinSet, TransColor, FEFFFF 222 ; WinSet, Transparent, 222
Gui, Start: Font, s12, 新宋体
Gui, Start: Add, Tab3, , %键位%|%功能%|%设置%

Gui, Start: Tab, %键位%
Gui, Start: Add, Text, Xm+18 Ym+18 ; 控距
Gui, Start: Add, GroupBox, W333 H210,                                                                            战斗 Combat
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Text, Xp Yp+15,                                        :                       %必杀技%
Gui, Start: Add, Hotkey, Xp Yp W84 vKey_MainSkill1,                                             %Key_MainSkill1%
Gui, Start: Add, Text, Xp+87 Yp, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 vKey_MainSkill2 Choose%Key_MainSkill2_DDL%,         LButton|MButton|RButton|%无%
Gui, Start: Add, Text, Xp-99 Yp+33,                                     :                       %武器技或后崩技%
Gui, Start: Add, Hotkey, Xp Yp W84 vKey_SecondSkill1,                                           %Key_SecondSkill1%
Gui, Start: Add, Text, Xp+87 Yp, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 vKey_SecondSkill2 Choose%Key_SecondSkill2_DDL%,     LButton|MButton|RButton|%无%
Gui, Start: Add, Text, Xp-99 Yp+33,                                     :                       %人偶技或月之环%
Gui, Start: Add, Hotkey, Xp Yp W84 vKey_DollSkill1,                                             %Key_DollSkill1%
Gui, Start: Add, Text, Xp+87 Yp, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 vKey_DollSkill2 Choose%Key_DollSkill2_DDL%,         LButton|MButton|RButton|%无%
Gui, Start: Add, Text, Xp-99 Yp+33,                                     :                       %闪避%
Gui, Start: Add, Hotkey, Xp Yp W84 vKey_Dodging1,                                               %Key_Dodging1%
Gui, Start: Add, Text, Xp+87 Yp, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 vKey_Dodging2 Choose%Key_Dodging2_DDL%,             LButton|MButton|RButton|%无%
Gui, Start: Add, Text, Xp-99 Yp+33,                                     :                       %普攻%
Gui, Start: Add, Hotkey, Xp Yp W84 vKey_NormalAttack1,                                          %Key_NormalAttack1%
Gui, Start: Add, Text, Xp+87 Yp, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 vKey_NormalAttack2 Choose%Key_NormalAttack2_DDL%,   LButton|MButton|RButton|%无%
Gui, Start: Add, Text, Xm+18 Yp+39 ; 控距
Gui, Start: Add, GroupBox, W333 H177,                                                                            其它 Others
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Text, Xp Yp+15,                                                                %左Alt加左键_正常点击%
;Gui, Start: Add, Hotkey, Xp Yp W84 vKey_LeftClick,                                                              %Key_LeftClick%
Gui, Start: Add, Text, Xp Yp+33,                                        :                       %管理鼠标功能%
Gui, Start: Add, Hotkey, Xp Yp W84 vKey_MouseFunction1,                                         %Key_MouseFunction1%
Gui, Start: Add, Text, Xp+87 Yp, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 vKey_MouseFunction2 Choose%Key_MouseFunction2_DDL%, LButton|MButton|RButton|%无%
Gui, Start: Add, Text, Xp-99 Yp+33,                                     :                       %暂停或启用%
Gui, Start: Add, Hotkey, Xp Yp W84 vKey_Suspend1,                                               %Key_Suspend1%
Gui, Start: Add, Text, Xp+87 Yp, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 vKey_Suspend2 Choose%Key_Suspend2_DDL%,             LButton|MButton|RButton|%无%
Gui, Start: Add, Text, Xp-99 Yp+33,                                     :                       %重启%
Gui, Start: Add, Hotkey, Xp Yp W84 vKey_Reload1,                                                %Key_Reload1%
Gui, Start: Add, Text, Xp+87 Yp, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 vKey_Reload2 Choose%Key_Reload2_DDL%,               LButton|MButton|RButton|%无%
;Gui, Start: Add, Text, Xm+18 Yp+39 ; 控距
Gui, Start: Add, Picture, Xm+63 Ym+72 W234 H351 +BackgroundTrans, %Image_DIR1%

Gui, Start: Tab, %功能%
Gui, Start: Add, Text, Xm+18 Ym+18 ; 控距
Gui, Start: Add, GroupBox, W333 H174,                                                                            选项 Options
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, CheckBox, Xp Yp+15 vRunAsAdmin Checked%RunAsAdmin%,                            %启用%%管理员权限%%注_推荐%
Gui, Start: Add, CheckBox, Xp Yp+33 vEnableAutoScale Checked%EnableAutoScale%,                  %启用%%全自动识别%%注_推荐%
Gui, Start: Add, CheckBox, Xp Yp+33 vEnableOcclusion Checked%EnableOcclusion%,                  %启用%%可隐藏光标%%注_推荐%
Gui, Start: Add, CheckBox, Xp Yp+33 vEnableRestriction Checked%EnableRestriction%,              %启用%%限制性光标%%注_推荐%
Gui, Start: Add, Text, Xm+18 Yp+39 ; 控距
Gui, Start: Add, GroupBox, W333 H222,                                                                            高级 Advance
Gui, Start: Font, s9, 新宋体
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Text, Xp Yp+15,                                                                                                 %正常战斗状态识别容错率_目标%
Gui, Start: Add, Slider, Xp+159 Yp Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_CombatScene_Normal_T_Percentage,     %FaultTolerance_CombatScene_Normal_T_Percentage%
Gui, Start: Add, Text, Xp-159 Yp+33,                                                                                             %正常战斗状态识别容错率_背景%
Gui, Start: Add, Slider, Xp+159 Yp Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_CombatScene_Normal_B_Percentage,     %FaultTolerance_CombatScene_Normal_B_Percentage%
Gui, Start: Add, Text, Xp-159 Yp+33,                                                                                             %濒危战斗状态识别容错率_目标%
Gui, Start: Add, Slider, Xp+159 Yp Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_CombatScene_LowHealth_T_Percentage, %FaultTolerance_CombatScene_LowHealth_T_Percentage%
Gui, Start: Add, Text, Xp-159 Yp+33,                                                                                             %濒危战斗状态识别容错率_背景%
Gui, Start: Add, Slider, Xp+159 Yp Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_CombatScene_LowHealth_B_Percentage, %FaultTolerance_CombatScene_LowHealth_B_Percentage%
Gui, Start: Add, Text, Xp-159 Yp+33,                                                                                             %往世乐土大厅识别容错率_目标%
Gui, Start: Add, Slider, Xp+159 Yp Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_ElysiumLobby_T_Percentage,           %FaultTolerance_ElysiumLobby_T_Percentage%
Gui, Start: Add, Text, Xp-159 Yp+33,                                                                                             %往世乐土大厅识别容错率_背景%
Gui, Start: Add, Slider, Xp+159 Yp Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_ElysiumLobby_B_Percentage,           %FaultTolerance_ElysiumLobby_B_Percentage%
Gui, Start: Font, s12, 新宋体
Gui, Start: Add, Picture, Xm+57 Ym+72 W258 H351 +BackgroundTrans, %Image_DIR2%

Gui, Start: Tab, %设置%
Gui, Start: Add, Text, Xm+18 Ym+18 ; 控距
Gui, Start: Add, GroupBox, W333 H78,                                              配置 Config
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Radio, Xp Yp+15 gConfig_Import,                 %载入配置预设%
Gui, Start: Add, Text, Xm+18 Yp+39 ; 控距
Gui, Start: Add, GroupBox, W333 H177,                                             更新 Update
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Radio, Xp Yp+15 gUpdateCheck,                   %检查版本更新%
Gui, Start: Add, Link, Xp Yp+33,         [URL] 百度云:           <a href="https://pan.baidu.com/s/1KK1B-r-hx_s3yTRl_h_oOg">提取码:2022</a>
Gui, Start: Add, Link, Xp Yp+33,         [URL] Github:           <a href="https://github.com/Spartan711/Genshin-to-Honkai-PC-Control-Project/releases">New Release</a>
Gui, Start: Add, Text, Xp Yp+33,                                 %查看更新日志%:
Gui, Start: Add, DDL, Xp+192 Yp W87 gSelectVersion vVersion,     %A_Space%||v0.4.+|v0.3.+|v0.2.+|v0.1.+
Gui, Start: Add, Text, Xm+18 Yp+39 ; 控距
Gui, Start: Add, GroupBox, W333 H111,                                             其它 Others
;Gui, Start: Add, Text, Xm+18 Yp+39 ; 控距
Gui, Start: Add, Picture, Xm+72 Ym+72 W204 H351 +BackgroundTrans, %Image_DIR3%

Gui, Start: Tab
Gui, Start: Add, Button, Default W366 gClickToRun, %开启%
Gui, Start: Add, Button,         W366 gClickToExit, %退出%
Gui, Start: Show, xCenter yCenter, %启动界面%
DisableButtonX()
Suspend, On
Return


;【标签 Label】
Config_Import:
MsgBox, 0x24, %询问%, %操作将覆盖当前的配置_是否继续%
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
    Gui, Presets: Add, Button, W33, %载入键鼠预设%
    Gui, Presets: Add, Button, W33, %载入手柄预设%
    /*
    对variable的百分号进行转义后会在compile时报错:
    FileInstall, Config/Preset_Keyboard/BH3_Hotkey_`%Version`%.ini, %INI_DIR%, 1
    故不再采用这种命名方式
    */
    FileInstall, Config/Preset_Keyboard/BH3_Hotkey.ini, %INI_DIR%, 1
    MsgBox, 0, %提示%, %已成功载入预设%
    Reload
}
Else
    Reload
Return


;【标签 Label】
UpdateCheck:
Updater()
Return


;【标签 Label】
SelectVersion:
GuiControlGet, Version
Switch Version
{
    Case "v0.4.+":
        FileInstall, GUI/Changelogs/v0.4.+.txt, %Changelog_DIR4%, 1
        Run, open %Changelog_DIR4%
    Case "v0.3.+":
        FileInstall, GUI/Changelogs/v0.3.+.txt, %Changelog_DIR3%, 1
        Run, open %Changelog_DIR3%
    Case "v0.2.+":
        FileInstall, GUI/Changelogs/v0.2.+.txt, %Changelog_DIR2%, 1
        Run, open %Changelog_DIR2%
    Case "v0.1.+":
        FileInstall, GUI/Changelogs/v0.1.+.txt, %Changelog_DIR1%, 1
        Run, open %Changelog_DIR1%
    Default : ;Case "":
        Return
}
Return


;【标签 Label】“开启”按钮的执行语句
ClickToRun: ;StartButton%开启%:

Gui, Start: Submit ;Gui, Submit

;【配置 INI】写入配置
IniWrite, %Key_MainSkill1%, %INI_DIR%, Keymaps, %必杀技%1
IniWrite, %Key_MainSkill2%, %INI_DIR%, Keymaps, %必杀技%2
IniWrite, %Key_SecondSkill1%, %INI_DIR%, Keymaps, %武器技或后崩技%1
IniWrite, %Key_SecondSkill2%, %INI_DIR%, Keymaps, %武器技或后崩技%2
IniWrite, %Key_DollSkill1%, %INI_DIR%, Keymaps, %人偶技或月之环%1
IniWrite, %Key_DollSkill2%, %INI_DIR%, Keymaps, %人偶技或月之环%2
IniWrite, %Key_Dodging1%, %INI_DIR%, Keymaps, %闪避%1
IniWrite, %Key_Dodging2%, %INI_DIR%, Keymaps, %闪避%2
IniWrite, %Key_NormalAttack1%, %INI_DIR%, Keymaps, %普攻%1
IniWrite, %Key_NormalAttack2%, %INI_DIR%, Keymaps, %普攻%2
;IniWrite, Key_LeftClick, %INI_DIR%, Keymaps, 正常点击
IniWrite, %Key_MouseFunction1%, %INI_DIR%, Keymaps, %管理鼠标功能%1
IniWrite, %Key_MouseFunction2%, %INI_DIR%, Keymaps, %管理鼠标功能%2
IniWrite, %Key_Suspend1%, %INI_DIR%, Keymaps, %暂停或启用%1
IniWrite, %Key_Suspend2%, %INI_DIR%, Keymaps, %暂停或启用%2
IniWrite, %Key_Reload1%, %INI_DIR%, Keymaps, %重启%1
IniWrite, %Key_Reload2%, %INI_DIR%, Keymaps, %重启%2

IniWrite, %RunAsAdmin%, %INI_DIR%, Options, %管理员权限%
IniWrite, %EnableAutoScale%, %INI_DIR%, Options, %全自动识别%
IniWrite, %EnableOcclusion%, %INI_DIR%, Options, %可隐藏光标%
IniWrite, %EnableRestriction%, %INI_DIR%, Options, %限制性光标%

IniWrite, %FaultTolerance_CombatScene_Normal_T_Percentage%, %INI_DIR%, Params, %正常战斗状态识别容错率_目标%
IniWrite, %FaultTolerance_CombatScene_Normal_B_Percentage%, %INI_DIR%, Params, %正常战斗状态识别容错率_背景%
IniWrite, %FaultTolerance_CombatScene_LowHealth_T_Percentage%, %INI_DIR%, Params, %濒危战斗状态识别容错率_目标%
IniWrite, %FaultTolerance_CombatScene_LowHealth_B_Percentage%, %INI_DIR%, Params, %濒危战斗状态识别容错率_背景%
IniWrite, %FaultTolerance_ElysiumLobby_T_Percentage%, %INI_DIR%, Params, %往世乐土大厅识别容错率_目标%
IniWrite, %FaultTolerance_ElysiumLobby_B_Percentage%, %INI_DIR%, Params, %往世乐土大厅识别容错率_背景%

Gui, Start: Destroy

;【热键 Hotkey】重定义热键到标签
Loop, 2
{
    If (Key_MainSkill%A_Index% != 无 && Key_MainSkill%A_Index% != "")
    {
        Key_MainSkill = % Key_MainSkill%A_Index%
        Hotkey, %Key_MainSkill%, Key_MainSkill
    }
    If (Key_SecondSkill%A_Index% != 无 && Key_SecondSkill%A_Index% != "")
    {
        Key_SecondSkill = % Key_SecondSkill%A_Index%
        Hotkey, %Key_SecondSkill%, Key_SecondSkill
    }
    If (Key_DollSkill%A_Index% != 无 && Key_DollSkill%A_Index% != "")
    {
        Key_DollSkill = % Key_DollSkill%A_Index%
        Hotkey, %Key_DollSkill%, Key_DollSkill
    }
    If (Key_Dodging%A_Index% != 无 && Key_Dodging%A_Index% != "")
    {
        Key_Dodging = % Key_Dodging%A_Index%
        Hotkey, %Key_Dodging%, Key_Dodging
    }
    If (Key_NormalAttack%A_Index% != 无 && Key_NormalAttack%A_Index% != "")
    {
        Key_NormalAttack = % Key_NormalAttack%A_Index%
        Hotkey, %Key_NormalAttack%, Key_NormalAttack
    }
    ;Hotkey, %Key_LeftClick%, Key_LeftClick
    If (Key_MouseFunction%A_Index% != 无 && Key_MouseFunction%A_Index% != "")
    {
        Key_MouseFunction = % Key_MouseFunction%A_Index%
        Hotkey, %Key_MouseFunction%, Key_MouseFunction
    }
    If (Key_Suspend%A_Index% != 无 && Key_Suspend%A_Index% != "")
    {
        Key_Suspend = % Key_Suspend%A_Index%
        Hotkey, %Key_Suspend%, Key_Suspend
    }
    If (Key_Reload%A_Index% != 无 && Key_Reload%A_Index% != "")
    {
        Key_Reload = % Key_Reload%A_Index%
        Hotkey, %Key_Reload%, Key_Reload
    }
}

If (RunAsAdmin)
{
    FullCommandLine := DllCall("GetCommandLine", "str")
    If Not (A_IsAdmin or RegExMatch(FullCommandLine, " /restart(?!\S)"))
    {
        Try
        {
            If A_IsCompiled
                Run *RunAs "%A_ScriptFullPath%" /restart
            Else
                Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
        }
        ForceQuit() ;ExitApp
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
        MsgBox, 16, %警告%, %检测到参数异常_即将退出程序%
        ForceQuit() ;ExitApp
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
        MsgBox, 16, %警告%, %检测到参数异常_即将退出程序%
        ForceQuit() ;ExitApp
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
        MsgBox, 16, %警告%, %检测到参数异常_即将退出程序%
        ForceQuit() ;ExitApp
    }
}

SetTimer, AutoFadeMsgbox, -3000 ; [可调校数值 adjustable parameters] 使消息弹窗仅存在一段时间(ms)
MsgBox, 0, %提示%, %程序启动成功_祝游戏愉快_当前对话框将于3秒后自动消失%
SetTimer, AutoFadeMsgbox, Delete
Suspend, Off
Return


;【标签 Label】“退出”按钮的执行语句
ClickToExit: ;StartButton%退出%:
If WinExist("ahk_exe BH3.exe")
{
    MsgBox, 0x24, %询问%, %检测到崩坏3正在运行_真的要退出吗%
    IfMsgBox, Yes
        ForceQuit() ;ExitApp
}
Else
{
    MsgBox, 0x24, %询问%, %是否确认退出当前程序%
    IfMsgBox, Yes
        ForceQuit() ;ExitApp
}
Return


;【标签 Label】
Config_Check:
IfNotExist, %INI_DIR%
{
    MsgBox, 0, %提示%, %未找到配置文件_请先运行程序%
}
Else
    Run, open %INI_DIR%
Return


;【标签 Label】
Config_Delete:
IfNotExist, %INI_DIR%
{
    MsgBox, 0, %提示%, %未找到配置文件_请先运行程序%
}
Else
{
    Try
    {
        FileSetAttrib, -R, %INI_DIR%
    }
    FileDelete, %INI_DIR%
    MsgBox, 0, %提示%, %已成功移除配置文件%
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
ForceQuit() ;ExitApp
Return


;---------------------------------------------------------------------------------------------------------------------------------------------------------------