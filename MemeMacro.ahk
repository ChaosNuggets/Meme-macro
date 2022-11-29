#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

F9::
Loop {
  ; Click return on the computer
  MouseMove 950, 100
  Sleep 50
  MouseMove 975, 100
  Sleep 50
  Click
  
  ; Walk to the first bucket
  Send {s down}
  Sleep 900
  Send {s up}
  
  ; Pick up from the first bucket
  Send {e down}
  Sleep 50
  Send {e up}
  
  ; Walk to the second bucket
  Send {d down}
  Sleep 1200
  
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
  Send {d up}
  Send {a down}
  Sleep 2900
  
  ; Stop to the right of the computer
  Send {a up}
  
  ; Walk back to the computer
  Send {w down}
  Sleep 900
  Send {w up}
  
  ; Enter the computer
  Send {e down}
  Sleep 50
  Send {e up}
  
  ; Wait for the screen to zoom into the computer
  Sleep 1500
  
  ; Click upload on the computer
  MouseMove 950, 300
  Sleep 50
  MouseMove 975, 300
  Sleep 50
  Click
  
  ; Wait for buckets to refil
  Sleep 18000
}