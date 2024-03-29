﻿﻿<div align="center">

# 📢 这个项目已停止维护 📢<br>This repo is no longer maintained

</div>

本项目永久停止更新维护，感谢大家一直以来的支持和鼓励！<br>
This repository is no longer maintained. I would like to thank the people who supported me all the time. Thank you all.<br>


<div align="center">

# 崩坏3仿原神PC端键鼠操控<br>Genshin to Honkai PC Control Modification Project

[![Releases](https://img.shields.io/github/v/release/Spr-Aachen/Genshin-to-Honkai-PC-Control-Modification-Project?color=green&label=Release&logo=Github&logoColor=white&style=flat-square)](https://github.com/Spr-Aachen/Genshin-to-Honkai-PC-Control-Modification-Project/releases)
[![Bilibili](https://img.shields.io/badge/Bilibili-v0.3.0%20Intro-blue?logo=Bilibili&style=flat-square)](https://www.bilibili.com/video/BV1DY4y1T7aS)
[![YouTube](https://img.shields.io/badge/YouTube-v0.4.3%20Intro-red?logo=YouTube&style=flat-square)](https://www.youtube.com/watch?v=_Z7MmzOzj2c)

</div>

本项目以AHK为基础语言进行编译。由于这仅是一个出自编程菜鸟之手的半成品，是故望乞诸位海涵。干杯！ - ( ゜- ゜)つロ
<br>The project is basicly built with AutoHotkey. Please remind that this is a WIP (work in progress) stuff and I'm totally a noob in coding. So... hope you guys won't push me too hard. Cheers!


## 【注意 Caution】

1. 请确保客户端为官方提供的PC端而非模拟器
<br>   Please ensure that the client you're using is served by MiHoYo official

2. 请确保游戏操作设置已重置为默认键位
<br>   Please ensure that the gaming operation settings have been reset to default

3. 请使用全屏模式游玩以确保自动识别的正常运行
<br>   Please use fullscreen mode in order for `Automatic Identification` function to run properly

<br>支持与不支持的客户端分辨率如下：（ 	:grey_exclamation: 表示未经测试）
<br>Supported&unsupported client resolution is shown as follows: ( 	:grey_exclamation: means untested)

| 分辨率 Resolution | 支持 Support |
| ----------------- | ----------- |
| 3840 x 2160       | :heavy_check_mark:          |
| 2560 x 1600       | :grey_exclamation:          |
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

<br>如果您的设备分辨率不在以上支持列表内，可以尝试更改系统分辨率并在游戏中选择对应的全屏模式来使自动识别生效
<br>If your device's screen resolution is not shown in the table above, you can try changing the system resolution and select the corresponding res with fullscreen mode in game settings to make `Automatic Identification` take effect.


## 【设定 Configurations】

### 键位 - 预设<br>Keymaps - Preset

以下键位会在战斗状态下生效且和原神PC端的默认键位设置较为相近（但注意瞄准模式的设定有所不同）
<br>The following keymaps would take effect in combat, and they're pretty much close to the default settings from Genshin Impact (but mind that there's a little difference between those two's aiming mode)

**Q键发动主技能（大招） Q key for main skill**
<br>使用方法：点按或长按Q键[可改]
<br>Usage: Press or long press `Q key`[Adjustable]

**E键发动副技能（武器技）/后崩坏书主技能（大招） E key for second skill(weapon skill)/APHO(A Post-Honkai Odyssey) main skill**
<br>使用方法：点按或长按E键[可改]
<br>特殊设定：在长按E键进入瞄准模式后，可通过移动鼠标来操控准星
<br>Usage: Press or long press `E key`[Adjustable]
<br>Extra: After entering the aiming mode by long pressing `E key`, cross hair can be controled by the mouse-movement

**Z键发动人偶技能/后崩坏书白热化状态（月之环） Z key for doll skill/APHO(A Post-Honkai Odyssey) white heat**
<br>使用方法：按下Z键[可改]
<br>Usage: Press down (Long press) `Z key`[Adjustable]

**左侧Shift键或鼠标右键发动闪避/冲刺 LShift or RButton for dodging/dashing**
<br>使用方法：点击或长按左侧Shift键/鼠标右键[可改]
<br>Usage: Press (Click) or long press `LShift`/`RButton`[Adjustable]

**鼠标左键发动普攻 LButton for normal attack**
<br>使用方法：点击或长按鼠标左键[可改]
<br>Usage: Press (Click) or long press `LButton`[Adjustable]

尽管已经能自动分辨战斗与其它场景，但在出现意外情况时仍可以通过以下键位进行手动控制
<br>Although the combat scene can be automaticly identified, the following keys can still be needed for manual control especially when exceptions occured

**左侧Alt键+鼠标左键以正常使用点击功能 LAlt+LButton for left-click function**
<br>使用方法：按住左侧Alt键后点击鼠标左键[不可改]
<br>Usage: Press down (Long press) `LAlt` and then click `LButton`[Unadjustable]

**鼠标中键管理视角跟随功能 MButton for view-control function management**
<br>使用方法：点击鼠标中键[可改]
<br>特殊设定：关闭/激活时屏幕左下角有状态栏提示
<br>Usage: Click `MButton`[Adjustable]
<br>Extra: Tooltips will show up in the left lower corner of the screen when turning off/turning on the function

**F1键暂停/启用程序 F1 key for program suspending/continuing**
<br>使用方法：按下F1键[可改]
<br>特殊设定：暂停/启用时屏幕左下角有状态栏提示
<br>Usage: Press down (Long press) `F1 key`[Adjustable]
<br>Extra: Tooltips will show up in the left lower corner of the screen when suspending/continuing the program

**F3键重启程序 F3 key for program reloading**
<br>使用方法：按下F3键[可改]
<br>Usage: Press down (Long press) `F3 key`[Adjustable]

### 键位 - 更改 <br>Keymaps - Customization

启动界面的键位栏中允许手动更改默认键位且不同控制器的设置如下：
<br>The `Keymap Tab` which located in the startup interface allows users to customize the default keymap, different controllers should be set up as follows:

**键盘 Keyboard**
<br>点击框并按下想要的键盘按键（按Del键或Backspace键可清空框）
<br>Click the `box` and press down the keyboard key you want (pressing `Delete` or `Backspace` would set the box to empty)

**鼠标 Mouse**
<br>点击下拉栏目切换到想要的鼠标按键（选择“无”可置空栏目）
<br>Click the `combobox` to switch to the mouse button you want (choosing `None` would set the combobox to null)

**手柄 GamePad**
<br>暂不支持
<br>Temporarily not supported

### 功能 - 选项<br>Functions - Option

启动界面的功能栏中允许手动选择是否启用以下辅助性选项：
<br>The `Function Tab` which located in the startup interface allows users to choose whether toggle the following options:

**管理员权限（默认启用） Run as Admin (Toggled by default)**
<br>以管理员身份运行程序
<br>Run program as administrator

**全自动识别（默认启用） Automatic Identification (Toggled by default)**
<br>使键位仅在战斗场景生效
<br>Let the keymaps only take effect in combat scene

**可隐藏光标（默认启用） Cursor Occlusion (Toggled by default)**
<br>光标会在战斗场景下自动隐藏，但注意前提是启用了自动识别
<br>Hide cursor automatically while in combat, but mind that this funtion would only work under the premise of toggling the "Automatic Identification"

**限制性光标（默认启用） Cursor Restriction (Toggled by default)**
<br>战斗场景下会将光标限制于安全区域内以避免触发UI
<br>Restrict cursor in a "safe zone" to avoid toggling the UI buttons

### 功能 - 调参<br>Functions - Tuning

启动界面的功能栏中允许手动调节自动识别系统的以下参数：
<br>The `Function Tab` which located in the startup interface allows users to adjust the following params of Automatic Identification:

**正常战斗识别容错率-目标 FT_NormalCombat_Target**
<br>在战斗场景中处于高血量状态时的识别区目标的容错百分率
<br>Fault tolerance percentage of target in combat scene without low health alert

**正常战斗识别容错率-背景 FT_NormalCombat_Background**
<br>在战斗场景中处于高血量状态时的识别区背景的容错百分率
<br>Fault tolerance percentage of background in combat scene without low health alert

**濒危战斗识别容错率-目标 FT_DangerCombat_Target**
<br>在战斗场景中处于低血量状态时的识别区目标的容错百分率
<br>Fault tolerance percentage of target in combat scene with low health alert

**濒危战斗识别容错率-背景 FT_DangerCombat_Background**
<br>在战斗场景中处于低血量状态时的识别区背景的容错百分率
<br>Fault tolerance percentage of background in combat scene with low health alert

**乐土大厅识别容错率-目标 FT_ElysiumLobby_Target**
<br>在往事乐土大厅场景中时的识别区目标的容错百分率
<br>Fault tolerance percentage of target in Elysium Lobby scene

**乐土大厅识别容错率-背景 FT_ElysiumLobby_Background**
<br>在往事乐土大厅场景中时的识别区背景的容错百分率
<br>Fault tolerance percentage of background in Elysium Lobby scene

### 附加设定<br>Addition

1. 战斗场景内使用快捷键AltTab、WinTab进行窗口切换时会自动暂停游戏，按下F1、F3时也是同理（以启用全自动识别为前提）。需要注意的是，为节省资源占用和提高容错率，在执行快速切换后程序亦会自动暂停，故在切回游戏界面后需手动按下F1键以恢复程序运行。
<br>   While switching or rearranging windows by pressing shortcut AltTab or WinTab, the game would automaticly pause, so as the `F1 key` and `F3 key` (Under the premise of toggling the `Automatic Identification`). Notably, the programm would also suspend automaticly after doing quick switch or arrangement in order to lower the usage of system resources. Therefore, to resume the program manually, you need to press F1 key after switching back to the game.

2. ~~新增对往世乐土大厅场景的识别支持（以启用全自动识别为前提）~~
<br>   ~~New scene supported: Elysium Lobby (Under the premise of toggling the `Automatic Identification`)~~

3. ~~精简版去掉了除左键（普攻）外的所有战斗键位~~
<br>   ~~The simplified version removed all the combat keymaps except LButton (which is for normal attack).~~

4. 启动界面的设置栏中可以直接重置当前配置
<br>   Current configuration can be reset from the `Settings Tab` which located in the start-up interface.

5. 在系统托盘处对图标右键可以在“其它”栏目中直接打开或删除配置文件
<br>   By right-clicking on the tray icon and move to the "Else" section, can the configuration file be directly accessed or deleted.


## 【缺陷 Bugs】

1. 目前未知视角缩放的设置键，无法实现该功能
<br>   So far the way to implement camera zooming is still unkown.

2. 视角跟随功能目前仍有延迟等问题，目前正在寻找更优方案
<br>   The view-control function has several problems like lagging. Been looking for better scheme to solve it.

3. 部分win11用户反映程序运行并未生效，目前尚未发现问题所在
<br>   Some Windows 11 system users reported that the programm won't work properly. Unfortunately I can't find out the problem.

4. 全自动识别功能对于硬件性能要求稍高，现已对其进行了数次优化
<br>   The Automatic Identification has a little high demand of hardware performance, though it has been optimized for several times.

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

**2. (Waiting to add other devices)**


## 【收藏趋势 Stargazers over time】

[![Stargazers over time](https://starchart.cc/Spr-Aachen/Genshin-to-Honkai-PC-Control-Modification-Project.svg)](https://starchart.cc/Spr-Aachen/Genshin-to-Honkai-PC-Control-Modification-Project)


## 【联系方式 Contact Details】

[![QQ](https://img.shields.io/badge/QQ-2835946988-brightgreen?style=flat-square&logo=tencent-qq&logoColor=white)]()

倘若大伙儿有什么好的建议欢迎随时叨扰哦~
<br>Please feel free to contact me at any time, any comments and suggestions will be appreciated:)