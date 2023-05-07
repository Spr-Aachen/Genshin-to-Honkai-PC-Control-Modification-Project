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
    IniRead, TestString, %INI_DIR%, Initial, %Var_Execute_Initial_Setup%
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
        TestString := %Var_Done%
        IniWrite, %TestString%, %INI_DIR%, Initial, %Var_Execute_Initial_Setup%

        IniWrite, Q, %INI_DIR%, Keymaps, %Var_Main_Skill%1
        IniWrite, %Var_None%, %INI_DIR%, Keymaps, %Var_Main_Skill%2
        IniWrite, E, %INI_DIR%, Keymaps, %Var_Weapon_Skill%1
        IniWrite, %Var_None%, %INI_DIR%, Keymaps, %Var_Weapon_Skill%2
        IniWrite, Z, %INI_DIR%, Keymaps, %Var_Doll_Skill%1
        IniWrite, %Var_None%, %INI_DIR%, Keymaps, %Var_Doll_Skill%2
        IniWrite, LShift, %INI_DIR%, Keymaps, %Var_Dodging%1
        IniWrite, RButton, %INI_DIR%, Keymaps, %Var_Dodging%2
        IniWrite, %Var_None%, %INI_DIR%, Keymaps, %Var_Normal_Attack%1
        IniWrite, LButton, %INI_DIR%, Keymaps, %Var_Normal_Attack%2
        ;IniWrite, LAlt + LButton, %INI_DIR%, Keymaps, 正常点击
        IniWrite, %Var_None%, %INI_DIR%, Keymaps, %Var_View_Control%1
        IniWrite, MButton, %INI_DIR%, Keymaps, %Var_View_Control%2
        IniWrite, F1, %INI_DIR%, Keymaps, %Var_StopOrBegin%1
        IniWrite, %Var_None%, %INI_DIR%, Keymaps, %Var_StopOrBegin%2
        IniWrite, F3, %INI_DIR%, Keymaps, %Var_Reload%1
        IniWrite, %Var_None%, %INI_DIR%, Keymaps, %Var_Reload%2

        IniWrite, 1, %INI_DIR%, Options, %Var_Run_as_Admin% ; Checked by default
        IniWrite, 1, %INI_DIR%, Options, %Var_Auto_Identification% ; Checked by default
        IniWrite, 1, %INI_DIR%, Options, %Var_Cursor_Occlusion% ; Checked by default
        IniWrite, 1, %INI_DIR%, Options, %Var_Cursor_Restriction% ; Checked by default

        IniWrite, 1, %INI_DIR%, Params, %Var_FaultTolerance_CombatScene_Normal_T_Percentage%
        IniWrite, 1, %INI_DIR%, Params, %Var_FaultTolerance_CombatScene_Normal_B_Percentage%
        IniWrite, 3, %INI_DIR%, Params, %Var_FaultTolerance_CombatScene_LowHealth_T_Percentage%
        IniWrite, 3, %INI_DIR%, Params, %Var_FaultTolerance_CombatScene_LowHealth_B_Percentage%
        IniWrite, 1, %INI_DIR%, Params, %Var_FaultTolerance_ElysiumLobby_T_Percentage%
        IniWrite, 1, %INI_DIR%, Params, %Var_FaultTolerance_ElysiumLobby_B_Percentage%
        */
        FileInstall, Config/Preset_Keyboard/BH3_Hotkey.ini, %INI_DIR%, 1
    }
    Try ;IfExist, %INI_DIR%
    {
        IniRead, Key_MainSkill1, %INI_DIR%, Keymaps, %Var_Main_Skill%1
        IniRead, Key_MainSkill2, %INI_DIR%, Keymaps, %Var_Main_Skill%2
        IniRead, Key_SecondSkill1, %INI_DIR%, Keymaps, %Var_Weapon_Skill%1
        IniRead, Key_SecondSkill2, %INI_DIR%, Keymaps, %Var_Weapon_Skill%2
        IniRead, Key_DollSkill1, %INI_DIR%, Keymaps, %Var_Doll_Skill%1
        IniRead, Key_DollSkill2, %INI_DIR%, Keymaps, %Var_Doll_Skill%2
        IniRead, Key_Dodging1, %INI_DIR%, Keymaps, %Var_Dodging%1
        IniRead, Key_Dodging2, %INI_DIR%, Keymaps, %Var_Dodging%2
        IniRead, Key_NormalAttack1, %INI_DIR%, Keymaps, %Var_Normal_Attack%1
        IniRead, Key_NormalAttack2, %INI_DIR%, Keymaps, %Var_Normal_Attack%2
        ;IniRead, Key_LeftClick, %INI_DIR%, Keymaps, 正常点击
        IniRead, Key_MouseFunction1, %INI_DIR%, Keymaps, %Var_View_Control%1
        IniRead, Key_MouseFunction2, %INI_DIR%, Keymaps, %Var_View_Control%2
        IniRead, Key_Suspend1, %INI_DIR%, Keymaps, %Var_StopOrBegin%1
        IniRead, Key_Suspend2, %INI_DIR%, Keymaps, %Var_StopOrBegin%2
        IniRead, Key_Reload1, %INI_DIR%, Keymaps, %Var_Reload%1
        IniRead, Key_Reload2, %INI_DIR%, Keymaps, %Var_Reload%2

        IniRead, RunAsAdmin, %INI_DIR%, Options, %Var_Run_as_Admin%
        IniRead, EnableAutoScale, %INI_DIR%, Options, %Var_Auto_Identification%
        IniRead, EnableOcclusion, %INI_DIR%, Options, %Var_Cursor_Occlusion%
        IniRead, EnableRestriction, %INI_DIR%, Options, %Var_Cursor_Restriction%

        IniRead, FaultTolerance_CombatScene_Normal_T_Percentage, %INI_DIR%, Params, %Var_FaultTolerance_CombatScene_Normal_T_Percentage%
        IniRead, FaultTolerance_CombatScene_Normal_B_Percentage, %INI_DIR%, Params, %Var_FaultTolerance_CombatScene_Normal_B_Percentage%
        IniRead, FaultTolerance_CombatScene_LowHealth_T_Percentage, %INI_DIR%, Params, %Var_FaultTolerance_CombatScene_LowHealth_T_Percentage%
        IniRead, FaultTolerance_CombatScene_LowHealth_B_Percentage, %INI_DIR%, Params, %Var_FaultTolerance_CombatScene_LowHealth_B_Percentage%
        IniRead, FaultTolerance_ElysiumLobby_T_Percentage, %INI_DIR%, Params, %Var_FaultTolerance_ElysiumLobby_T_Percentage%
        IniRead, FaultTolerance_ElysiumLobby_B_Percentage, %INI_DIR%, Params, %Var_FaultTolerance_ElysiumLobby_B_Percentage%
    }
    Finally
    {
        ; Not working with dict
        /*
        Dict := {"MouseKey1": "LButton", "MouseKey2": "MButton", "MouseKey3": "RButton", "MouseKey4": %Var_None%}
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
        List := ["LButton", "MButton", "RButton", %Var_None%]
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

Menu, Else, Add, %Var_Config_Check%, Config_Check
Menu, Else, Add, %Var_Config_Delete%, Config_Delete
;Menu, Else, Add, Var_Debugging_Log, Debug
Menu, Else, Add, %Var_Coming_Soon%, Nothing

Menu, Tray, Add, %Var_Else%, :Else
Menu, Tray, Add, %Var_Reload%, Menu_Reload
Menu, Tray, Add, %Var_Exit%, Menu_Exit

;【界面 GUI】说明界面
;Gui, Start: Color, FFFFFF
Gui, Start: +LastFound
WinSet, TransColor, FEFFFF 222 ; WinSet, Transparent, 222
Gui, Start: Font, s12, 新宋体
Gui, Start: Add, Tab3, , %Var_Keymaps%|%Var_Functions%|%Var_Settings%

Gui, Start: Tab, %Var_Keymaps%
Gui, Start: Add, Text, Xm+18 Ym+18 ; 控距
Gui, Start: Add, GroupBox, W333 H210,                                                                            战斗 Combat
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Text, Xp Yp+15,                                        :                       %Var_Main_Skill%
Gui, Start: Add, Hotkey, Xp Yp W84 vKey_MainSkill1,                                             %Key_MainSkill1%
Gui, Start: Add, Text, Xp+87 Yp, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 vKey_MainSkill2 Choose%Key_MainSkill2_DDL%,         LButton|MButton|RButton|%Var_None%
Gui, Start: Add, Text, Xp-99 Yp+33,                                     :                       %Var_Weapon_Skill%
Gui, Start: Add, Hotkey, Xp Yp W84 vKey_SecondSkill1,                                           %Key_SecondSkill1%
Gui, Start: Add, Text, Xp+87 Yp, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 vKey_SecondSkill2 Choose%Key_SecondSkill2_DDL%,     LButton|MButton|RButton|%Var_None%
Gui, Start: Add, Text, Xp-99 Yp+33,                                     :                       %Var_Doll_Skill%
Gui, Start: Add, Hotkey, Xp Yp W84 vKey_DollSkill1,                                             %Key_DollSkill1%
Gui, Start: Add, Text, Xp+87 Yp, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 vKey_DollSkill2 Choose%Key_DollSkill2_DDL%,         LButton|MButton|RButton|%Var_None%
Gui, Start: Add, Text, Xp-99 Yp+33,                                     :                       %Var_Dodging%
Gui, Start: Add, Hotkey, Xp Yp W84 vKey_Dodging1,                                               %Key_Dodging1%
Gui, Start: Add, Text, Xp+87 Yp, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 vKey_Dodging2 Choose%Key_Dodging2_DDL%,             LButton|MButton|RButton|%Var_None%
Gui, Start: Add, Text, Xp-99 Yp+33,                                     :                       %Var_Normal_Attack%
Gui, Start: Add, Hotkey, Xp Yp W84 vKey_NormalAttack1,                                          %Key_NormalAttack1%
Gui, Start: Add, Text, Xp+87 Yp, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 vKey_NormalAttack2 Choose%Key_NormalAttack2_DDL%,   LButton|MButton|RButton|%Var_None%
Gui, Start: Add, Text, Xm+18 Yp+39 ; 控距
Gui, Start: Add, GroupBox, W333 H177,                                                                            其它 Others
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Text, Xp Yp+15,                                                                %Var_LAltLButton_2_LeftClick%
;Gui, Start: Add, Hotkey, Xp Yp W84 vKey_LeftClick,                                                              %Key_LeftClick%
Gui, Start: Add, Text, Xp Yp+33,                                        :                       %Var_View_Control%
Gui, Start: Add, Hotkey, Xp Yp W84 vKey_MouseFunction1,                                         %Key_MouseFunction1%
Gui, Start: Add, Text, Xp+87 Yp, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 vKey_MouseFunction2 Choose%Key_MouseFunction2_DDL%, LButton|MButton|RButton|%Var_None%
Gui, Start: Add, Text, Xp-99 Yp+33,                                     :                       %Var_StopOrBegin%
Gui, Start: Add, Hotkey, Xp Yp W84 vKey_Suspend1,                                               %Key_Suspend1%
Gui, Start: Add, Text, Xp+87 Yp, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 vKey_Suspend2 Choose%Key_Suspend2_DDL%,             LButton|MButton|RButton|%Var_None%
Gui, Start: Add, Text, Xp-99 Yp+33,                                     :                       %Var_Reload%
Gui, Start: Add, Hotkey, Xp Yp W84 vKey_Reload1,                                                %Key_Reload1%
Gui, Start: Add, Text, Xp+87 Yp, /
Gui, Start: Add, DropDownList, Xp+12 Yp W84 vKey_Reload2 Choose%Key_Reload2_DDL%,               LButton|MButton|RButton|%Var_None%
;Gui, Start: Add, Text, Xm+18 Yp+39 ; 控距
Gui, Start: Add, Picture, Xm+63 Ym+72 W234 H351 +BackgroundTrans, %Image_DIR1%

Gui, Start: Tab, %Var_Functions%
Gui, Start: Add, Text, Xm+18 Ym+18 ; 控距
Gui, Start: Add, GroupBox, W333 H174,                                                                            选项 Options
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, CheckBox, Xp Yp+15 vRunAsAdmin Checked%RunAsAdmin%,                            %Var_Enable%%Var_Run_as_Admin%%Var_Recommanded%
Gui, Start: Add, CheckBox, Xp Yp+33 vEnableAutoScale Checked%EnableAutoScale%,                  %Var_Enable%%Var_Auto_Identification%%Var_Recommanded%
Gui, Start: Add, CheckBox, Xp Yp+33 vEnableOcclusion Checked%EnableOcclusion%,                  %Var_Enable%%Var_Cursor_Occlusion%%Var_Recommanded%
Gui, Start: Add, CheckBox, Xp Yp+33 vEnableRestriction Checked%EnableRestriction%,              %Var_Enable%%Var_Cursor_Restriction%%Var_Recommanded%
Gui, Start: Add, Text, Xm+18 Yp+39 ; 控距
Gui, Start: Add, GroupBox, W333 H222,                                                                            高级 Advance
Gui, Start: Font, s9, 新宋体
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Text, Xp Yp+15,                                                                                                 %Var_FaultTolerance_CombatScene_Normal_T_Percentage%
Gui, Start: Add, Slider, Xp+159 Yp Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_CombatScene_Normal_T_Percentage,     %FaultTolerance_CombatScene_Normal_T_Percentage%
Gui, Start: Add, Text, Xp-159 Yp+33,                                                                                             %Var_FaultTolerance_CombatScene_Normal_B_Percentage%
Gui, Start: Add, Slider, Xp+159 Yp Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_CombatScene_Normal_B_Percentage,     %FaultTolerance_CombatScene_Normal_B_Percentage%
Gui, Start: Add, Text, Xp-159 Yp+33,                                                                                             %Var_FaultTolerance_CombatScene_LowHealth_T_Percentage%
Gui, Start: Add, Slider, Xp+159 Yp Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_CombatScene_LowHealth_T_Percentage, %FaultTolerance_CombatScene_LowHealth_T_Percentage%
Gui, Start: Add, Text, Xp-159 Yp+33,                                                                                             %Var_FaultTolerance_CombatScene_LowHealth_B_Percentage%
Gui, Start: Add, Slider, Xp+159 Yp Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_CombatScene_LowHealth_B_Percentage, %FaultTolerance_CombatScene_LowHealth_B_Percentage%
Gui, Start: Add, Text, Xp-159 Yp+33,                                                                                             %Var_FaultTolerance_ElysiumLobby_T_Percentage%
Gui, Start: Add, Slider, Xp+159 Yp Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_ElysiumLobby_T_Percentage,           %FaultTolerance_ElysiumLobby_T_Percentage%
Gui, Start: Add, Text, Xp-159 Yp+33,                                                                                             %Var_FaultTolerance_ElysiumLobby_B_Percentage%
Gui, Start: Add, Slider, Xp+159 Yp Range0-100 Thick9 TickInterval100 ToolTipRight vFaultTolerance_ElysiumLobby_B_Percentage,           %FaultTolerance_ElysiumLobby_B_Percentage%
Gui, Start: Font, s12, 新宋体
Gui, Start: Add, Picture, Xm+57 Ym+72 W258 H351 +BackgroundTrans, %Image_DIR2%

Gui, Start: Tab, %Var_Settings%
Gui, Start: Add, Text, Xm+18 Ym+18 ; 控距
Gui, Start: Add, GroupBox, W333 H78,                                              配置 Config
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Radio, Xp Yp+15 gConfig_Import,                 %Var_Load_Preset%
Gui, Start: Add, Text, Xm+18 Yp+39 ; 控距
Gui, Start: Add, GroupBox, W333 H177,                                             更新 Update
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Radio, Xp Yp+15 gUpdateCheck,                   %Var_Check_for_Update%
Gui, Start: Add, Link, Xp Yp+33,         [URL] 百度云:           <a href="https://pan.baidu.com/s/1KK1B-r-hx_s3yTRl_h_oOg">提取码:2022</a>
Gui, Start: Add, Link, Xp Yp+33,         [URL] Github:           <a href="https://github.com/Spartan711/Genshin-to-Honkai-PC-Control-Project/releases">New Release</a>
Gui, Start: Add, Text, Xp Yp+33,                                 %Var_Changelogs%:
Gui, Start: Add, DDL, Xp+192 Yp W87 gSelectVersion vVersion,     %A_Space%||v0.4.+|v0.3.+|v0.2.+|v0.1.+
Gui, Start: Add, Text, Xm+18 Yp+39 ; 控距
Gui, Start: Add, GroupBox, W333 H111,                                             其它 Others
;Gui, Start: Add, Text, Xm+18 Yp+39 ; 控距
Gui, Start: Add, Picture, Xm+72 Ym+72 W204 H351 +BackgroundTrans, %Image_DIR3%

Gui, Start: Tab
Gui, Start: Add, Button, Default W366 gClickToRun, %Var_Run%
Gui, Start: Add, Button,         W366 gClickToExit, %Var_Exit%
Gui, Start: Show, xCenter yCenter, %Var_Startup_Interface%
DisableButtonX()
Suspend, On
Return


;【标签 Label】
Config_Import:
MsgBox, 0x24, %Var_Inquiry%, %Var_Ask_to_Proceed%
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
    Gui, Presets: Add, Button, W33, %Var_Load_Preset_for_Keyboard%
    Gui, Presets: Add, Button, W33, %Var_Load_Preset_for_Gamepad%
    /*
    对variable的百分号进行转义后会在compile时报错:
    FileInstall, Config/Preset_Keyboard/BH3_Hotkey_`%Version`%.ini, %INI_DIR%, 1
    故不再采用这种命名方式
    */
    FileInstall, Config/Preset_Keyboard/BH3_Hotkey.ini, %INI_DIR%, 1
    MsgBox, 0, %Var_Notifaction%, %Var_Preset_Loaded%
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
ClickToRun: ;StartButton%Var_Run%:

Gui, Start: Submit ;Gui, Submit

;【配置 INI】写入配置
IniWrite, %Key_MainSkill1%, %INI_DIR%, Keymaps, %Var_Main_Skill%1
IniWrite, %Key_MainSkill2%, %INI_DIR%, Keymaps, %Var_Main_Skill%2
IniWrite, %Key_SecondSkill1%, %INI_DIR%, Keymaps, %Var_Weapon_Skill%1
IniWrite, %Key_SecondSkill2%, %INI_DIR%, Keymaps, %Var_Weapon_Skill%2
IniWrite, %Key_DollSkill1%, %INI_DIR%, Keymaps, %Var_Doll_Skill%1
IniWrite, %Key_DollSkill2%, %INI_DIR%, Keymaps, %Var_Doll_Skill%2
IniWrite, %Key_Dodging1%, %INI_DIR%, Keymaps, %Var_Dodging%1
IniWrite, %Key_Dodging2%, %INI_DIR%, Keymaps, %Var_Dodging%2
IniWrite, %Key_NormalAttack1%, %INI_DIR%, Keymaps, %Var_Normal_Attack%1
IniWrite, %Key_NormalAttack2%, %INI_DIR%, Keymaps, %Var_Normal_Attack%2
;IniWrite, Key_LeftClick, %INI_DIR%, Keymaps, 正常点击
IniWrite, %Key_MouseFunction1%, %INI_DIR%, Keymaps, %Var_View_Control%1
IniWrite, %Key_MouseFunction2%, %INI_DIR%, Keymaps, %Var_View_Control%2
IniWrite, %Key_Suspend1%, %INI_DIR%, Keymaps, %Var_StopOrBegin%1
IniWrite, %Key_Suspend2%, %INI_DIR%, Keymaps, %Var_StopOrBegin%2
IniWrite, %Key_Reload1%, %INI_DIR%, Keymaps, %Var_Reload%1
IniWrite, %Key_Reload2%, %INI_DIR%, Keymaps, %Var_Reload%2

IniWrite, %RunAsAdmin%, %INI_DIR%, Options, %Var_Run_as_Admin%
IniWrite, %EnableAutoScale%, %INI_DIR%, Options, %Var_Auto_Identification%
IniWrite, %EnableOcclusion%, %INI_DIR%, Options, %Var_Cursor_Occlusion%
IniWrite, %EnableRestriction%, %INI_DIR%, Options, %Var_Cursor_Restriction%

IniWrite, %FaultTolerance_CombatScene_Normal_T_Percentage%, %INI_DIR%, Params, %Var_FaultTolerance_CombatScene_Normal_T_Percentage%
IniWrite, %FaultTolerance_CombatScene_Normal_B_Percentage%, %INI_DIR%, Params, %Var_FaultTolerance_CombatScene_Normal_B_Percentage%
IniWrite, %FaultTolerance_CombatScene_LowHealth_T_Percentage%, %INI_DIR%, Params, %Var_FaultTolerance_CombatScene_LowHealth_T_Percentage%
IniWrite, %FaultTolerance_CombatScene_LowHealth_B_Percentage%, %INI_DIR%, Params, %Var_FaultTolerance_CombatScene_LowHealth_B_Percentage%
IniWrite, %FaultTolerance_ElysiumLobby_T_Percentage%, %INI_DIR%, Params, %Var_FaultTolerance_ElysiumLobby_T_Percentage%
IniWrite, %FaultTolerance_ElysiumLobby_B_Percentage%, %INI_DIR%, Params, %Var_FaultTolerance_ElysiumLobby_B_Percentage%

Gui, Start: Destroy

;【热键 Hotkey】重定义热键到标签
Loop, 2
{
    If (Key_MainSkill%A_Index% != Var_None && Key_MainSkill%A_Index% != "")
    {
        Key_MainSkill = % Key_MainSkill%A_Index%
        Hotkey, %Key_MainSkill%, Key_MainSkill
    }
    If (Key_SecondSkill%A_Index% != Var_None && Key_SecondSkill%A_Index% != "")
    {
        Key_SecondSkill = % Key_SecondSkill%A_Index%
        Hotkey, %Key_SecondSkill%, Key_SecondSkill
    }
    If (Key_DollSkill%A_Index% != Var_None && Key_DollSkill%A_Index% != "")
    {
        Key_DollSkill = % Key_DollSkill%A_Index%
        Hotkey, %Key_DollSkill%, Key_DollSkill
    }
    If (Key_Dodging%A_Index% != Var_None && Key_Dodging%A_Index% != "")
    {
        Key_Dodging = % Key_Dodging%A_Index%
        Hotkey, %Key_Dodging%, Key_Dodging
    }
    If (Key_NormalAttack%A_Index% != Var_None && Key_NormalAttack%A_Index% != "")
    {
        Key_NormalAttack = % Key_NormalAttack%A_Index%
        Hotkey, %Key_NormalAttack%, Key_NormalAttack
    }
    ;Hotkey, %Key_LeftClick%, Key_LeftClick
    If (Key_MouseFunction%A_Index% != Var_None && Key_MouseFunction%A_Index% != "")
    {
        Key_MouseFunction = % Key_MouseFunction%A_Index%
        Hotkey, %Key_MouseFunction%, Key_MouseFunction
    }
    If (Key_Suspend%A_Index% != Var_None && Key_Suspend%A_Index% != "")
    {
        Key_Suspend = % Key_Suspend%A_Index%
        Hotkey, %Key_Suspend%, Key_Suspend
    }
    If (Key_Reload%A_Index% != Var_None && Key_Reload%A_Index% != "")
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
        MsgBox, 16, %Var_Warning%, %Var_Tip_of_Exit%
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
        MsgBox, 16, %Var_Warning%, %Var_Tip_of_Exit%
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
        MsgBox, 16, %Var_Warning%, %Var_Tip_of_Exit%
        ForceQuit() ;ExitApp
    }
}

