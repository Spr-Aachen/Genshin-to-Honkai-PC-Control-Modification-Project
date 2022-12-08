;---------------------------------------------------------------------------------------------------------------------------------------------------------------
; 这里用于存放更新功能相关的代码
;---------------------------------------------------------------------------------------------------------------------------------------------------------------


Global IsTesting := False ; Turn it to "True" for download testing.


;---------------------------------------------------------------------------------------------------------------------------------------------------------------


Updater()
{
	IsRequestDone := False
	Random, ChosenMirror, 1, MirrorList.Length()
	If (IsTesting)
		Request.Open("GET", MirrorList[ChosenMirror] "/Spr-Aachen/Genshin-to-Honkai-PC-Control-Modification-Project/releases/download/v0.4.0-beta/Version.txt", True)
	Else
		Request.Open("GET", MirrorList[ChosenMirror] "/Spr-Aachen/Genshin-to-Honkai-PC-Control-Modification-Project/releases/latest/download/Version.txt", True) ; 打开启用异步的请求，获取最新版本号记录
	Request.onreadystatechange := Func("Ready") ; 设置回调函数
	Request.Send()
	SetTimer, Retry, -9999
	Return
}


Ready()
{
	If (Request.readyState == 4) ; readyState的每次变化都会触发onreadystatechange函数而status不会，故先判断readyStatus
	{
        If (!IsRequestDone)
		{
			IsRequestDone := !IsRequestDone
		    If (Request.status == 200)
		    {
				SetTimer, Retry, Off
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
							If (IsTesting)
								UrlDownloadToFile, % MirrorList[ChosenMirror] "/Spr-Aachen/Genshin-to-Honkai-PC-Control-Modification-Project/releases/download/v0.4.0-beta/BH3_Hotkey.exe", ./Temp/BH3_Hotkey.exe
							Else
								UrlDownloadToFile, % MirrorList[ChosenMirror] "/Spr-Aachen/Genshin-to-Honkai-PC-Control-Modification-Project/releases/latest/download/BH3_Hotkey.exe", ./Temp/BH3_Hotkey.exe
						}
						Catch
						{
							MsgBox, 16, 警告, 下载失败`n进行再次尝试
							Return
						}
						Finally
						{
							MsgBox, 0, 提示, 更新下载完成`n软件即将重启
							FileInstall, EXE/Installer.exe, ./Temp/Installer.exe, 1
							Run, ./Temp/Installer.exe
							ExitAPP
						}
					}
				}
				Else
					MsgBox, 0, 提示, 当前已是最新版本
			}
            Else
            {
                ;TrayTip, , % "尝试更新失败`nStatus=" Request.status, , 0x3
                TryNextMirror()
            }
        }
	}
}


TryNextMirror()
{
	ChosenMirror_Tried.Push(ChosenMirror)
	For Key, Value in MirrorList
	{
		Tried := False
		For _, Element in ChosenMirror_Tried ; "_"为占位符
		{
			If (Element == Key)
			{
				Tried := True
				Break
			}
		}
		If (!Tried)
		{
			ChosenMirror := Key
			Updater()
			Return
		}
	}
	TrayTip, , % "再次尝试更新失败`nStatus=" Request.status, , 0x3
}


Retry()
{
	TryNextMirror()
	Return
}


;---------------------------------------------------------------------------------------------------------------------------------------------------------------