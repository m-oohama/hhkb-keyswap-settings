#Requires AutoHotkey v2
; キーリスト https://ahkscript.github.io/ja/docs/v2/KeyList.htm
; ■ 修飾キー
;  # Windows
;  ^ Control
;  ! Alt
;  + Shift
;  < 左側のキー限定
;  > 右側のキー限定
;  * ワイルドカード
;  ~ 本来の機能を維持
;  $ ループ防止
;  & キー結合

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 英吾配列に変更
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Line #1
+2::@
+6::^
+7::&
+8::*
+9::(
+0::)
+-::_
 ^::=
+^::+
 F19::`
+F19::~
; Line #2
 @::[
 [::]
; Line #3
+vkBB::vkBA ; + を :
 vkBA::'    ; : を '
+vkBA::"    ; * を "
+Backspace::Delete
; Line #4
; キー変換なし
; Line #5
; キー変換なし

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; その他のキー
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
!4::Send "!{F4}"
+F7::F8
+F10::F9
F17::ShowHHKBBootCampStatus()       
TapHoldManager(100, 200, 3).Add("LAlt", TapDanceAlt)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; マクロ
;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ShowHHKBBootCampStatus() {
    static ini := "logs\hhkb_boot_camp.ini"
    static ini_section := "cursor_key"
    static ini_total_key := "total_clicked"
    today := FormatTime(, "yyyyMMdd")
    yesterday := FormatTime(DateAdd(A_Now, -1, "Days"), "yyyyMMdd")
    ini_today_key := today . "_clicked"
    ini_yesterday_key := yesterday . "_clicked"
    try {   
        totalClickedCount := Number(IniRead(ini, ini_section, ini_total_key, 0))
        dailyClickedCount := Number(IniRead(ini, ini_section, ini_today_key, 0))
        yesterdayClickedCount := Number(IniRead(ini, ini_section, ini_yesterday_key, 0))
    } catch {
        totalClickedCount := 0
        dailyClickedCount := 0
    }

    totalClickedCount += 1
    dailyClickedCount += 1
    IniWrite(totalClickedCount, ini, ini_section, ini_total_key)
    IniWrite(dailyClickedCount, ini, ini_section, ini_today_key)
    diff := dailyClickedCount - yesterdayClickedCount

    msg := Format("total: {1} today: {2} ({3})",
        totalClickedCount,
        dailyClickedCount,
        ((diff > 0) ? "+" : "-") . ((diff = 0) ? "" : Abs(diff))
    )
    TrayTip msg, "Oops! clicked key won't work", 4
    Sleep 2500
    TrayTip
}

#Include Lib\TapHoldManager.ahk
TapDanceAlt(isHold, taps, state) {
    if (isHold) {
        if (state) {
            Send("{LAlt Down}")
        } else {
            Send("{LAlt Up}")
        }
    } else {
        if (state) {
            switch taps {
                case 1: Send("#+0") ; Win + Shift + 0
                case 2: Send("#^0") ; Win + Ctrl + 0
                case 3: Send("#!0") ; Win + Alt + 0
            }
        }
    }
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 初回起動処理
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TrayTip "キースワップを適用しました。", "AHK_for_HHKB_en", 4
Sleep 5000
TrayTip()