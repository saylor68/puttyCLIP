;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; jan 12, 2020 - saylor ;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;setups
;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#InstallKeybdHook
#InstallMouseHook
#singleinstance ignore
#Persistent
AutoTrim, on
;
; out of the helpdoc
;
OnClipboardChange("ClipChanged") 
return
ClipChanged(Type) {
    ToolTip Clipboard data type: %Type%
    Sleep 10
    ToolTip  ; Turn off the tip.
}
;
~LButton:: ; interesting button to watch
;
{ 
; keywait dblclk code timer - how to catch dblclk (out of forum help)
;
KeyWait, LButton
KeyWait, LButton, D, T0.12
If ErrorLevel = 1
   Return
Else
{
Send, ^c
;
;MsgBox You double clicked on something ; test breakpoint
;
;
; detect if the dblclk was in our clipboard file
; and if it was, copy THAT value and send it to CMD
;
if WinActive("ahk_class Notepad")
{
;
;
Suspend
clipboard :=""
SetNumLockState, off
send, {click}
Send, {NumpadHome}
send, {shift}+{down}
send, ^c
;clipwait, .5
;msgbox this:  %clipboard%
setnumlockstate, on
suspend
;
;
;;good code below in ;;
;;Suspend ; stop the hotkey, use billys clipboard to catch what we clicked
;;clipboard :=""
;;send {Click,2}
;;send ^c
;Send, ^{Left}+^{Right}
;send ^c
;;clipwait, 2
;MyWord = %clipboard%
;msgbox, original:  -%clipboard%- `nmodified: -%MyWord%-
;;Suspend ; turn our hotkey back on
;
;; good code above in ;;
;
;msgbox notepad active ; test breakpoint
;
; if winexist("ahk_exe cmd.exe") ; grab CMD window
if WinExist("ahk_exe putty.exe") ; grab putty window
	{
WinActivate, ahk_class PuTTY
; winactivate, ahk_class cmd
send {Shift down}{ctrl down}v{shift up}{ctrl up}{Enter}
;send {click,r}{Enter}
;send ^v
;send {Click, R}{Enter}
;send {Click, R}
return
}
}
;
;  have something to paste into notepad i need to find it or create it
;
if WinExist("ahk_exe notepad.exe")
  {
WinActivate, ahk_exe notepad.exe
sleep 50
send, ^v {Enter}
}
else
{ ;1st instance
Run, notepad.exe
WinWait Untitled - Notepad
{
send, ^V {Enter}
}
}	
}
}
;



	

