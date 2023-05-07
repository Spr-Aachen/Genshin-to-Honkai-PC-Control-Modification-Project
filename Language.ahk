;---------------------------------------------------------------------------------------------------------------------------------------------------------------
; 这里用于存放翻译功能相关的代码
;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【函数 Function】英文翻译
English()
{
    Global
    Var_Execute_Initial_Setup := "Execute Initial-Setup"
    Var_Done := "Done"

    Var_None := "None"

    Var_Config_Check := "Config Check"
    Var_Config_Delete := "Config Delete"
    Var_Debugging_Log := "Debugging Log"
    Var_Coming_Soon := "Coming Soon"
    Var_Else := "Else"
    Var_Reload := "Reload"
    Var_Exit := "Exit"

    Var_Keymaps := "Keymaps"
    Var_Main_Skill := "Main Skill "
    Var_Weapon_Skill := "Weapon Skill "
    Var_Doll_Skill := "Doll Skill "
    Var_Dodging := "Dodging "
    Var_Normal_Attack := "Normal Attack "
    Var_LAltLButton_2_LeftClick := "LAlt     +     LButton: Left-Click"
    Var_View_Control := "View-Control "
    Var_StopOrBegin := "Stop/Begin "

    Var_Functions := "Functions"
    Var_Enable := "Enable "
    Var_Run_as_Admin := "Run as Admin"
    Var_Auto_Identification := "Auto-Identification"
    Var_Cursor_Occlusion := "Cursor Occlusion"
    Var_Cursor_Restriction := "Cursor Restriction"
    Var_Recommanded := ""
    Var_FaultTolerance_CombatScene_Normal_T_Percentage := "FT_NormalCombat_Target"
    Var_FaultTolerance_CombatScene_Normal_B_Percentage := "FT_NormalCombat_Background"
    Var_FaultTolerance_CombatScene_LowHealth_T_Percentage := "FT_DangerCombat_Target"
    Var_FaultTolerance_CombatScene_LowHealth_B_Percentage := "FT_DangerCombat_Background"
    Var_FaultTolerance_ElysiumLobby_T_Percentage := "FT_ElysiumLobby_Target"
    Var_FaultTolerance_ElysiumLobby_B_Percentage := "FT_ElysiumLobby_Background"

    Var_Settings := "Settings"
    Var_Load_Preset := "Load Preset"
    Var_Check_for_Update := "Check for Update"
    Var_Changelogs := "Changelogs"

    Var_Run := "Run"

    Var_Startup_Interface := "Startup Interface"

    Var_Inquiry := "Inquiry"
    Var_Ask_to_Proceed := "This would overwrite the current config`nReady to proceed?"
    Var_Load_Preset_for_Keyboard := "Load preset for keyboard"
    Var_Load_Preset_for_Gamepad := "Load preset for gamepad"

    Var_Notifaction := "Notifaction"
    Var_Preset_Loaded := "Preset successfully loaded"

    Var_Warning := "Warning"
    Var_Tip_of_Exit := "Invalid param detected, exit procedures."

    Var_Tip_of_Start := "Program successfully started, enjoy!`n（This message will disappear in 3 sec）"

    Var_Ask_to_Quit := "Quit the app while Honkai Imapct 3 is still running?"

    Var_Ask_to_Exit := "Are you sure to exit?"

    Var_Tip_to_Run := "Can't find the config file, please run the program."

    Var_Config_Removed := "Config successfully removed."

    ;Var_Suspended := "Suspended"
    ;Var_Continued := "Continued"

    Var_View_Control_On := "View-Control On"
    Var_View_Control_Off := "View-Control Off"
}


