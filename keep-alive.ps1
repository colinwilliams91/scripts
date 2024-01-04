# PShell script to persist connection to remote

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") ;
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") ;

$signature=@'
      [DllImport("user32.dll",CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
      public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
'@

$SendMouseClick = Add-Type -memberDefinition $signature -name "MouseEventNew" -namespace Win32Functions -passThru

start-sleep -seconds (15);
write-output "working . . .";
$X = [System.Windows.Forms.Cursor]::Position.X
$Y = [System.Windows.Forms.Cursor]::Position.Y

while (true)
{
    start-sleep -seconds (10*60);

    $X_current = [System.Windows.Forms.Cursor]::Position.X
    $Y_current = [System.Windows.Forms.Cursor]::Position.Y

    [system.windows.forms.cursor]::Position = New-Object system.drawing.point($X, $Y);

    $SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0);
    $SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0);

    [system.windows.forms.cursor]::Position = New-Object system.drawing.point($X_current, $Y_current)
}
