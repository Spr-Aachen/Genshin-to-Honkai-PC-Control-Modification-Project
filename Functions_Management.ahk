;---------------------------------------------------------------------------------------------------------------------------------------------------------------
; 这里用于存放控制功能相关的函数
;---------------------------------------------------------------------------------------------------------------------------------------------------------------


;【函数 Function】屏幕检测
ScreenDetect()
{
    If WinActive("ahk_exe BH3.exe")
    {
        WinGetPos, X, Y, W, H, ahk_exe BH3.exe
        ClientUpperLeftCorner_X := X
        ClientUpperLeftCorner_Y := Y
        Client_Width := W
        Client_Height := H

        If (Client_Width / Client_Height == 1920 / 1080)
        { ; 默认数值源于1920*1080分辨率下的测试结果
            DetectionPerPixel_Width := 100 * 2 / 3840
            DetectionPerPixel_Height := 70 * 2 / 2160
            UpperLeftCorner_X := ClientUpperLeftCorner_X
            UpperLeftCorner_Y := ClientUpperLeftCorner_Y
            LowerRightCorner_X := UpperLeftCorner_X + Round(DetectionPerPixel_Width * Client_Width)
            LowerRightCorner_Y := UpperLeftCorner_Y + Round(DetectionPerPixel_Height * Client_Height)
            LowerRightCorner_X2 := ClientUpperLeftCorner_X + Client_Width
            LowerRightCorner_Y2 := ClientUpperLeftCorner_Y + Client_Height
            UpperLeftCorner_X2 := LowerRightCorner_X2 - Round(DetectionPerPixel_Width * Client_Width)
            UpperLeftCorner_Y2 := LowerRightCorner_Y2 - Round(DetectionPerPixel_Height * Client_Height)
            Switch Client_Height
            {
                Case "720": ; [未测试 untested]（ +  +  + 颜色相似二值化100% + ）
                    Icon := 
                    Icon .= 
                    Icon .= 
                    Icon .= "|<ElysiumLobbyIcon_UpperLeft>0xFFFFFF@1.00$15.0080300s0D03s0z0Ds3v0y8DU3s0y0DU3s0y07k0T01w07k0T01w07l0T81z07s0T01s0700M01U"
                    Icon .= 

                Case "900": ; [已测试 tested]（颜色相似二值化100% + 颜色相似二值化96% + 颜色相似二值化96% + 颜色相似二值化100% + ）
                    Icon := "|<CombatSceneIcon_Normal>0x313131@1.00$25.200810043s0DXy0Dtz07xzk7zzs3zzw1zzy0zzz0TzzUDzzk7zzs3zzw1zzy0zzz0TzzUDzzk7zzs3zzw1zzy0zzz0TzzUDzzk7zzs3zzw1zrw0Tny0Dsy03s400EU"
                    Icon .= "|<CombatSceneIcon_LowHealth_A>0x422A2A@0.96$25.700Q3U0C7w0Tny0DvzUDzzk7zzs3zzw1zzy0zzz0TzzUDzzk7zzs3zzw1zzy0zzz0TzzUDzzk7zzs3zzw1zzy0zzz0TzzUDzzk7zzs3zzw1zzy0zvy0Dtz07wC00sU"
                    Icon .= "|<CombatSceneIcon_LowHealth_B>0x542222@0.96$25.700Q3U0T7w0Tny0DvzUDzzk7zzs3zzw1zzy0zzz0TzzUDzzk7zzs3zzw1zzy0zzz0TzzUDzzk7zzs3zzw1zzy0zzz0TzzUDzzk7zzs3zzw1zzy0zvy0Dtz07wC00sU"
                    Icon .= "|<ElysiumLobbyIcon_UpperLeft>0xFFFFFF@1.00$18.00100300300700D00z01z01z03n0710S00w00w01s03U0D00S00S00y00S00D003U03U01s00w00S007107103l01z00z00D00D007003001U"
                    Icon .= 

                Case "1440": ; [已测试 tested]（颜色相似二值化100% + 颜色相似二值化96% + 颜色相似二值化96% + 颜色相似二值化100% + 颜色相似二值化96%）
                    Icon := "|<CombatSceneIcon_Normal>0x313131@1.00$40.3w000z0Ds007w3zk00zwDz003zkzw00DzDzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzDz003zkzw00Dz3zk00zw3y001z0Dk003w8"
                    Icon .= "|<CombatSceneIcon_LowHealth_A>0x422A2A@0.96$40.1s000S07U001s3zk00zwDz003zkzy00TzDzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzwzy00Tz3zk00zwDz003zk7U001s0S0007UU"
                    Icon .= "|<CombatSceneIcon_LowHealth_B>0x522323@0.96$40.1s000S07U001s3zk00zwDz003zkzy00TzDzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzzzz00zzzzw03zzzzk0Dzwzy00Tz3zk00zwDz003zk7U001s0S0007UU"
                    Icon .= "|<ElysiumLobbyIcon_UpperLeft>0xFFFFFF@1.00$29.00002000040000s0001k000DU000T0003y0007w000zs001zk00DzU00Tz003wC007sQ00z0801y0E0Dk000TU003w0007s000z0001y000Dk000TU003w0007s000z0001y000Dw000Ts000Dk000TU000Dk000TU000Dk000TU000Dk000TU000Dk000TU000Dk000TU000Dk200TU400Dk800TUE00DzU00Tz000Dy000Tw000Ds000Tk000DU000T0000C0000Q000080000M"
                    Icon .= "|<ElysiumLobbyIcon_LowerRight>0xACACAD@0.96$1.y"

                Case "2160": ; [已测试 tested]（颜色相似二值化100% + 颜色相似二值化96% + 颜色相似二值化95% + 颜色相似二值化100% + 颜色相似二值化100%）
                    Icon := "|<CombatSceneIcon_Normal>0x313131@1.00$60.07U00001s00zw0000Dz00zw0000Dz03zz0000zzk3zz0000zzk3zz0000zzk7zz0000zzs7zzU001zzszzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzzzzzk003zzz7zzU001zzs7zz0000zzs3zz0000zzk3zz0000zzk3zz0000zzk0zw0000Dz00zw0000Dz007U00001s0U"
                    Icon .= "|<CombatSceneIcon_LowHealth_A>0x412A2A@0.96$60.0DU00001w00DU00001w00Tk00003y03zy0000Tzk7zz0000zzs7zz0000zzs7zzU001zzsDzzU001zzwzzzk003zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzk003zzzDzzU001zzw7zzU001zzs7zz0000zzs7zz0000zzs3zy0000Tzk0Tk00003y00Dk00003w00DU00001w0U"
                    Icon .= "|<CombatSceneIcon_LowHealth_B>0x522323@0.95$60.0Dk00003w00Dk00003w00Ts00007y03zz0000zzk7zz0000zzs7zzU001zzs7zzU001zzsDzzk003zzwzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzzzzs007zzzDzzk003zzw7zzU001zzs7zzU001zzs7zz0000zzs3zz0000zzk0Ts00007y00Dk00003w00Dk00003w0U"
                    Icon .= "|<ElysiumLobbyIcon_UpperLeft>0xFFFFFF@1.00$44.0000000k000000A00000030000007k000001w000000T000000zk00000Dw000003z000007zk00001zw00000Tz00000zzk0000Dzw00003zz00007zzk0001zzw0000Tzz0000zzzk000Dz1w0003zkT0007zw7k001zs0A000Ty03000zzU0k00Dz000003zk00007zw00001zs00000Ty00000zzU0000Dz000003zk00007zw00001zs00000Ty00000zzU0000Dz000003zk00007zw00001zs00000Ty00000zzU0000Dzs00003zy00000zzU00001zs00000Ty000007zw00000Dz000003zk00000zzU00001zs00000Ty000007zw00000Dz000003zk00000zzU00001zs00000Ty000007zw00000Dz000003zk00000zzU0k001zs0A000Ty030007zw0k000Dz0A0003zk30000zzzk0001zzw0000Tzz00007zzk0000Dzw00003zz00000zzk00001zw00000TzU"
                    Icon .= "|<ElysiumLobbyIcon_LowerRight>0xD4D4D4@1.00$3.zzzw"

                Default:     ; [已测试 tested]（颜色相似二值化100% + 颜色相似二值化96% + 颜色相似二值化95% + 颜色相似二值化100% + 颜色相似二值化100%）
                    Icon := "|<CombatSceneIcon_Normal>0x313131@1.00$30.7k03sDs07wDs07wDs07wzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0DzDs07wDs07wDs07w7k03sU"
                    Icon .= "|<CombatSceneIcon_LowHealth_A>0x422A2A@0.96$30.3U01k3U01kDs07wDs07wTw0Dyzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0DzTw0DyDs07wDs07w3U01kU"
                    Icon .= "|<CombatSceneIcon_LowHealth_B>0x532222@0.95$30.3U01k3U01kDs07wTs07yzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0Dzzw0DzTs07yDs07w3U01kU"
                    Icon .= "|<ElysiumLobbyIcon_UpperLeft>0xFFFFFF@1.00$22.0004000k003000w007k00T007w00zk03z00yA07UE0S107k00w003k00y007U00S007k00w003k00z000w003k007k007U00S000y000w003k007k007UE0S100y400zk03z007w007k00T000w000k0030006"
                    Icon .= "|<ElysiumLobbyIcon_LowerRight>0xD4D4D4@1.00$1.s"
            }
        }

        Else If (Client_Width / Client_Height == 1360 / 768)
        { ; 默认数值源于1360*768分辨率下的测试结果
            DetectionPerPixel_Width := 38 * 2 / 1360
            DetectionPerPixel_Height := 25 * 2 / 768
            UpperLeftCorner_X := ClientUpperLeftCorner_X
            UpperLeftCorner_Y := ClientUpperLeftCorner_Y
            LowerRightCorner_X := UpperLeftCorner_X + Round(DetectionPerPixel_Width * Client_Width)
            LowerRightCorner_Y := UpperLeftCorner_Y + Round(DetectionPerPixel_Height * Client_Height)
            LowerRightCorner_X2 := ClientUpperLeftCorner_X + Client_Width
            LowerRightCorner_Y2 := ClientUpperLeftCorner_Y + Client_Height
            UpperLeftCorner_X2 := LowerRightCorner_X2 - Round(DetectionPerPixel_Height * Client_Width)
            UpperLeftCorner_Y2 := LowerRightCorner_Y2 - Round(DetectionPerPixel_Height * Client_Height)
            Switch Client_Height
            {
                Case "":

                Default:     ; [已测试 tested]（颜色相似二值化100% + 颜色相似二值化96% + 颜色相似二值化95% + 颜色相似二值化100% + 颜色相似二值化96%）
                    Icon := "|<CombatSceneIcon_Normal>0x313131@1.00$21.4003s1yT0Drw1zzUDzw1zzUDzw1zzUDzw1zzUDzw1zzUDzw1zzUDzw1zzUDzw1zzUDzw1zzUDvs1yT0Dlk0wU"
                    Icon .= "|<CombatSceneIcon_LowHealth_A>0x402A2A@0.96$21.A033k0wT0Drw1zzUTzw3zzUTzw3zzUTzw3zzUTzw3zzUTzw3zzUTzw3zzUTzw3zzUTzw3zzUTzw3zzUDvs1yT0DlU0MU"
                    Icon .= "|<CombatSceneIcon_LowHealth_B>0x522323@0.95$21.A033s0wT0Drw3zzUTzw3zzUTzw3zzUTzw3zzUTzw3zzUTzw3zzUTzw3zzUTzw3zzUTzw3zzUTzw3zzUTzs1yT0DlU0MU"
                    Icon .= "|<ElysiumLobbyIcon_UpperLeft>0xFFFFFF@1.00$15.0080100M0701s0T0781k0w0D03k0s0C03U0w03U0C00s07U0S01s07U0C00s03s0D00s0300A"
                    Icon .= "|<ElysiumLobbyIcon_LowerRight>0xD4D4D4@0.96$5.w000T000V25so"
            }
        }

        Else If (Client_Width / Client_Height == 1440 / 900)
        { ; 默认数值源于1440*900分辨率下的测试结果
            DetectionPerPixel_Width := 40 * 2 / 1440
            DetectionPerPixel_Height := 27 * 2 / 900
            UpperLeftCorner_X := ClientUpperLeftCorner_X
            UpperLeftCorner_Y := ClientUpperLeftCorner_Y
            LowerRightCorner_X := UpperLeftCorner_X + Round(DetectionPerPixel_Width * Client_Width)
            LowerRightCorner_Y := UpperLeftCorner_Y + Round(DetectionPerPixel_Height * Client_Height)
            LowerRightCorner_X2 := ClientUpperLeftCorner_X + Client_Width
            LowerRightCorner_Y2 := ClientUpperLeftCorner_Y + Client_Height
            UpperLeftCorner_X2 := LowerRightCorner_X2 - Round(DetectionPerPixel_Width * Client_Width)
            UpperLeftCorner_Y2 := LowerRightCorner_Y2 - Round(DetectionPerPixel_Height * Client_Height)
            Switch Client_Height
            {
                Case "":

                Default:     ; [已测试 tested]（颜色相似二值化100% + 颜色相似二值化96% + 颜色相似二值化95% + 颜色相似二值化100% + 颜色相似二值化96%）
                    Icon := "|<CombatSceneIcon_Normal>0x313131@1.00$22.D03lw0Dbk1yzU7zy0Tzs1zzU7zy0Tzs1zzU7zy0Tzs1zzU7zy0Tzs1zzU7zy0Tzs1zzU7zy0Tzs1zzU7xy0Tbk0yD03m"
                    Icon .= "|<CombatSceneIcon_LowHealth_A>0x432929@0.96$22.601Vw0Tbs1yzU7zy0Tzs1zzU7zy0Tzs1zzU7zy0Tzs1zzU7zy0Tzs1zzU7zy0Tzs1zzU7zy0Tzs1zzU7zy0Tzs1zTU7tw0TVU0MU"
                    Icon .= "|<CombatSceneIcon_LowHealth_B>0x542222@0.95$22.601Vw0Tbs1yzU7zy0Tzs1zzU7zy0Tzs1zzU7zy0Tzs1zzU7zy0Tzs1zzU7zy0Tzs1zzU7zy0Tzs1zzU7zy0Tzs1zzU7xy0TXU0QU"
                    Icon .= "|<ElysiumLobbyIcon_UpperLeft>0xFFFFFF@1.00$16.00400k0300Q03k0T03w0Qk3V0w07U0S03k0Q03U0Q03k0700C00Q01s03k07U0D00C40QE0z01w03k0D00Q00k01U"
                    Icon .= "|<ElysiumLobbyIcon_LowerRight>0xD4D4D4@0.96$4.s000w01aNiu"
            }
        }

        Else If (Client_Width / Client_Height == 1680 / 1050)
        { ; 默认数值源于1680*1050分辨率下的测试结果
            DetectionPerPixel_Width := 50 * 2 / 1680
            DetectionPerPixel_Height := 30 * 2 / 1050
            UpperLeftCorner_X := ClientUpperLeftCorner_X
            UpperLeftCorner_Y := ClientUpperLeftCorner_Y
            LowerRightCorner_X := UpperLeftCorner_X + Round(DetectionPerPixel_Width * Client_Width)
            LowerRightCorner_Y := UpperLeftCorner_Y + Round(DetectionPerPixel_Height * Client_Height)
            LowerRightCorner_X2 := ClientUpperLeftCorner_X + Client_Width
            LowerRightCorner_Y2 := ClientUpperLeftCorner_Y + Client_Height
            UpperLeftCorner_X2 := LowerRightCorner_X2 - Round(DetectionPerPixel_Width * Client_Width)
            UpperLeftCorner_Y2 := LowerRightCorner_Y2 - Round(DetectionPerPixel_Height * Client_Height)
            Switch Client_Height
            {
                Case "":

                Default:     ; [未测试 untested]（颜色相似二值化100% + 颜色相似二值化95% + 颜色相似二值化95% + 颜色相似二值化100% + 颜色相似二值化95%）
                    Icon := "|<CombatSceneIcon_Normal>0x313131@1.00$27.7U0D1y03wDk0TVy03wzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zDk0TVy03w7U0D4"
                    Icon .= "|<CombatSceneIcon_LowHealth_A>0x422A2A@0.95$27.30061y03wTk0zbz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zTs0zly03w7U0D0M00kU"
                    Icon .= "|<CombatSceneIcon_LowHealth_B>0x512323@0.95$27.30061y03wTk0zbz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zzs0zzz07zTs0zly03w7U0D0M00kU"
                    Icon .= "|<ElysiumLobbyIcon_UpperLeft>0xFFFFFF@1.00$19.000U00E00s00w00y00T00zU0wE0w00S00w00w00w01w00w00w00w01y00z007U01s00S00D001s00S007U03k00S007U01z00zU07k01s00Q006001U"
                    Icon .= "|<ElysiumLobbyIcon_LowerRight>0xD4D4D4@0.95$13.k0M0A0703zzk0k0M0A060n0NUAk6M3Dzbzk0N"
            }
        }

        Else If (Client_Width / Client_Height == 2560 / 1080)
        { ; 默认数值源于2560*1080分辨率下的测试结果
            DetectionPerPixel_Width := 100 * 2 / 2560 ;- 33 * 2 / 2560
            DetectionPerPixel_Height := 36 * 2 / 1080
            UpperLeftCorner_X := ClientUpperLeftCorner_X ;+ 33 * Client_Width / 2560
            UpperLeftCorner_Y := ClientUpperLeftCorner_Y
            LowerRightCorner_X := UpperLeftCorner_X + Round(DetectionPerPixel_Width * Client_Width)
            LowerRightCorner_Y := UpperLeftCorner_Y + Round(DetectionPerPixel_Height * Client_Height)
            LowerRightCorner_X2 := ClientUpperLeftCorner_X + Client_Width ;- 30 * Client_Width / 2560
            LowerRightCorner_Y2 := ClientUpperLeftCorner_Y + Client_Height
            UpperLeftCorner_X2 := LowerRightCorner_X2 - Round(DetectionPerPixel_Width * Client_Width)
            UpperLeftCorner_Y2 := LowerRightCorner_Y2 - Round(DetectionPerPixel_Height * Client_Height)
            Switch Client_Height
            { 
                Case "":

                Default:     ; [已测试 tested]（颜色相似二值化100% + 颜色相似二值化90% + 颜色相似二值化100% + 颜色相似二值化90% + [待重测]颜色相似二值化99% + 颜色相似二值化100%）
                    Icon := "|<CombatSceneIcon_Normal>0x313131@1.00$31.7k01w7y01z3z00zVzU0Tvzs0Tzzw0Dzzy07zzz03zzzU1zzzk0zzzs0Tzzw0Dzzy07zzz03zzzU1zzzk0zzzs0Tzzw0Dzzy07zzz03zzzU1zzzk0zzzs0Tzzw0Dzzy07zzz03zzzU1zzzk0zzzs0Tzzw0DzDw03z7y01z1y00TUy00DW"
                    Icon .= "|<CombatSceneIcon_LowHealth_A>0x412A2A@0.96$31.1U00s1k00Q3z00zVzU0Ttzs0Txzw0Dzzy07zzz03zzzU1zzzk0zzzs0Tzzw0Dzzy07zzz03zzzU1zzzk0zzzs0Tzzw0Dzzy07zzz03zzzU1zzzk0zzzs0Tzzw0Dzzy07zzz03zzzU1zzzk0zzzs0Tzzw0Dzzy07zzz03zzzU1ztzU0zszk0DwTs07w3U00sE"
                    Icon .= "|<CombatSceneIcon_LowHealth_B>0x4B2626@0.96$31.1U00s1k00Q3z00zVzU0Ttzs0Txzw0Dzzy07zzz03zzzU1zzzk0zzzs0Tzzw0Dzzy07zzz03zzzU1zzzk0zzzs0Tzzw0Dzzy07zzz03zzzU1zzzk0zzzs0Tzzw0Dzzy07zzz03zzzU1zzzk0zzzs0Tzzw0Dzzy07zzz03zzzU1zvzU0zszk0DwTs07w3U00sE"
                    Icon .= "|<ElysiumLobbyIcon_UpperLeft>0xFFFFFF@1.00$22.0004000k003000w007k00T007w00zk03z00yA07UE0S107k00w003k00y007U00S007k00w003k00z000w003k007k007U00S000y000w003k007k007UE0S100y400zk03z007w007k00T000w000k0030006"
                    Icon .= "|<ElysiumLobbyIcon_LowerRight>0xD4D4D4@1.00$11.ztzk000000001zzzs00000000k1U3060A0NznzU38"
            }
        }

        Else
        { ; 其它比率尚未测试
            ;MsgBox, 4,, 请检查当前是否为全屏模式或支持的分辨率！
            ;ExitApp
        }
    }
}


