# Run script using administrator
function Install-chocolatey {
    $chocoExist = test-Path -Path "$env:ProgramData\Chocolatey"
    if(!$chocoExist){
        Write-Host "Installing Chocolatey package manager"
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = 
        [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    } else {
        Write-Host "Chocolatey already installed." -ForegroundColor Green;
    }    
}

Install-chocolatey
choco install 7zip
choco install ccleaner
choco install malwarebytes
choco install adobereader
choco upgrade all -y
