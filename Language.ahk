;---------------------------------------------------------------------------------------------------------------------------------------------------------------
; 这里用于存放翻译功能相关的代码
;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【函数 Function】英文翻译
English()
{
    Global
    执行初始化缓存清理 := "Execude Initial-Cache-Cleanup"
    已执行 := "Done"

    无 := "None"

    查看配置文件 := "Config Check"
    删除配置文件 := "Config Delete"
    调试日志 := "Debugging Log"
    敬请期待 := "Coming Soon"
    其它 := "Else"
    重启 := "Reload"
    退出 := "Exit"

    键位 := "Keymap"
    必杀技 := "Main Skill "
    武器技或后崩技 := "Weapon Skill "
    人偶技或月之环 := "Doll Skill "
    闪避 := "Dodging "
    普攻 := "Normal Attack "
    左Alt加左键_正常点击 := "LAlt     +     LButton: Left-Click"
    管理鼠标功能 := "View-Control "
    暂停或启用 := "Stop/Begin "
    重启 := "Restart "

    功能 := "Function"
    启用 := "Enable "
    管理员权限 := "Run as Admin"
    全自动识别 := "Auto-Identification"
    可隐藏光标 := "Cursor Occlusion"
    限制性光标 := "Cursor Restriction"
    注_推荐 := ""
    正常战斗状态识别容错率_目标 := "FaultTolerance_Combat T"
    正常战斗状态识别容错率_背景 := "FaultTolerance_Combat B"
    濒危战斗状态识别容错率_目标 := "FaultTolerance_Danger T"
    濒危战斗状态识别容错率_背景 := "FaultTolerance_Danger B"
    往世乐土大厅识别容错率_目标 := "FaultTolerance_Elysium T"
    往世乐土大厅识别容错率_背景 := "FaultTolerance_Elysium B"

    设置 := "Settings"
    载入配置预设 := "Load Preset"
    检查版本更新 := "Check for Update"
    查看更新日志 := "Changelogs"

    开启 := "Run"
    退出 := "Exit"

    启动界面 := "Startup Interface"

    询问 := "Inquiry"
    操作将覆盖当前的配置_是否继续 := "This would overwrite the current config`nReady to proceed?"
    载入键鼠预设 := "Load preset for keyboard"
    载入手柄预设 := "Load preset for gamepad"

    提示 := "Notifaction"
    已成功载入预设 := "Preset successfully loaded"

    警告 := "Warning"
    检测到参数异常_即将退出程序 := "Invalid param detected, exit procedures."

    程序启动成功_祝游戏愉快_当前对话框将于3秒后自动消失 := "Program successfully started, enjoy!`n（This message will disappear in 3 sec）"

    检测到崩坏3正在运行_真的要退出吗 := "Quit the app while Honkai Imapct 3 is still running?"

    是否确认退出当前程序 := "Are you sure to exit?"

    未找到配置文件_请先运行程序 := "Can't find the config file, please run the program."

    已成功移除配置文件 := "Config successfully removed."

    ;暂停中 := "Suspended"
    ;已启用 := "Continued"

    视角跟随已手动激活 := "View-Control On"
    视角跟随已手动关闭 := "View-Control Off"
}


;【函数 Function】中文翻译
Chinese()
{
    Global
    执行初始化缓存清理 := "执行初始化缓存清理"
    已执行 := "已执行"

    无 := "无"

    查看配置文件 := "查看配置文件"
    删除配置文件 := "删除配置文件"
    调试日志 := "调试日志"
    敬请期待 := "敬请期待"
    其它 := "其它"
    重启 := "重启"
    退出 := "退出"

    键位 := "键位"
    必杀技 := "必杀技"
    武器技或后崩技 := "武器技/后崩技"
    人偶技或月之环 := "人偶技/月之环"
    闪避 := "闪避"
    普攻 := "普攻"
    左Alt加左键_正常点击 := "左Alt      +      左键: 正常点击"
    管理鼠标功能 := "管理视角跟随"
    暂停或启用 := "暂停/启用"
    重启 := "重启"

    功能 := "功能"
    启用 := "启用"
    管理员权限 := "管理员权限"
    全自动识别 := "全自动识别"
    可隐藏光标 := "可隐藏光标"
    限制性光标 := "限制性光标"
    注_推荐 := "（推荐）"
    正常战斗状态识别容错率_目标 := "正常战斗状态识别容错率1"
    正常战斗状态识别容错率_背景 := "正常战斗状态识别容错率2"
    濒危战斗状态识别容错率_目标 := "濒危战斗状态识别容错率1"
    濒危战斗状态识别容错率_背景 := "濒危战斗状态识别容错率2"
    往世乐土大厅识别容错率_目标 := "往世乐土大厅识别容错率1"
    往世乐土大厅识别容错率_背景 := "往世乐土大厅识别容错率2"

    设置 := "设置"
    载入配置预设 := "载入配置预设"
    检查版本更新 := "检查版本更新"
    查看更新日志 := "查看更新日志"

    开启 := "开启"
    退出 := "退出"

    启动界面 := "启动界面"

    询问 := "询问"
    操作将覆盖当前的配置_是否继续 := "操作将覆盖当前的配置`n是否继续？"
    载入键鼠预设 := "载入键鼠预设"
    载入手柄预设 := "载入手柄预设"

    提示 := "提示"
    已成功载入预设 := "已成功载入预设"

    警告 := "警告"
    检测到参数异常_即将退出程序 := "检测到参数异常，即将退出程序"

    程序启动成功_祝游戏愉快_当前对话框将于3秒后自动消失 := "程序启动成功(/≧▽≦)/，祝游戏愉快！`n（当前对话框将于3秒后自动消失）"

    检测到崩坏3正在运行_真的要退出吗 := "检测到崩坏3正在运行`n\(≧□≦)/真的要退出吗？"

    是否确认退出当前程序 := "是否确认退出当前程序`n(・-・*)？"

    未找到配置文件_请先运行程序 := "未找到配置文件，请先运行程序"

    已成功移除配置文件 := "已成功移除配置文件"

    ;暂停中 := "暂停中"
    ;已启用 := "已启用"

    视角跟随已手动激活 := "视角跟随已手动激活"
    视角跟随已手动关闭 := "视角跟随已手动关闭"
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