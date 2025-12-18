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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; マクロ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MsgBox '　キースワップを適用しました。', '情報', '64 T1'
