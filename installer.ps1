# Installation script that does not use Chocolatey package manager
function createDirectory{
    $script:workdir = "c:\temp\"
    # Check if path exist
     If (Test-Path -Path $workdir -PathType Container){ 
        Write-Host "$workdir already exists" -ForegroundColor Red 
    } ELSE { 
        New-Item -Path $workdir  -ItemType directory 
    }
}

function Install7zip {
    $7zipExist = $true;
    $WebClient = New-Object -TypeName System.Net.WebClient;
    $7ZipUrl = 'https://www.7-zip.org/a/7z1900-x64.msi';
    $7ZipInstaller = "$workdir\7z1900-x64.msi";

    try {
        $7ZipPath = Resolve-Path -Path ((Get-Item -Path HKLM:\SOFTWARE\7-Zip -ErrorAction SilentlyContinue).GetValue("Path") + '\7z.exe');
        if (!$7ZipPath) {
            $7zipExist = $false;
        }
    }
    catch {
        $7zipExist = $false;
    }

    if (!$7zipExist) {
        $WebClient.DownloadFile($7ZipUrl, $7ZipInstaller);
        Start-Process -FilePath $7ZipInstaller -ArgumentList "/S"
        Remove-Item -Path $7ZipInstaller -Force -ErrorAction SilentlyContinue;
    }
    else {
        Write-Host "7-zip installed." -ForegroundColor Red;
    }
}

function InstallCCleaner{
    $ccleanerExist = $true;
    $WebClient = New-Object -TypeName System.Net.WebClient;
    $ccleanerUrl = 'https://download.ccleaner.com/ccsetup559.exe'; # change ver number if needed
    $ccleanerDest = "$workdir\ccsetup559.exe";

    try {
        $ccleanerExist = Test-Path -Path "C:\Program Files\CCleaner"
        if (!$ccleanerExist) {
            $ccleanerExist = $false;
        }
    }
    catch {
        $ccleanerExist = $false;
    }

    Invoke-WebRequest $ccleanerUrl -OutFile $ccleanerDest #Another way of webclient
    Start-Process -FilePath "$workdir\ccsetup559.exe" -ArgumentList "/S"
    Start-Sleep -s 35
    Remove-Item -Path $ccleanerDest -Force -ErrorAction SilentlyContinue;
}

createDirectory
Install7zip
InstallCCleaner