## 崩坏3仿原神PC端键鼠操控<br>Genshin to Honkai PC Control Modification Project

本项目以AHK为基础进行编译。这仅是个半成品且完全为爱发电，是故望乞诸位海涵。干杯！ - ( ゜- ゜)つロ
<br>The project is basicly built with AutoHotkey. Please remind that this is a WIP (work in progress) stuff and I make it totally out of my love for the game, so I hope you guys won't push me too hard. Cheers!


## 【注意 Caution】

1. 请确保客户端为官方提供的PC端而非模拟器
<br>   Please ensure that the client you're using is served by MiHoYo official

2. 请确保游戏操作设置已重置为默认键位
<br>   Please ensure that the gaming operation settings have been reset to default

3. 请使用全屏模式游玩以确保自动识别的正常运行
<br>   Please use fullscreen mode in order to run "automatic identification" properly

<br>支持与不支持的客户端分辨率如下：（ 	:grey_exclamation: 表示未经测试）
<br>Supported&unsupported client resolution is shown as follows: ( 	:grey_exclamation: means untested)

| 分辨率 Resolution | 支持 Support |
| ----------------- | ----------- |
| 2560 x 1440       | :heavy_check_mark:          |
| 2560 x 1080       | :heavy_check_mark:          |
| 1920 x 1080       | :heavy_check_mark:          |
| 1680 x 1050       | :grey_exclamation:          |
| 1600 x 1024       | :heavy_multiplication_x:          |
| 1600 x 900        | :heavy_check_mark:          |
| 1440 x 900        | :heavy_check_mark:          |
| 1366 x 768        | :heavy_multiplication_x:          |
| 1360 x 768        | :heavy_check_mark:          |
| 1280 x 720        | :heavy_check_mark:          |
|  720 x 480        | :heavy_multiplication_x:          |

<br>若需要其它分辨率支持可以联系我，亦或者提交issue
<br>Contact me if any other resolution need to be supported, or submit an issue


## 【设定 Configurations】

**键位设定 - 战斗<br>Key Maps - Combat**

键位会在战斗状态下生效。且和原神PC端的默认键位设置较为相近（但注意瞄准模式的设定有所不同）
<br>Key maps would take effect in combat, and they're pretty much close to the default settings from Genshin Impact (but mind that there's a little difference between those two's aiming mode)

***Q键发动主技能（大招） Q key for main skill***
<br>使用方法：点按或长按Q
<br>Usage: Press or long press Q key

***E键发动副技能（武器技）/后崩坏书主技能（大招） E key for second skill(weapon skill)/APHO(A Post-Honkai Odyssey) main skill***
<br>使用方法：点按或长按E
<br>特殊设定：在长按E键进入瞄准模式后，可通过移动鼠标来操控准星
<br>Usage: Press or long press E key
<br>Extra: After entering the aiming mode by long pressing E key, cross hair can be controled by the mouse-movement

***Z键发动人偶技能/后崩坏书白热化状态（月之环） Z key for doll skill/APHO(A Post-Honkai Odyssey) white heat***
<br>使用方法：按下Z键
<br>Usage: Press down (Long press) Z key

***左侧Shift键或鼠标右键发动闪避/冲刺 LShift or RButton for dodging/dashing***
<br>使用方法：点击或长按左侧Shift键/鼠标右键
<br>Usage: Press (Click) or long press LShift/RButton

***鼠标左键发动普攻 LButton for normal attack***
<br>使用方法：点击或长按鼠标左键
<br>Usage: Press (Click) or long press LButton

**键位设定 - 控制<br>Key Maps - Control**

尽管已经能自动分辨战斗与其它场景，但在出现意外情况时仍可以进行手动控制
<br>Although the combat scene can be automaticly identified, manual control is still needed especially when exceptions occured