;【函数 Function】自动控制
AutoScale()
{
    If WinActive("ahk_exe BH3.exe")
    {
        Try
        {
            If (!Toggle_ScreenDetect)
            {
                Toggle_ScreenDetect := !Toggle_ScreenDetect
                ;ScreenDetect()
                SetTimer, ScreenDetect, %Timer_ScreenDetect%
            }
        }

        Finally
        {
            If (FindText(X, Y, UpperLeftCorner_X, UpperLeftCorner_Y, LowerRightCorner_X, LowerRightCorner_Y, %FaultTolerance_CombatScene_Normal_T%, %FaultTolerance_CombatScene_Normal_B%, Icon)[1].id == "CombatSceneIcon_Normal" || FindText(X, Y, UpperLeftCorner_X, UpperLeftCorner_Y, LowerRightCorner_X, LowerRightCorner_Y, %FaultTolerance_CombatScene_LowHealth_T%, %FaultTolerance_CombatScene_LowHealth_B%, Icon)[1].id == "CombatSceneIcon_LowHealth_A" || FindText(X, Y, UpperLeftCorner_X, UpperLeftCorner_Y, LowerRightCorner_X, LowerRightCorner_Y, %FaultTolerance_CombatScene_LowHealth1%, %FaultTolerance_CombatScene_LowHealth2%, Icon)[1].id == "CombatSceneIcon_LowHealth_B")
            {
                If (!Status_CombatIcon)
                {
                    Status_CombatIcon := !Status_CombatIcon
                }
                If (!Toggle_ManualSuspend)
                {
                    If(A_IsSuspended)
                    {
                        If (!Status_Occlusion)
                            Occlusion(Status_Occlusion := !Status_Occlusion)
                        If (!Toggle_MouseFunction)
                        {
                            Toggle_MouseFunction := !Toggle_MouseFunction
                            If (!Toggle_Restriction)
                                CoordReset()
                            Else If (!Status_Restriction)
                                Status_Restriction := !Status_Restriction
                            ViewControl_Mod := "Mod1"
                            SetTimer, ViewControl, %Timer_ViewControl%
                        }
                        Suspend, Off
                    }
                }
            }
            Else
            {
                If (Status_CombatIcon)
                {
                    Status_CombatIcon := !Status_CombatIcon
                }
                If (!A_IsSuspended)
                {
                    Suspend, On
                    If (Toggle_MouseFunction)
                    {
                        If (Status_Restriction)
                            Status_Restriction := !Status_Restriction
                        SetTimer, ViewControl, Delete
                        If GetKeyState(Key_SecondSkill, "P")
                            BreakFlag_Aim := !BreakFlag_Aim
                        InputReset()
                        Toggle_MouseFunction := !Toggle_MouseFunction
                    }
                    If (Status_Occlusion)
                        Occlusion(Status_Occlusion := !Status_Occlusion)
                }
                Else If (!Toggle_ManualSuspend)
                {
                    If (FindText(X, Y, UpperLeftCorner_X, UpperLeftCorner_Y, LowerRightCorner_X, LowerRightCorner_Y, %FaultTolerance_ElysiumLobby_T%, %FaultTolerance_ElysiumLobby_B%, Icon)[1].id == "ElysiumLobbyIcon_UpperLeft" && FindText(X, Y, UpperLeftCorner_X2, UpperLeftCorner_Y2, LowerRightCorner_X2, LowerRightCorner_Y2, %FaultTolerance_ElysiumLobby_T%, %FaultTolerance_ElysiumLobby_B%, Icon)[1].id == "ElysiumLobbyIcon_LowerRight")
                    {
                        If (!Toggle_MouseFunction)
                        {
                            Toggle_MouseFunction := !Toggle_MouseFunction
                            CoordReset()
                            ;If (!Status_Restriction)
                                ;Status_Restriction := !Status_Restriction
                            ViewControl_Mod := "Mod2"
                            SetTimer, ViewControl, %Timer_ViewControl%
                        }
                    }
                    Else
                    {
                        If (Toggle_MouseFunction)
                        {
                            ;If (Status_Restriction)
                                ;Status_Restriction := !Status_Restriction
                            SetTimer, ViewControl, Delete
                            InputReset()
                            Toggle_MouseFunction := !Toggle_MouseFunction
                        }
                    }
                }
            }
        }
    }

    Else
    {
        InputReset()
    }
    
    Return "Done"
}


