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
  #+0::#+0  ; Shift + 0 に Hook されるため Shift + Win + 0 を明示的に記述
 #^+0::#^+0 ; Shift + 0 に Hook されるため Ctrl + Shift + Win + 0 を明示的に記述
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
 F17::PushHHKBBootCampNotification()

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; マクロ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/**
 * HHKBブートキャンプの通知を表示し、統計を記録する
 * 矢印キーなどの訓練中の操作発生時に呼び出す想定
 */
PushHHKBBootCampNotification() {
    static logdir := A_ScriptDir "\logs"
    static ini := logdir "\hhkb_boot_camp.ini"
    static ini_section := "cursor_key"
    static ini_total_key := "total_clicked"

    if !DirExist(logdir) {
        DirCreate logdir
    }

    now := A_Now
    today := FormatTime(now, "yyyyMMdd")
    yesterday := FormatTime(DateAdd(now, -1, "Days"), "yyyyMMdd")

    ; 統計の読み込みと更新
    try {
        totalClickedCount := Number(IniRead(ini, ini_section, ini_total_key, 0)) + 1
        dailyClickedCount := Number(IniRead(ini, ini_section, today "_clicked", 0)) + 1
        yesterdayClickedCount := Number(IniRead(ini, ini_section, yesterday "_clicked", 0))
    } catch {
        totalClickedCount := 1
        dailyClickedCount := 1
        yesterdayClickedCount := 0
    }
    IniWrite(totalClickedCount, ini, ini_section, ini_total_key)
    IniWrite(dailyClickedCount, ini, ini_section, today "_clicked")

    ; 前日比の計算
    diff := dailyClickedCount - yesterdayClickedCount
    if (diff > 0) {
        diffStatus := "+" diff
    } else if (diff < 0) {
        diffStatus := String(diff)
    } else {
        diffStatus := "±0"
    }

    ; 通知メッセージの作成
    msg := Format("Total: {1} Today: {2} ({3})",
        totalClickedCount,
        dailyClickedCount,
        diffStatus
    )

    ; 表示と連打防止の待機
    TrayTip msg, "Oops! clicked key won't work", 4
    Sleep 2500
    TrayTip ; OSの設定を無視して通知バナーを強制的に閉じる
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 初回起動処理
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TrayTip "キースワップを適用しました。", "AHK_for_HHKB_en", 4
Sleep 2500
TrayTip