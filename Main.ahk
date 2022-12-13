;---------------------------------------------------------------------------------------------------------------------------------------------------------------
; 这里用于存放全局变量和文件调用指令，也就是主文件。要记得及时同步版本号哦
;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【变量 Variable】版本号
Global Version := "0.4.2"


;【变量 Variable】默认语言
Global Language := "CHN"


;【变量 Variable】对管理隐藏光标功能的全局变量进行赋值
Global Toggle_Occlusion := False
Global Status_Occlusion

;【变量 Variable】对管理定位光标功能的全局变量进行赋值
Global FirstTime_ZoneDetect := True
Global IsZoneInteractive
Global x1
Global y1

;【变量 Variable】对管理限制光标功能的全局变量进行赋值
Global Toggle_Restriction := False
Global Status_Restriction

;【变量 Variable】对管理光标定位功能的全局变量进行赋值
Global x2
Global y2

;【变量 Variable】对管理鼠标控制功能的全局变量进行赋值
Global Toggle_MouseFunction := False

;【变量 Variable】对管理视角跟随功能的全局变量进行赋值
Global Status_ViewControl := False
Global ViewControl_Mod := "Mod1"
;Global Status_ConflictDetect := False
Global Timer_ConflictDetect := 0 ; [可调校数值 adjustable parameters] 设定冲突检测命令的每执行时间间隔(ms)
Global BreakFlag_View := False
Global Timer_ViewControl := 10 ; [可调校数值 adjustable parameters] 设定视角跟随命令的每执行时间间隔(ms)

;【变量 Variable】对管理准星跟随功能的全局变量进行赋值
Global BreakFlag_Aim := False
Global Status_w := False
Global Status_a := False
Global Status_s := False
Global Status_d := False
Global Timer_AimControl := 20 ; [可调校数值 adjustable parameters] 设定准星跟随命令的每执行间隔时间(ms)


;【变量 Variable】对管理屏幕检测功能的全局变量进行赋值
Global ClientUpperLeftCorner_X
Global ClientUpperLeftCorner_Y
Global Client_Width
Global Client_Height
Global UpperLeftCorner_X
Global UpperLeftCorner_Y
Global LowerRightCorner_X
Global LowerRightCorner_Y
Global LowerRightCorner_X2
Global LowerRightCorner_Y2
Global UpperLeftCorner_X2
Global UpperLeftCorner_Y2
Global Icon

;【变量 Variable】对管理屏幕检测功能的全局变量进行赋值
;Global Toggle_ScreenDetect := False
Global FirstTime_ScreenDetect := True
Global Timer_ScreenDetect := 2100
Global Toggle_ScreenDetectController := False
Global Timer_ScreenDetectController := 1

;【变量 Variable】对管理自动控制功能的全局变量进行赋值
Global Toggle_AutoScale := False
Global Status_CombatIcon := False
Global Status_ElysiumIcon := False
Global FaultTolerance_Combat_Normal_T := 0.01 * %FaultTolerance_Combat_Normal_T_Percentage% * 0.01
Global FaultTolerance_Combat_Normal_B := 0.01 * %FaultTolerance_Combat_Normal_B_Percentage% * 0.01
Global FaultTolerance_Combat_Endangered_T := 0.01 * %FaultTolerance_Combat_Endangered_T_Percentage%
Global FaultTolerance_Combat_Endangered_B := 0.01 * %FaultTolerance_Combat_Endangered_B_Percentage%
Global FaultTolerance_Elysium_T := 0.01 * %FaultTolerance_Elysium_T_Percentage%
Global FaultTolerance_Elysium_B := 0.01 * %FaultTolerance_Elysium_B_Percentage%
Global Timer_AutoScale := 81 ; [可调校数值 adjustable parameters] 设定自动识别命令的每执行时间间隔(ms)，如果值过小可能不好使


;【变量 Variable】对管理手动暂停功能的全局变量进行赋值
Global Toggle_ManualSuspend := False


;【变量 Variable】对管理检查更新功能的全局变量进行赋值
Global IsRequestDone
Global MirrorList := ["https://github.com", "https://ghproxy.com/https://github.com"]
Global ChosenMirror
Global Request := ComObjCreate("MSXML2.ServerXMLHTTP") ; XMLHTTP为客户端应用程序而设计，依赖于基于WinInet而构建的URLMon；而ServerXMLHTTP为服务器应用程序而设计，依赖于新的HTTP客户端堆栈WinHTTP
Global ChosenMirror_Tried := Array()


;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【命令 Directive】引用库文件
#Include <FindText>

;【命令 Directive】
#Include Language.ahk

;【命令 Directive】
#Include Updater.ahk

;【命令 Directive】
#Include Interface.ahk

;【命令 Directive】
#Include Functions_Combat.ahk

;【命令 Directive】
#Include Functions_Management.ahk


;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【命令 Directive】检测崩坏3游戏窗口，使程序仅在崩坏3游戏运行时生效
#IfWinActive ahk_exe BH3.exe

;【命令 Directive】修改AHK的默认掩饰键
#MenuMaskKey vkE8  ; vkE8尚未映射

;【命令 Directive】安装且不对以下热键使用钩子
#InstallKeybdHook
#InstallMouseHook
#UseHook, Off


;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【命令 Directive】
#Include Hotkeys_Combat.ahk

;【命令 Directive】
#Include Hotkeys_Management.ahk


;---------------------------------------------------------------------------------------------------------------------------------------------------------------
;目前就这些，可根据需要自行修改
;---------------------------------------------------------------------------------------------------------------------------------------------------------------