; 【函数 Function】手动暂停
ManualSuspend()
{
    If (!Toggle_ManualSuspend)
    {
        Toggle_ManualSuspend := !Toggle_ManualSuspend
        Suspend, On
        If (Toggle_AutoScale)
        {
            SetTimer, AutoScale, Delete
            Try
            {
                SetTimer, ScreenDetect, Delete
                Toggle_ScreenDetect := False
            }
            If (Toggle_MouseFunction)
            {
                If (Status_Restriction)
                    Status_Restriction := !Status_Restriction
                SetTimer, ViewControl, Delete
                If GetKeyState(Key_SecondSkill, "P")
                    BreakFlag_Aim := !BreakFlag_Aim
                InputReset()
                Toggle_MouseFunction := !Toggle_MouseFunction
            }
            If (Status_Occlusion)
                Occlusion(Status_Occlusion := !Status_Occlusion)
            If (Status_CombatIcon)
            {
                SendEvent, {Esc}
                Status_CombatIcon := !Status_CombatIcon
            }
        }
        Else If (Toggle_MouseFunction)
        {
            SetTimer, ViewControl, Delete
            If GetKeyState(Key_SecondSkill, "P")
                BreakFlag_Aim := !BreakFlag_Aim
            InputReset()
            Toggle_MouseFunction := !Toggle_MouseFunction
        }
        ToolTip, 暂停中 Suspended, 0, 999 ;ToolTip, %暂停中%, 0, 999 ; [可调校数值 adjustable parameters] Variable isn't working
    }
    Else ;If GetKeyState(Key_Suspend, "P")
    {
        If (Toggle_AutoScale)
        {
            SetTimer, AutoScale, %Timer_AutoScale%
            Loop
            {
                Sleep, 1
            } Until AutoScale() == "Done"
            If (Status_CombatIcon)
            {
                If (!Status_Occlusion)
                    Occlusion(Status_Occlusion := !Status_Occlusion)
                If (!Toggle_MouseFunction)
                {
                    Toggle_MouseFunction := !Toggle_MouseFunction
                    If (!Toggle_Restriction)
                        CoordReset()
                    Else If (!Status_Restriction)
                        Status_Restriction := !Status_Restriction
                    ViewControl_Mod := "Mod1"
                    SetTimer, ViewControl, %Timer_ViewControl%
                }
            }
        }
        Else If (!Toggle_MouseFunction)
        {
            Toggle_MouseFunction := !Toggle_MouseFunction
            If (!Toggle_Restriction)
                CoordReset()
            Else If (!Status_Restriction)
                Status_Restriction := !Status_Restriction
            ViewControl_Mod := "Mod1"
            SetTimer, ViewControl, %Timer_ViewControl%
        }
        Suspend, Off
        Toggle_ManualSuspend := !Toggle_ManualSuspend
        ToolTip, 已启用 Continued, 0, 999 ;ToolTip, %已启用%, 0, 999 ; [可调校数值 adjustable parameters] Variable isn't working
        Sleep 210 ; [可调校数值 adjustable parameters]
        ToolTip
    }
}


;---------------------------------------------------------------------------------------------------------------------------------------------------------------