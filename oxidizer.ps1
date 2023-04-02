if ([string]::IsNullOrEmpty($env:OXIDIZER)) {
    $env:OXIDIZER = "$HOME\oxidizer"
}

##########################################################
# Oxidizer Configuration Files
##########################################################

# plugins
$Global:OX_OXYGEN = @{
    'oxd' = "$env:OXIDIZER\defaults.ps1"
    'oxz' = "$env:OXIDIZER\oxidizer.ps1"
    'oxwz' = "$env:OXIDIZER\defaults\wezterm.lua"
    'oxps' = "$env:OXIDIZER\oxplugins-pwsh\ox-scoop.ps1"
    'oxpw' = "$env:OXIDIZER\oxplugins-pwsh\ox-windows.ps1"
    'oxpg' = "$env:OXIDIZER\oxplugins-pwsh\ox-git.ps1"
    'oxpc' = "$env:OXIDIZER\oxplugins-pwsh\ox-conda.ps1"
    'oxpbw' = "$env:OXIDIZER\oxplugins-pwsh\ox-bitwarden.ps1"
    'oxpcn' = "$env:OXIDIZER\oxplugins-pwsh\ox-conan.ps1"
    'oxpdk' = "$env:OXIDIZER\oxplugins-pwsh\ox-docker.ps1"
    'oxpes' = "$env:OXIDIZER\oxplugins-pwsh\ox-espanso.ps1"
    'oxpfm' = "$env:OXIDIZER\oxplugins-pwsh\ox-formats.ps1"
    'oxphx' = "$env:OXIDIZER\oxplugins-pwsh\ox-helix.ps1"
    'oxpjl' = "$env:OXIDIZER\oxplugins-pwsh\ox-julia.ps1"
    'oxpjn' = "$env:OXIDIZER\oxplugins-pwsh\ox-jupyter.ps1"
    'oxpnj' = "$env:OXIDIZER\oxplugins-pwsh\ox-node.ps1"
    'oxppu' = "$env:OXIDIZER\oxplugins-pwsh\ox-pueue.ps1"
    'oxprb' = "$env:OXIDIZER\oxplugins-pwsh\ox-ruby.ps1"
    'oxprs' = "$env:OXIDIZER\oxplugins-pwsh\ox-rust.ps1"
    'oxptl' = "$env:OXIDIZER\oxplugins-pwsh\ox-texlive.ps1"
    'oxput' = "$env:OXIDIZER\oxplugins-pwsh\ox-utils.ps1"
    'oxpvs' = "$env:OXIDIZER\oxplugins-pwsh\ox-vscode.ps1"
}

##########################################################
# System Configuration Files
##########################################################

$Global:OX_ELEMENT = @{
    'ox' = "$env:OXIDIZER\custom.ps1"
}

$Global:OX_OXIDE = @{}
$Global:OX_APPHOME = @{}

##########################################################
# Load Plugins
##########################################################

# load system plugin
. $Global:OX_OXYGEN.oxpw

# load custom plugins
. $Global:OX_ELEMENT.ox

ForEach ($plugin in $Global:OX_PLUGINS) {
    . $Global:OX_OXYGEN.$($plugin)
}

# load core plugins
$Global:OX_CORE_PLUGINS = @('oxps', 'oxput', 'oxppu')

ForEach ($core_plugin in $Global:OX_CORE_PLUGINS) {
    . $Global:OX_OXYGEN.$($core_plugin)
}


##########################################################
# PowerShell Settings
##########################################################

# use rust alternatives
function ls { lsd $args }
function cat { bat $args }
function du { dust $args }

$Global:OX_ELEMENT.ps = $PROFILE
$Global:OX_OXIDE.bkps = "$env:OX_BACKUP\shell\Profile.ps1"

##########################################################
# Oxidizer Management
##########################################################

# update packages
function up_all {
    ForEach ($obj in $Global:OX_UPDATE_PROG) {
        Invoke-Expression up_$obj
    }
}

# backup packages lists
function back_all {
    ForEach ($obj in $Global:OX_BACKUP_PROG) {
        Invoke-Expression back_$obj
    }
}

# export configurations
function epall {
    ForEach ($obj in $Global:OX_EXPORT_FILE) {
        epf $obj
    }
}

# export configurations
function ipall {
    ForEach ($obj in $Global:OX_IMPORT_FILE) {
        ipf $obj
    }
}

# initialize Oxidizer
function iiox {
    echo "Installing Required packages...`n"
    $pkgs = cat "$env:OXIDIZER\defaults\Scoopfile.txt"
    ForEach ( $pkg in $pkgs ) {
        Switch ( $pkg ) {
            bottom { $cmd = 'btm' }
            ripgrep { $cmd = 'rg' }
            tealdeer { $cmd = 'tldr' }
            zoxide { $cmd = 'z' }
            Default { $cmd = $pkg }
        }
        if (Get-Command $cmd -ErrorAction SilentlyContinue) {
            echo "$pkg Already Installed"
        }
        else {
            echo "Installing $pkg"
            scoop install $pkg
        }
    }
}

# update Oxidizer
function upox {
    cd $env:OXIDIZER
    echo "Updating Oxidizer...`n"
    git fetch origin master
    git reset --hard origin/master

    if (!(Test-Path -Path "$env:OXIDIZER\oxplugins-pwsh")) {
        echo "`n`nCloning Oxidizer Plugins...`n"
        git clone --depth=1 https://github.com/ivaquero/oxplugins-pwsh.git
    }
    else {
        cd "$env:OXIDIZER\oxplugins-pwsh"
        echo "`n`nUpdating Oxidizer Plugins...`n"
        git fetch origin main
        git reset --hard origin/main
    }

    cd $env:OXIDIZER
    $ox_change=$(git diff defaults.ps1)
    if ([string]::IsNullOrEmpty($ox_change)) {
        echo "`n`nDefaults changed, don't forget to update your custom.ps1 accordingly...`n"
        git diff defaults.ps1
    }
    cd $HOME
}

##########################################################
# Starship
##########################################################

if (Get-Command starship -ErrorAction SilentlyContinue) {
    # system files
    $env:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
    $Global:OX_ELEMENT.ss = $env:STARSHIP_CONFIG
    # backup files
    $Global:OX_OXIDE.ss = "$env:OX_BACKUP\shell\starship.toml"

    Invoke-Expression (&starship init powershell)
}

if ($Global:OX_STARTUP) {
    startup
}

##########################################################
# Extras
##########################################################

Import-Module posh-git

Import-Module PSReadLine
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo

Import-Module "$env:SCOOP\modules\scoop-completion"