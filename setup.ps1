if (!(Get-Command choco -errorAction SilentlyContinue))
{
	echo "Required: chocolatey (not found)"
	echo "Installing now ..."

	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

	echo "Installed chocolatey!"
}

if (!(Get-Command clang -errorAction SilentlyContinue))
{
	echo "Required: clang (not found)"
	echo "Installing now ..."

	choco install llvm

	echo "Installed chocolatey!"
}

winget install neovim
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
$nvimLocal = "$env:LOCALAPPDATA\nvim\"
$nvimGit = "$env:USERPROFILE\.config\nvim"
if (Test-Path -Path $nvimLocal)
{
	echo "Found existing: nvim config folder"
}
else
{
	echo "Create link to Neovim config"
	New-Item -Path $nvimLocal -ItemType Junction -Value 
}

$packerNvimFolder = "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
if (Test-Path -Path $packerNvimFolder) 
{
	echo "Found existing: packer.nvim"
}
else 
{
	echo "Cloning packer.nvim ..."
	git clone https://github.com/wbthomason/packer.nvim $packerNvimFolder
}

echo "Installing plugins with packer.nvim"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

