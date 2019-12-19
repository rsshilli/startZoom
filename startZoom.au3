
$sleepTime = 5000 ; Time to sleep after sending the command to Chrome
$meetingNum = "" ; Zoom meeting number


$V_Arg = "Usage: startZoom (--sleep <ms>) <Meeting number>" & @LF
$V_Arg = $V_Arg & "    --sleep <ms>     - The number of ms to sleep for between opening the URL and sending the keys to get past the ""Open Zoom Meetings?"" popup.  Default: 5000 ms (5 seconds)" & @LF
$V_Arg = $V_Arg & "    <Meeting number> - The zoom meeting number " & @LF
$V_Arg = $V_Arg & "ex. startZoom 1234567890" & @LF
; retrieve commandline parameters
For $x = 1 to $CmdLine[0]
  Select
    Case $CmdLine[$x] = "--sleep"
      $x = $x + 1
      $sleepTime = Number($CmdLine[$x])
    Case $CmdLine[$x] = "/?" Or $CmdLine[$x] = "/h" Or $CmdLine[$x] = "/help" Or $CmdLine[$x] = "-?" Or $CmdLine[$x] = "-h" Or $CmdLine[$x] = "-help"
      ConsoleWrite($V_Arg)
      Exit
    Case Else
      $meetingNum = $CmdLine[$x]
  EndSelect
Next

If $meetingNum = "" Then
  ConsoleWrite($V_Arg)
  Exit
EndIf

$url = "https://zoom.us/j/" & $meetingNum

ConsoleWrite("Starting zoom meeting " & $meetingNum & " by going to: " & $url & @LF)

ShellExecute($url)

ConsoleWrite("Waiting for " & $sleepTime & " ms..." & @LF);
Sleep($sleepTime); Wait for Chrome to load the page

ConsoleWrite("Dismissing the dialog..." & @LF);
Send("{tab}")
Send("{space}")

