
###================================================<-> Functions <->=================================================###
Function Shorten-Path ([String]$Path) {
    $strResult = $Path.Replace($HOME, '~')
    # remove prefix for UNC paths
    $strResult = $strResult -Replace '^[^:]+::', ''
    # make path shorter like tabs in Vim,
    # handle paths starting with \\ and . correctly
    return ($strResult -Replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2')
}
Function Open {param ([Parameter(Mandatory=$false)] [string]$item = ".") ii $item} # Opens Current Location in Explorer

Function Remove-Results {
    $Location = Get-Location
    cd "$home\performance\Results"
    Get-ChildItem * -Include *.csv | Remove-Item

    cd $Location
}
Function Get-Envs {Get-Childitem -Path Env:* | Sort-Object Name}
Function Get-Changes {
    $location = Get-Location
    cd $home\performance\
    $branch = git branch --show-current

    git stash
    git fetch --prune
    # git checkout master
    # git pull
    git checkout $branch
    git stash pop

    cd $location
}
Function pip-installs {
    & "$home\performance\.virtualenv\scripts\python.exe" -m pip install --upgrade pip
    & "$home\performance\.virtualenv\Scripts\pip.exe" install rich

    & "$home\performance\tests\.virtualenv\scripts\python.exe" -m pip install --upgrade pip
    & "$home\performance\tests\.virtualenv\Scripts\pip.exe" install rich
}
Function Time {
    clear;py $profile\Textual\textualize_profile.py
}
Function view-tree {
    &"$home\Downloads\gource-0.53.win64\gource.exe" --seconds-per-day 0.01 --hide filenames,bloom --key -e 0.001 --title "Performance" --date-format "%b %Y" --camera-mode track --disable-auto-rotate
}
###==================================================================================================================###


###================================================<-> Oh my Posh <->================================================###
Function Set-EnvVar {
    $env:POSH=$(spotify status | Select-Object -First 1 | %{$_.Replace('Playing: ','')} | %{$_.Replace('Paused:  ','')})
}
New-Alias -Name 'Set-PoshContext' -Value 'Set-EnvVar' -Scope Global -Force
$shell = $Host.UI.RawUI
oh-my-posh --init --shell pwsh --config $home\Documents\WindowsPowerShell\ohmyposhv.json | Invoke-Expression

Set-PSReadLineOption -PredictionSource History
###==================================================================================================================###



###=============================================<-> Setup Enviroment <->=============================================###
$profile = "$home\Documents\WindowsPowerShell\"
Get-Changes 2>&1 /dev/null
pip-installs
Import-Module -Name Terminal-Icons
clear
###==================================================================================================================###