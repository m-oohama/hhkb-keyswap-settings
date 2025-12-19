#Requires AutoHotkey v2
; キーリスト https://ahkscript.github.io/ja/docs/v2/KeyList.htm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 英吾配列に変更
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; #1
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
; #2
@::[
[::]
; #3
 vkBB::vkBB ; ; を ;
+vkBB::vkBA ; + を :
 vkBA::'    ; : を '
+vkBA::"    ; * を "
; #4
; キー変換なし

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; その他のキー
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
!4::Send "!{F4}"
+Backspace::Send "{Delete}"
F18::Run "C:\Program Files (x86)\PFU\Happy Hacking Keyboard Studio Keymap Tool\HHKBStudioKeymapTool.exe", "C:\Program Files (x86)\PFU\Happy Hacking Keyboard Studio Keymap Tool"
+F7::F8
+F10::F9
F17::ShowHHKBBootCampStatus()

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; マクロ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 初回起動処理
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TrayTip "キースワップを適用しました。", "AHK_for_HHKB_en", 4
Sleep 5000
TrayTip()