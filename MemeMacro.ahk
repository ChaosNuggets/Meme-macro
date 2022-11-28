#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

F9::
TIMES_TO_LOOP := 15
Loop %TIMES_TO_LOOP% {
  ; Pick up from the first bucket
  Send {e down}
  Sleep 50
  Send {e up}
  
  ; Walk to the second bucket
  Send {w down}
  Sleep 1600
  
  ; Pick up from the second bucket
  Send {e down}
  Sleep 50
  Send {e up}
  
  ; Walk to the third bucket
  Sleep 1600
  
  ; Pick up from the third bucket
  Send {e down}
  Sleep 50
  Send {e up}
  
  ; Walk back
  Send {w up}
  Send {s down}
  Sleep 3350
  
  ; Stop at original position
  Send {s up}
  
  ; Wait for buckets to refil
  if (A_Index < TIMES_TO_LOOP) {
    Sleep 20000
  }
}

; Let the user knows the script is finished
SoundBeep, 523, 1500
MsgBox Go upload your memes