SetTimer, AutoFadeMsgbox, -3000 ; [可调校数值 adjustable parameters] 使消息弹窗仅存在一段时间(ms)
MsgBox, 0, %Var_Notifaction%, %Var_Tip_of_Start%
SetTimer, AutoFadeMsgbox, Delete
Suspend, Off
Return


;【标签 Label】“退出”按钮的执行语句
ClickToExit: ;StartButton%Var_Exit%:
If WinExist("ahk_exe BH3.exe")
{
    MsgBox, 0x24, %Var_Inquiry%, %Var_Ask_to_Quit%
    IfMsgBox, Yes
        ForceQuit() ;ExitApp
}
Else
{
    MsgBox, 0x24, %Var_Inquiry%, %Var_Ask_to_Exit%
    IfMsgBox, Yes
        ForceQuit() ;ExitApp
}
Return


;【标签 Label】
Config_Check:
IfNotExist, %INI_DIR%
{
    MsgBox, 0, %Var_Notifaction%, %Var_Tip_to_Run%
}
Else
    Run, open %INI_DIR%
Return


;【标签 Label】
Config_Delete:
IfNotExist, %INI_DIR%
{
    MsgBox, 0, %Var_Notifaction%, %Var_Tip_to_Run%
}
Else
{
    Try
    {
        FileSetAttrib, -R, %INI_DIR%
    }
    FileDelete, %INI_DIR%
    MsgBox, 0, %Var_Notifaction%, %Var_Config_Removed%
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