***左侧Alt键+鼠标左键以正常使用点击功能 LAlt+LButton for left-click function***
<br>使用方法：按住左侧Alt键后点击鼠标左键
<br>Usage: Press down (Long press) LAlt and then click LButton

***鼠标中键管理视角跟随功能 MButton for view-control function management***
<br>使用方法：点击鼠标中键
<br>特殊设定：关闭/激活时屏幕左下角有状态栏提示
<br>Usage: Click MButton
<br>Extra: Tooltips will show up in the left lower corner of the screen when turning off/turning on the function

***F1键暂停/启用程序 F1 key for program suspending/continuing***
<br>使用方法：按下F1键
<br>特殊设定：暂停/启用时屏幕左下角有状态栏提示
<br>Usage: Press down (Long press) F1 key
<br>Extra: Tooltips will show up in the left lower corner of the screen when suspending/continuing the program

***F3键调出启动界面 F3 key for surface check***
<br>使用方法：按下F3键
<br>Usage: Press down (Long press) F3 key

**附加设定<br>Addition**

1. 启动界面允许手动选择是否启用以下选项（均默认启用）：全自动识别、管理员权限、可隐藏光标以及限制性光标
<br>   The starting interface allows users to choose whether toggle the following options (all toggled by default): "automatic identification", "run as admin" ,"occluded cursor" and "restricted cursor"

2. 战斗场景内使用快捷键AltTab、WinTab进行窗口切换时会自动暂停游戏，按下F1、F3时也是同理（以启用全自动识别为前提）。需要注意的是，为节省资源占用和提高容错率，在执行快速切换后程序亦会自动暂停，故在切回游戏界面后需手动按下F1键以恢复程序运行。
<br>   While switching or rearranging windows by pressing shortcut AltTab or WinTab, the game would automaticly pause, so as the F1 key and F3 key (Under the premise of toggling  "automatic identification"). Notably, the programm would also suspend automaticly after doing quick switch or arrangement in order to lower the usage of system resources. Therefore, to resume the program manually, you need to press F1 key after switching back to the game.

3. 新增对往世乐土大厅场景的识别支持（以启用全自动识别为前提）
<br>   New scene supported:  Elysium Lobby

4. 精简版去掉了除左键（普攻）外的所有战斗键位
<br>   The simplified version removed all the combat key maps except LButton (which is for normal attack).


## 【缺陷 Bugs】

1. 目前未知视角缩放的设置键，无法实现该功能
<br>   So far the way to implement camera zooming is still unkown.

2. 视角跟随功能目前仍有延迟等问题，目前正在寻找更优方案
<br>   The view-control function has several problems like lagging. Been looking for better scheme to solve it.

3. 部分win11用户反映程序运行并未生效，目前尚未发现问题所在
<br>   Some Windows 11 system users reported that the programm won't work properly. Unfortunately I can't find out the problem.

4. 全自动识别功能对于硬件性能要求稍高，现已对其进行了数次优化
<br>   The "automatic identification" has a little high demand of hardware performance, though it has been optimized for several times.

5. 灵敏度（鼠标DPI）无法通过程序调节。虽然通过调教各函数的响应时间参数能够达到类似的效果，但是需要大量的数据采集和调试，这将是个漫长的过程。
<br>   Mouse DPI can't be simply adjusted through programm. Luckily a similar effect can be achieved by tuning each function's time response parameters, but large amount of data and debugging are needed, should be a long way to go.


## 【测试平台 Tested Devices】

**1.Honor Hunter V700**
- Type：NoteBook
- GPU：GTX 1660Ti
- CPU：i5-10300H
- RAM：16G
- Sys：Win10
- Res：<=1920*1080


## 【收藏趋势 Stargazers over time】

[![Stargazers over time](https://starchart.cc/Spartan711/Genshin-to-Honkai-PC-Control-Project.svg)](https://starchart.cc/Spartan711/Genshin-to-Honkai-PC-Control-Project)

- [点击前往作者B站主页](https://space.bilibili.com/359461611)
