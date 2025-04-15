##My windows defende always crashes so I made this script to do it drive by drive in ps to hopefully fix it? 
##usefull if your file system is huge like mine (mines like 12TB)

$drives = Get-PSDrive -PSProvider FileSystem | Where-Object {
    ($_.DisplayRoot -eq $null) -and ($_.Root -match '^[A-Z]:\\$')
}

foreach ($drive in $drives) {
    $driveLetter = $drive.Root.TrimEnd('\')
    Write-Output "Scanning $driveLetter..."
    
    try {
        Start-MpScan -ScanType CustomScan -ScanPath $driveLetter
        Write-Output "done scan of $driveLetter."
    }
    catch {
        Write-Output "Failed to scan $driveLetter : $_"
    }


}
