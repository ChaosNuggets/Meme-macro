#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^e::
DetectHiddenWindows On  ; Allows a script's hidden main window to be detected.
SetTitleMatchMode 2  ; Avoids the need to specify the full path of the file below.
WinClose MemeMacro.ahk - AutoHotkey  ; Update this to reflect the script's name (case sensitive).
Send {w up}
Send {Ctrl up}
Send {Space up}
Send {r up}
Send {a up}
Send {d up}
Send {s up}
Send {e up}