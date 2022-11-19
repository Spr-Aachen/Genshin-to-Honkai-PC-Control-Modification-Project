;---------------------------------------------------------------------------------------------------------------------------------------------------------------
Global Test := True ; Use "False" by default
;---------------------------------------------------------------------------------------------------------------------------------------------------------------


Global MirrorList := ["https://github.com", "https://ghproxy.com/https://github.com"]
Global ChosenMirror := 1 ; ChosenMirror > 0 and ChosenMirror <= MirrorList.Length()
Global Site := MirrorList[ChosenMirror]
Global Request := ComObjCreate("MSXML2.ServerXMLHTTP") ; 不使用XMLHTTP的原因：XMLHTTP为客户端应用程序而设计，并依赖于基于WinInet而构建的URLMon；而ServerXMLHTTP为服务器应用程序而设计，并依赖于新的HTTP客户端堆栈WinHTTP
Global RequestDone := 0


Updater()
{
	If (Test)
		Request.Open("GET", Site "/Spr-Aachen/Genshin-to-Honkai-PC-Control-Modification-Project/releases/download/v0.4.0-beta/Version.txt", True)
	Else
		Request.Open("GET", Site "/Spr-Aachen/Genshin-to-Honkai-PC-Control-Modification-Project/releases/latest/download/Version.txt", True) ; 打开启用异步的请求，获取最新版本号记录
	Request.onreadystatechange := Func("Ready") ; 设置回调函数
	Request.Send()
	Return
}


Ready()
{
	If (!RequestDone)
	{
		;log("Updater Request.readyState=" Request.readyState, 1)
		If (Request.readyState == 4) ; readyState的每次变化都会触发onreadystatechange函数而status不会，故先判断readyStatus
		{
			If (Request.status == 200)
			{
				RegExMatch(Version, "(\d+)\.(\d+)\.(\d+)", Version_Current)
				RegExMatch(Request.responseText, "^(\d+)\.(\d+)\.(\d+)$", Version_Latest) ; DOMString是XMLHttpRequest返回的纯文本的值。当DOMString为null时，表示请求失败了；当DOMString为""时，表示这个请求还没有被send()。PS: StrLen(Request.responseText) <= 
				If ((Version_Current1*10000 + Version_Current2*100 + Version_Current3) < (Version_Latest1*10000 + Version_Latest2*100 + Version_Latest3))
				{
					MsgBox, 0x24, 询问, % "检测到新版本" Request.responseText "`n是否下载?"
					IfMsgBox Yes
					{
						Try
						{
							FileCreateDir, ./Temp
							If (Test)
								UrlDownloadToFile, % Site "/Spr-Aachen/Genshin-to-Honkai-PC-Control-Modification-Project/releases/download/v0.4.0-beta/BH3_Hotkey.exe", ./Temp/BH3_Hotkey.exe
							Else
								UrlDownloadToFile, % Site "/Spr-Aachen/Genshin-to-Honkai-PC-Control-Modification-Project/releases/latest/download/BH3_Hotkey.exe", ./Temp/BH3_Hotkey.exe
						}
						Catch
						{
							;log("Err[" ErrorLevel "]Download failed", 0)
							MsgBox, 16, 提示, 下载失败
							Return
						}
						Finally
						{
							/*
							MsgBox, , 提示, 更新下载完成`n软件即将重启, 3
							FileInstall, ./Temp/BH3_Hotkey.exe, ./BH3_Hotkey.exe, 1
							Run, BH3_Hotkey.exe
							*/
							MsgBox, , 提示, 更新下载完成, 3
							ExitAPP
						}
					}
				}
				Else
					MsgBox, , 提示, 当前已是最新版本, 2
			}
			Else
				TrayTip, , % "更新失败`nStatus=" Request.status, , 0x3
		}
		RequestDone := !RequestDone
		;log("Updater Request.status=" Request.status, 1)
	}
}