;【函数 Function】中文翻译
Chinese()
{
    Global
    Var_Execute_Initial_Setup := "执行初始化进程"
    Var_Done := "已执行"

    Var_None := "无"

    Var_Config_Check := "查看配置文件"
    Var_Config_Delete := "删除配置文件"
    Var_Debugging_Log := "调试日志"
    Var_Coming_Soon := "敬请期待"
    Var_Else := "其它"
    Var_Reload := "重启"
    Var_Exit := "退出"

    Var_Keymaps := "键位"
    Var_Main_Skill := "必杀技"
    Var_Weapon_Skill := "武器技/后崩技"
    Var_Doll_Skill := "人偶技/月之环"
    Var_Dodging := "闪避"
    Var_Normal_Attack := "普攻"
    Var_LAltLButton_2_LeftClick := "左Alt      +      左键: 正常点击"
    Var_View_Control := "管理视角跟随"
    Var_StopOrBegin := "暂停/启用"

    Var_Functions := "功能"
    Var_Enable := "启用"
    Var_Run_as_Admin := "管理员权限"
    Var_Auto_Identification := "全自动识别"
    Var_Cursor_Occlusion := "可隐藏光标"
    Var_Cursor_Restriction := "限制性光标"
    Var_Recommanded := "（推荐）"
    Var_FaultTolerance_CombatScene_Normal_T_Percentage := "正常战斗识别容错率-目标"
    Var_FaultTolerance_CombatScene_Normal_B_Percentage := "正常战斗识别容错率-背景"
    Var_FaultTolerance_CombatScene_LowHealth_T_Percentage := "濒危战斗识别容错率-目标"
    Var_FaultTolerance_CombatScene_LowHealth_B_Percentage := "濒危战斗识别容错率-背景"
    Var_FaultTolerance_ElysiumLobby_T_Percentage := "乐土大厅识别容错率-目标"
    Var_FaultTolerance_ElysiumLobby_B_Percentage := "乐土大厅识别容错率-背景"

    Var_Settings := "设置"
    Var_Load_Preset := "载入配置预设"
    Var_Check_for_Update := "检查版本更新"
    Var_Changelogs := "查看更新日志"

    Var_Run := "开启"

    Var_Startup_Interface := "启动界面"

    Var_Inquiry := "询问"
    Var_Ask_to_Proceed := "操作将覆盖当前的配置`n是否继续？"
    Var_Load_Preset_for_Keyboard := "载入键鼠预设"
    Var_Load_Preset_for_Gamepad := "载入手柄预设"

    Var_Notifaction := "提示"
    Var_Preset_Loaded := "已成功载入预设"

    Var_Warning := "警告"
    Var_Tip_of_Exit := "检测到参数异常，即将退出程序"

    Var_Tip_of_Start := "程序启动成功(/≧▽≦)/，祝游戏愉快！`n（当前对话框将于3秒后自动消失）"

    Var_Ask_to_Quit := "检测到崩坏3正在运行`n\(≧□≦)/真的要退出吗？"

    Var_Ask_to_Exit := "是否确认退出当前程序`n(・-・*)？"

    Var_Tip_to_Run := "未找到配置文件，请先运行程序"

    Var_Config_Removed := "已成功移除配置文件"

    ;Var_Suspended := "暂停中"
    ;Var_Continued := "已启用"

    Var_View_Control_On := "视角跟随已手动激活"
    Var_View_Control_Off := "视角跟随已手动关闭"
}


;【函数 Function】检测语言并选择翻译
LanguageDetect()
{
    If Not A_Language in [0404,0804,0c04,1004,1404] ; LanguageCode: 0404 "Chinese_Taiwan", 0804 "Chinese_PRC", 0c04 "Chinese_Hong_Kong", 1004 "Chinese_Singapore", 1404 "Chinese_Macau" 
    {
        If A_Language in []
        {
            Language := ""
        }
        Else
            Language := "ENG"
    }
    /*
    Else
        Language := "CHN"
    */

    Switch Language
    {
        Case "ENG":
            English()
            Return
        Default: ;Case "CHN":
            Chinese()
            Return
    }
}


;---------------------------------------------------------------------------------------------------------------------------------------------------------------


; 运行主程序
LanguageDetect()


;---------------------------------------------------------------------------------------------------------------------------------------------------------------