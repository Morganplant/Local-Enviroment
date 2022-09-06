$local_license = "C:\Users\morgan.plant\performance\MonthlyLicense.txt"
$remote_license = "\\performance.tartarus.bromium.local\Scripts\MonthlyLicense.txt"


$local_hash = (Get-FileHash $local_license -ErrorAction SilentlyContinue -Algorithm SHA256).hash
$remote_hash = (Get-FileHash $remote_license -Algorithm SHA256).hash

if ($local_hash -ne $remote_hash) {
    echo "$([char]0x1b)[91m [Updating Monthly License] $([char]0x1b)[37m"
    Copy-Item $remote_license -Destination $local_license
}