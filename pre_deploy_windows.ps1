
Write-Host "To run the customization scripts in Windows first we need to setup a basic bash envoriment. MinGW is the current prefered option and it is installed as part of the Git for Windows package."
Write-Host "Starting by downloading Git..."

$url = "https://github.com/git-for-windows/git/releases/download/v2.12.2.windows.1/Git-2.12.2-64-bit.exe"
$downloads_folder = "~/Downloads"
$start_time = Get-Date
$output_file = "$downloads_folder/git_tmp.exe"
Invoke-WebRequest -Uri $url -OutFile $output_file
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

Start-Process -FilePath "$output_file"
Write-Output "Git and bash should be installed now. Go ahead and continue running the remaining scripts from within Bash"
