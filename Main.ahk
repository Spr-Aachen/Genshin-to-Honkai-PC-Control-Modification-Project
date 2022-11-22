;---------------------------------------------------------------------------------------------------------------------------------------------------------------
; 这里用于存放全局变量和文件调用指令，也就是主文件。要记得及时同步版本号哦
;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【常量 Const】版本号
Global Version := "0.4.0"


;【常量 Const】对管理隐藏光标功能的全局常量进行赋值
Global Toggle_Occlusion := False
Global Status_Occlusion

;【常量 Const】对管理限制光标功能的全局常量进行赋值
Global Toggle_Restriction := False
Global Status_Restriction
Global x1
Global y1

;【常量 Const】对管理鼠标控制功能的全局常量进行赋值
Global Toggle_MouseFunction := False

;【常量 Const】对管理视角跟随功能的全局常量进行赋值
Global Status_Key_ViewControl := False
Global Timer_ViewControl := 10 ; [可调校数值 adjustable parameters] 设定视角跟随命令的每执行时间间隔(ms)

;【常量 Const】对管理准星跟随功能的全局常量进行赋值
Global BreakFlag_Aim := False
Global Status_w := False
Global Status_a := False
Global Status_s := False
Global Status_d := False
Global Timer_AimControl := 20 ; [可调校数值 adjustable parameters] 设定准星跟随命令的每执行间隔时间(ms)


;【常量 Const】对管理屏幕检测功能的全局常量进行赋值
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

;【常量 Const】对管理屏幕检测功能的全局常量进行赋值
;Global Toggle_ScreenDetect := False
Global FirstTime_ScreenDetect := True
Global Timer_ScreenDetect := 2100

Global Toggle_ScreenDetectController := False
Global Timer_ScreenDetectController := 1

;【常量 Const】对管理自动控制功能的全局常量进行赋值
Global Toggle_AutoScale := False
Global Status_CombatIcon := False
Global Status_ElysiumIcon := False
Global FaultTolerance_Combat_Normal1 := 0.00001 * %FaultTolerance_Combat_Normal1_Percentage1%
Global FaultTolerance_Combat_Normal2 := 0.00001 * %FaultTolerance_Combat_Normal1_Percentage2%
Global FaultTolerance_Combat_Endangered1 := 0.01 * %FaultTolerance_Combat_Endangered1_Percentage1%
Global FaultTolerance_Combat_Endangered2 := 0.01 * %FaultTolerance_Combat_Endangered1_Percentage2%
Global FaultTolerance_Elysium1 := 0.01 * %FaultTolerance_Elysium1%
Global FaultTolerance_Elysium2 := 0.01 * %FaultTolerance_Elysium2%
Global Timer_AutoScale := 81 ; [可调校数值 adjustable parameters] 设定自动识别命令的每执行时间间隔(ms)，如果值过小可能不好使


;【常量 Const】对管理手动暂停功能的全局常量进行赋值
Global Toggle_ManualSuspend := False


;【常量 Const】对管理检查更新功能的全局常量进行赋值
Global IsRequestDone
Global MirrorList := ["https://github.com", "https://ghproxy.com/https://github.com"]
Global ChosenMirror
Global Request := ComObjCreate("MSXML2.ServerXMLHTTP") ; XMLHTTP为客户端应用程序而设计，依赖于基于WinInet而构建的URLMon；而ServerXMLHTTP为服务器应用程序而设计，依赖于新的HTTP客户端堆栈WinHTTP
Global ChosenMirror_Tried := Array()


;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【命令 Directive】引用库文件FindText.ahk
#include <FindText>

;【命令 Directive】
#include Updater.ahk

;【命令 Directive】
#include Interface.ahk

;【命令 Directive】
#include Functions_Combat.ahk

;【命令 Directive】
#include Functions_Management.ahk


;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【命令 Directive】检测崩坏3游戏窗口，使程序仅在崩坏3游戏运行时生效
#IfWinActive ahk_exe BH3.exe

;【命令 Directive】修改AHK的默认掩饰键
#MenuMaskKey vkE8  ; vkE8尚未映射

;【命令 Directive】不对以下键盘热键使用钩子（也不要对鼠标热键使用InstallMouseHook）
#UseHook, Off


;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【命令 Directive】
#include Hotkeys_Combat.ahk

;【命令 Directive】
#include Hotkeys_Management.ahk


;---------------------------------------------------------------------------------------------------------------------------------------------------------------
;目前就这些，可根据需要自行修改
;---------------------------------------------------------------------------------------------------------------------------------------------------------------