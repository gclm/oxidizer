# Oxidizer

[![CI](https://github.com/ivaquero/oxidizer/actions/workflows/main.yml/badge.svg)](https://github.com/ivaquero/oxidizer/actions/workflows/main.yml)
[![licence](https://img.shields.io/github/license/ivaquero/oxidizer)](https://github.com/ivaquero/oxidizer/blob/master/LICENSE)
![code size](https://img.shields.io/github/languages/code-size/ivaquero/oxidizer.svg)
![repo size](https://img.shields.io/github/repo-size/ivaquero/oxidizer.svg)

Simple & Extensible Dotfile Manager using Rust Toolchains (PRs and Forks are welcome !)

<p align="left">
<a href="README.md">English</a> |
<a href="https://github.com/ivaquero/oxidizer/wiki/%E4%B8%AD%E6%96%87">简体中文</a>
</p>

Let's Oxidize Development Environments

![oxidizer](https://raw.githubusercontent.com/ivaquero/blog-bio/master/tutorials/images/cmd/oxidizer.png)

## 1. Get Started

For macOS / Linux (Intel)

```sh
git clone --depth=1 https://github.com/ivaquero/oxidizer.git && bash oxidizer/install.sh

# customize path for Oxidizer
export OXIDIZER=$HOME/oxidizer
```

Note that Homebrew is an essential dependency for Oxidizer on macOS / Linux. For China mainland users, you may set `BREW_CN` variable to install Homebrew through domestic mirror

```sh
export BREW_CN=1
```

> Note that Oxidizer only support limited functionality on Linux-on-ARM yet.

For Windows

```powershell
git clone --depth=1 https://github.com/ivaquero/oxidizer.git; . oxidizer\install.ps1

# customize path for Oxidizer
$env:OXIDIZER = "$HOME\oxidizer"
```

Note that Scoop is an essential dependency for Oxidizer on Windows. For China mainland users, you may set `SCOOP_CN` variable to install Scoop through domestic mirror

```powershell
$env:scoop_mirror = 1
```

> For Cmder users, you need to remove the `-Options ReadOnly` from `Set-Item -Path function:\prompt -Value $Prompt -Options ReadOnly` in the last line of `%CMDER_ROOT%\vendor\profile.ps1`.

After installation, you might personalize your preference in `custom.sh` or `custom.ps1`, check [defaults.sh](https://github.com/ivaquero/oxidizer/blob/master/defaults.sh) or [defaults.ps1](https://github.com/ivaquero/oxidizer/blob/master/defaults.ps1). Open `custom.sh` or `custom.ps1` by following command

```shellscript
ef ox
```

To keep up the updates, simply use `upox` function.

## 2. Motivation

Oxidizer is originally designed for **non-administrator** users. It quickly sets up a minimal but powerful coding environment, and it aims to provide with following features:

- Cross-Platform (Mainly Rust Tool chains)
- Minimal dependencies & Minimal Installation
- Extensible Architecture
- Unified Interface & Smooth Usage
- Super-Fast! (Loading time < 1 s)

### 2.1. Command Line Replacement

☑️ means required in the installation.

- [x] Use `bat` instead of `cat`
- [x] Use `dust` instead of `du`
- [x] Use `fd` instead of `find`
- [x] Use `lsd` instead of `ls`
- [x] Use `tre` instead of `tree`
- [x] Use `ripgrep` instead of `grep`
- [x] Use `sd` instead of `sed`
- [x] Use `tealdeer` instead of `tldr` or `man`
- [x] Use `zoxide` instead of `cd` or `z.lua`
- [ ] Use `tokei` instead of `cloc`
- [ ] Use `starship` instead of `powerline10k` or `ohmyposh`

### 2.2. Software Replacement

- [x] Use `bottom` instead of `top` or `htop`
- [x] Use `gitui` instead of `lazygit`
- [ ] Use `wezTerm` or `alacritty` instead of `iterm2` or `windows terminal`
- [ ] Use `broot` instead of `ranger`
- [ ] Use `helix` instead of `neovim`
- [ ] Use `zellij` instead of `tmux` (Not support Windows yet)

> `Nushell` is a cross-platform written in Rust, but it doesn't support dynamical path for the moment.

### 2.3. Other Useful Rust Tools

- [x] `pueue`: Command-line task management tool for sequential and parallel execution of long-running tasks.
- [x] `hyperfine`: Command-line benchmarking tool
- [ ] `navi`: An interactive cheatsheet tool for the command-line
- [ ] `espanso`: Text Expander written in Rust (try it for fun!)

### 2.4. Summary of Plugins

Oxidizer is designed to be extensible, you can personalize `OX_PLUGINS` in `custom.sh` to load the plugins by your need.

Of course, you are allowed to write your own plugins, see [Writing A Plugin](https://github.com/ivaquero/oxidizer/blob/master/docs/plugins.md) for details.

|                      Plugin                       | Linux | macOS | Windows | Autoload? |
| :-----------------------------------------------: | :---: | :---: | :-----: | :-------: |
|     [Brew](https://github.com/Homebrew/brew)      |  ✅   |  ✅   |   ❌    |    ✅     |
| [Scoop](https://github.com/ScoopInstaller/Scoop)  |  ❌   |  ❌   |   ✅    |    ✅     |
|     [Pueue](https://github.com/Nukesor/pueue)     |  ✅   |  ✅   |   ✅    |    ✅     |
|                      System                       |  ✅¹  |  ✅   |   ✅    |    ✅     |
|                      Utility                      |  ✅   |  ✅   |   ✅    |    ✅     |
|            [Git](https://git-scm.com/)            |  ✅   |  ✅   |   ✅    |           |
| [Bitwarden](https://github.com/bitwarden/clients) |  🕒   |  🕒   |   🕒    |           |
|    [Conan](https://github.com/conan-io/conan)     |  ✅   |  ✅   |   ✅    |           |
|      [Conda](https://github.com/conda/conda)      |  ✅   |  ✅   |   ✅    |           |
|    [Julia](https://github.com/JuliaLang/julia)    |  ✅   |  ✅   |   🚧    |           |
|   [Jupyter](https://github.com/jupyter/jupyter)   |  ✅   |  ✅   |   ✅    |           |
|      [Node](https://github.com/nodejs/node)       |  ✅   |  ✅   |   🚧    |           |
|     [Rust](https://github.com/rust-lang/rust)     |  ✅   |  ✅   |   ✅    |           |
|   [Espanso](https://github.com/espanso/espanso)   |  ✅   |  ✅   |   ✅    |           |
|        [TeXLive](https://tug.org/texlive/)        |  ✅   |  ✅   |   ✅    |           |
|   [VSCode](https://github.com/microsoft/vscode)   |  ✅   |  ✅   |   ✅    |           |
|                    Container²                     |  ✅   |  ✅   |   ✅    |           |
|                      Formats                      |  🕒   |  🕒   |   🕒    |           |
|  [Helix](https://github.com/helix-editor/helix)   |  🕒   |  🕒   |   🕒    |           |

✅: complete functionality
🚧: partial functionality
🕒: basic functionality, needs more features
❌: not exist

> ¹: Currently, on Linux only provide with Debian-family shortcuts
>
> ²: Only for [Docker](https://docker.com/) and [Podman](https://github.com/containers/podman).

Oxidizer uses Homebrew or Scoop to manage packages and software programs to bypass the requirement of administrator privilege.

## 3. File Management

![design](https://raw.githubusercontent.com/ivaquero/backup/master/design.png)

- `frf`
  - refresh file by `source`
- `edf`
  - file: edit by `$EDITOR` (default: VSCode)
- `brf`
  - file: browse by `bat` / `cat`
  - folder: browse by `lsd` / `ls`
- `ipf`
  - file: overwrite system configurations by customized (backup) files
- `epf`
  - file: export system configurations to back up folder
- `iif`
  - file: overwrite system configurations in by Oxidizer defaults.

For example, if you want to edit `~/.zshrc`, you can type `ef zs`.

When you use `epf zs`, `~/.zshrc` will be copied and save in `$OX_BACKUP/shell` folder, where `$OX_BACKUP` is the backup path that can be personalized in `$OXIDIZER/custom.sh`. As mentioned in **Get Started**, you can open `custom.sh` simply by `ef ox`.

The table below lists the information of specific configuration files:

|     Origin     | Abbreviation |      Corresponding File      |
| :------------: | :----------: | :--------------------------: |
|    oxidizer    |     `ox`     |         `custom.sh`          |
|      zsh       |     `zs`     |           `.zshrc`           |
|   powershell   |     `ps`     |        `Profile.ps1`         |
| linux (debian) |     `sc`     |   `/etc/apt/sources.list`    |
|    wezterm     |     `wz`     |        `wezterm.lua`         |
|     conda      |     `c`      |          `.condarc`          |
|      git       |     `g`      |         `.gitconfig`         |
|      git       |     `gi`     |         `.gitignore`         |
|     conan      |     `cn`     |         `conan.conf`         |
|     conan      |    `cnr`     |        `remotes.json`        |
|     conan      |    `cnd`     |      `profiles/default`      |
|    espanso     |     `es`     |        `default.yml`         |
|    espanso     |    `esx`     |       `match/base.yml`       |
|    espanso     |    `esx_`    |       `match/packages`       |
|     helix      |     `hx`     |        `config.toml`         |
|     helix      |    `hxl`     |       `languages.toml`       |
|     julia      |     `jl`     |         `startup.jl`         |
|     julia      |    `jlx`     |       `julia-pkgs.txt`       |
|     julia      |    `jlp`     |        `Project.toml`        |
|     julia      |    `jlm`     |       `Manifest.toml`        |
|    jupyter     |     `jn`     | `jupyter_notebook_config.py` |
|     latex      |     `tl`     |        `texlive-pkgs`        |
|      node      |     `nj`     |       `node-pkgs.txt`        |
|     pueue      |     `pu`     |         `pueue.yml`          |
|     pueue      |    `pua`     |     `pueue_aliases.yml`      |
|     cargo      |     `cg`     |        `config.toml`         |
|     rustup     |     `rs`     |       `settings.toml`        |
|     vscode     |     `vs`     |       `settings.json`        |
|     vscode     |    `vsk`     |      `keybindings.json`      |
|     vscode     |    `vss_`    |          `snippets`          |
|     vscode     |    `vsx`     |      `vscode-pkgs.txt`       |
|     winget     |     `w`      |        `winget.json`         |
|     zellij     |     `zj`     |         `config.kdl`         |
|     zellij     |    `zjl_`    |          `layouts`           |

> `_` denotes a folder

## 4. Software Information Management

- `init_*`
  - file: install packages/extensions by Oxidizer defaults
- `up_*`
  - file: install packages/extensions by predefined files in `$OX_BACKUP`
- `back_*`
  - file: export package/extension info to `$OX_BACKUP` folder

`init_*` works for `brew`, `scoop`, `conda`; `up_*` and `back_*` work for `brew`, `scoop`, `conda`, `vscode`, `julia`, `texlive`, `node`.

## 5. Package Management

Oxidizer aims to provide a unified interface for all package manager-related commands to reduce typing and memory burden of command-line users.

|        |   Action    | brew `b` | scoop `s` | conda `c` | npm `n` | cargo `cg` | rustup `rs` | julia `jl` | conan `cn` | tlmgr `tl` |
| :----: | :---------: | :------: | :-------: | :-------: | :-----: | :--------: | :---------: | :--------: | :--------: | :--------: |
|  `*h`  |    help     |    ✅    |           |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |     ✅     |     ✅     |
| `*cf`  |   config    |    ✅    |           |    ✅     |   ✅    |            |             |            |     ✅     |            |
| `*is`  |   install   |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |     ✅     |     ✅     |
| `*us`  |  uninstall  |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |     ✅     |     ✅     |
| `*up`  |   update    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |     ✅     |     ✅     |
| `*ups` | update self |    ✅    |    ✅     |           |         |            |             |            |            |     ✅     |
| `*ls`  |    list     |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |            |     ✅     |
| `*lv`  |   leaves    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |     ✅     |            |            |
| `*sc`  |   search    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |            |     ✅     |            |
| `*cl`  |    clean    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |     ✅     |            |            |
| `*if`  |    info     |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |            |     ✅     |     ✅     |
| `*st`  |   status    |    ✅    |    ✅     |           |   ✅    |            |             |     ✅     |            |            |
| `*ck`  |    check    |    ✅    |    ✅     |           |   ✅    |     ✅     |     ✅      |            |            |     ✅     |
| `*pn`  |     pin     |    ✅    |    ✅     |           |         |            |             |     ✅     |            |            |
| `*upn` |    unpin    |    ✅    |    ✅     |           |         |            |             |     ✅     |            |            |
| `*dp`  |   depends   |    ✅    |    ✅     |    ✅     |         |     ✅     |             |     ✅     |     ✅     |            |
| `*xa`  |  add repo   |    ✅    |    ✅     |    ✅     |         |            |             |            |     ✅     |            |
| `*xrm` | remove repo |    ✅    |    ✅     |    ✅     |         |            |             |            |     ✅     |            |
| `*xls` |  list repo  |          |           |    ✅     |         |            |             |            |     ✅     |            |

Particularly, Oxidizer provides with two groups of experimental functions with suffix `p` for installing and downloading packages in parallel

- brew: `bisp`, `biscp`, `bupp`, `bupap`
- scoop: `sisp`, `supp`

For example, when you have more than 1 packages to install, instead of using `bis [pkg1] [pkg2]` , you can use `bisp [pkg1] [pkg2]` then the packages will be downloaded and installed in parallel.

Similarly, `biscp`, `bupp`, `bupap` are the parallel version of `bisc`, `bup`, `bupa`, respectively.

Before using parallel functions, `pueue` service need to be enabled by

```sh
# All OS
pueued -d
# or macOS / Linux
bss pu
```

Some package managers also have functionality of project management

|       |   Action    | brew `b` | scoop `s` | conda `c` | npm `n` | cargo `cg` | rustup `rs` | julia `jl` | conan `cn` |
| :---: | :---------: | :------: | :-------: | :-------: | :-----: | :--------: | :---------: | :--------: | :--------: |
| `*ii` | init/create |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |            |     ✅     |
| `*b`  |    build    |          |           |           |         |     ✅     |             |     ✅     |     ✅     |
| `*r`  |     run     |          |           |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |            |
| `*ed` |    edit     |    ✅    |           |           |         |            |             |            |            |
| `*ca` |     cat     |    ✅    |    ✅     |           |         |            |             |            |            |
| `*ln` |    link     |    ✅    |           |           |         |            |             |            |            |
| `*ts` |    test     |    ✅    |           |           |   ✅    |     ✅     |             |     ✅     |     ✅     |
| `*au` |    audit    |    ✅    |           |           |   ✅    |            |             |            |            |
| `*fx` |     fix     |    ✅    |           |           |   ✅    |     ✅     |             |            |            |
| `*pb` |   publish   |          |           |           |   ✅    |     ✅     |             |            |            |

Some of the package managers shortcuts are included in corresponding system plugins.

- `ox-macos`: autoloaded, contains alias and functions for `mas`
- `ox-apt`: autoloaded
- `ox-windows`: autoloaded, contains alias and functions for `winget` and `wsl`

|        |   Action    | mas `m` | apt `a` | winget `w` | wsl `wl` |
| :----: | :---------: | :-----: | :-----: | :--------: | :------: |
|  `*h`  |    help     |   ✅    |   ✅    |     ✅     |    ✅    |
| `*is`  |   install   |   ✅    |   ✅    |     ✅     |    ✅    |
| `*us`  |  uninstall  |   ✅    |   ✅    |     ✅     |    ✅    |
| `*up`  |   update    |   ✅    |   ✅    |     ✅     |    ✅    |
| `*ups` | update self |         |   ✅    |     ✅     |    ✅    |
| `*ls`  |    list     |         |   ✅    |     ✅     |    ✅    |
| `*lv`  |   leaves    |         |         |            |          |
| `*sc`  |   search    |   ✅    |   ✅    |            |          |
| `*cl`  |    clean    |         |   ✅    |            |    ✅    |
| `*if`  |    info     |   ✅    |   ✅    |     ✅     |          |
| `*st`  |   status    |   ✅    |         |            |          |
| `*ck`  |    check    |         |   ✅    |            |          |
| `*dp`  |   depends   |         |   ✅    |            |          |
| `*xa`  |  add repo   |         |         |            |          |
| `*xrm` | remove repo |         |         |            |          |
| `*xls` |  list repo  |         |         |            |          |

### 5.1. Homebrew

- [x] Integrated `aria2` to download Homebrew Casks (require `aria2` installed)
- [x] Enable Homebrew installation by using pre-download installers

- `bis`: brew install
- `bris`: brew reinstall

suffix `c` is a flag to specify brew commands only work on casks

- `bisc`: brew install --cask
- `brisc`: brew reinstall --cask
- `bupc`: brew upgrade --cask

suffix `a` is for `all` which will force brew to upgrade every cask including ones with `auto_update` flags

- `bupa`: brew upgrade --greedy

- `bdl`: download brew cask by `aria2`
- `brp`: replace brew cache file by pre-downloaded file
- `bmr`: using brew mirror
- `bmrq`: reset brew git source to official repositories, `q` is for quit.

### 5.2. Conda

Note that the conda plugin is based on `mamba` (a parallel version of conda) and `conda-tree`, so you need to install mamba by

```sh
conda install -c conda-forge mamba conda-tree
```

Besides the shortcuts mentioned above in `6. Package Management`, the conda plugin also provides with Conda environment management shortcuts which start with `ce`

- `ceat`: activate environment
  - `$1` length = 0: activate `base` env
  - `$1` length = 1 or 2: activate predefined env `OX_CONDA_ENV`
  - `$1` length > 2: activate new env

`OX_CONDA_ENV` can be personalized in `custom.sh`

For example, assume your environment's name is `hello`, you can set

```sh
# macOS / Linux
OX_CONDA_ENV[h]="hello"
# Windows
$Global:OX_CONDA_ENV.h = "hello"
```

then, you will be able to manipulate the environment by

```sh
# create environment
cecr h
# remove environment
cerm h
# update all packages in the specific environment
cup h
# list all packages in the specific environment
cls h
```

- `cerat`: reactivate environment, works live `ceat`
- `ceq`: quit environment (`q` is for `kill/quit`)
- `cecr`: create
- `cerm`: remove environment, works live `ceat` but won't remove `base` env
- `cels`: environment list
- `cedf`: compare packages between conda environments
- `cern`: renames an existing environment
- `cesd`: change environment's `conda-forge subdir`
- `ceep`: export environment

## 6. Further Reading

- [Service Management](https://github.com/ivaquero/oxidizer/blob/master/docs/services.md)
- [Project Management](https://github.com/ivaquero/oxidizer/blob/master/docs/projects.md)
- [Utility Management](https://github.com/ivaquero/oxidizer/blob/master/docs/utilities.md)
- [System Management](https://github.com/ivaquero/oxidizer/blob/master/docs/systems.md)
- [Writing A Plugin](https://github.com/ivaquero/oxidizer/blob/master/docs/plugins.md)

## 7. Credits

- [Mario Catuogno's Clean-macOS](https://github.com/MarioCatuogno/Clean-macOS)
- [Mike McQuaid's dotfiles](https://github.com/MikeMcQuaid/dotfiles)

## 8. Licence

This work is released under the GPL-v3 licence.
