##########################################################
# conventions
##########################################################

# uppercase for global variables
# lowercase for local variables

##########################################################
# basic settings
##########################################################

# default editor, can be changed by function `ched()`
$env:EDITOR = 'code'
# terminal editor
$env:EDITOR_T = 'vi'

##########################################################
# select ox-plugins
##########################################################

# oxpg: ox-git
# oxpc: ox-conda
# oxpbw: ox-bitwarden
# oxpcn: ox-conan
# oxpct: ox-container
# oxpes: ox-espanso
# oxpfm: ox-format
# oxphx: ox-helix
# oxpjl: ox-julia
# oxpjn: ox-jupyter
# oxpnj: ox-nodejs
# oxpns: ox-notes
# oxppu: ox-pueue
# oxprb: ox-ruby
# oxprs: ox-rust
# oxptl: ox-texlive
# oxpvs: ox-vscode
# oxpwr: ox-weather

$Global:OX_PLUGINS = @(
    'oxpg',
    'oxpwr',
    'oxpvs'
)

##########################################################
# select initial and backup configurations
##########################################################

# backup file path
$env:OX_BACKUP = "$HOME\Documents\backup"

# shell
$Global:OX_OXIDE.bkox = "$env:OX_BACKUP\shell\custom.ps1"

# terminal
if ( Test-Path "$HOME\.wezterm.lua" ) {
    $Global:OX_ELEMENT.wz = "$HOME\.wezterm.lua"
    NewNew-Item -Path $Global:OX_ELEMENT.wz -ItemType File
}
# $Global:OX_ELEMENT.al = "$env:APPDATA\alacritty\alacritty.yml"

$Global:OX_OXIDE.bkwz = "$env:OX_BACKUP\terminal\wezterm.lua"
# $Global:OX_OXIDE.bkal = "$env:OX_BACKUP\terminal\alacritty.yml"

##########################################################
# register proxy ports
##########################################################

# c: clash, m: clash-meta, v: v2ray
$Global:OX_PROXY = @{
    'c' = '7890'
    'm' = '7897'
    'v' = '1080'
}

##########################################################
# pueue settings
##########################################################

# pueue demo
# function upp {
#     pueue group add up_all
#     pueue parallel 3 -g up_all
#     pueue add -g up_all 'scoop update *; scoop upgrade'
#     pueue add -g up_all 'conda update --all --yes'
#     pueue add -g up_all 'tlmgr update --all'
#     # or use predefined items in pueue_aliase
#     # pueue add -g up_all 'tlup'
# }

##########################################################
# conda settings
##########################################################

# # predefined conda environments
# # set the length of key < 3
# $Global:OX_CONDA_ENV = @{
#     b = 'base'
# }

# # conda env stats with bkce, and should be consistent with OX_CONDA_ENV
# # $Global:OX_OXIDE.bkceb = "$env:OX_BACKUP\conda\conda-base.txt"

##########################################################
# other settings
##########################################################

# git
$Global:OX_OXIDE.bkg = "$env:OX_BACKUP\.gitconfig"
$Global:OX_OXIDE.bkgi = "$env:OX_BACKUP\git\.gitignore"
# vscode
$Global:OX_OXIDE.bkvs = "$env:OX_BACKUP\vscode\settings.json"

##########################################################
# common aliases
##########################################################

# shortcuts
function cat { bat $args }
function ls { lsd $args }
function ll { lsd -l $args }
function la { lsd -a $args }
function lla { lsd -la $args }
function e { echo $args }
function rr { rm -rf $args }
function c { clear }

# tools
function man { tldr $args }
function hf { hyperfine $args }

##########################################################
# powershell
##########################################################

function tt { hyperfine --warmup 3 --shell powershell '. $PROFILE' }

##########################################################
# startup & daily commands
##########################################################

# donwload path
$env:OX_DOWNLOAD = "$HOME\Desktop"

$Global:OX_STARTUP = 1

function startup {
    cd "$HOME\Desktop"
}

##########################################################
# notes apps
##########################################################

# $Global:OX_OXIDIAN = ""
