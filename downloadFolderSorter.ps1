##This script is for sorting your downloads folder into three smaller folders, Large, Medium, Small
##This is usefull if your like me and everything gets saved into downloads and you run out of C drive

$downloadsFolder = "$env:USERPROFILE\Downloads"

$smallFolder = Join-Path $downloadsFolder "Small"
$mediumFolder = Join-Path $downloadsFolder "Medium"
$largeFolder = Join-Path $downloadsFolder "Large"

$folders = @($smallFolder, $mediumFolder, $largeFolder)
foreach ($folder in $folders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder | Out-Null
    }
}

Get-ChildItem -Path $downloadsPath -File | ForEach-Object {
    $file = $_
    $sizeMB = [math]::Round($file.Length / 1MB, 2)

    if ($sizeMB -lt 10) {
        Move-Item -Path $file.FullName -Destination $smallFolder
    }
    elseif ($sizeMB -ge 10 -and $sizeMB -le 200) {
        Move-Item -Path $file.FullName -Destination $mediumFolder
    }
    else {
        Move-Item -Path $file.FullName -Destination $largeFolder
    }
}