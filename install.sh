export OXIDIZER=${OXIDIZER:-"${HOME}/oxidizer"}
printf "📦 Installing Oxidizer\n"

###################################################
# Install Homebrew
###################################################

if test ! "$(command -v brew)"; then
    printf "📦 Homebrew not installed. Installing.\n"
    if [[ $(uname -s) = "Linux" ]] && [[ $(uname -m) = "aarch64" ]]; then
        echo "⚠️ Oxidizer doesn't support limited Linux-on-ARM yet."
        sleep 5
        exit
    elif [[ ${BREW_CN} ]]; then
        /bin/bash -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
    else
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
fi

printf "⚙️ Adding Custom settings...\n"
cp -i -v ${OXIDIZER}/defaults.sh ${OXIDIZER}/custom.sh

if [[ $(uname -s) = "Darwin" ]]; then
    printf "📦 Activating Homebrew on MacOS...\n"
    if [[ $(uname -m) = "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        echo 'export PATH="/opt/homebrew/bin:$PATH"' >>~/.zshrc
    else
        eval "$(/usr/local/Homebrew/bin/brew shellenv)"
    fi
else
    printf "📦 Activating Homebrew on Linux...\n"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>.profile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

brew tap "homebrew/services"
brew tap "homebrew/bundle"

###################################################
# Install Packages
###################################################

printf "📦 Installing essential Oxidizer toolchains...\n"

for pkg in $(cat ${OXIDIZER}/defaults/Brewfile.txt); do
    case $pkg in
    ripgrep)
        cmd='rg'
        ;;
    bottom)
        cmd='btm'
        ;;
    tealdear)
        cmd='tldr'
        ;;
    zoxide)
        cmd='z'
        ;;
    *)
        cmd=$pkg
        ;;
    esac
    if test ! "$(command -v $cmd)"; then
        brew install $pkg
    fi
done

###################################################
# Install Zap
###################################################

if [[ $(uname -s) = "Linux" ]]; then
    printf "📦 Adding Tap linuxbrew/fonts...\n"
    brew tap "linuxbrew/fonts"
    printf "📦 Installing Zap to Manage AppImage Packages...\n"
    curl https://raw.githubusercontent.com/srevinsaju/zap/main/install.sh | bash -s
else
    printf "📦 Adding Tap homebrew/cask-fonts...\n"
    brew tap "homebrew/cask-fonts"
fi

###################################################
# Update Shell Settings
###################################################

printf "⚙️ Configuring Shell...\n"

case ${SHELL} in
*zsh)
    brew install zsh zsh-completions zsh-autosuggestions zsh-syntax-highlighting
    export OX_SHELL=${HOME}/.zshrc
    ;;
*bash)
    if [[ $(bash --version | head -n1 | cut -d' ' -f4 | cut -d'.' -f1) < 5 ]]; then
        printf "📦 Installing latest Bash...\n"
        brew install bash bash-completion
    fi
    export OX_SHELL=${HOME}/.profile
    echo 'export BASH_SILENCE_DEPRECATION_WARNING=1' >>${OX_SHELL}
    ;;
esac

###################################################
# Injecting Oxidizer
###################################################

printf "⚙️ Adding Oxidizer into ${OX_SHELL}...\n"

echo "# Oxidizer" >>${OX_SHELL}

if [[ -z ${OXIDIZER} ]]; then
    OXIDIZER="${HOME}/oxidizer"
    append_str='export OXIDIZER='"${OXIDIZER}"' && source '"${OXIDIZER}"'/oxidizer.sh'
else
    append_str='source '"${OXIDIZER}"'/oxidizer.sh'
fi

echo "${append_str}" >>"${OX_SHELL}"

echo "⚙️ Adding Custom settings..."
cp ${OXIDIZER}/defaults.sh ${OXIDIZER}/custom.sh

# loading zoxide
sd ".* OX_STARTUP=.*" "export OX_STARTUP=1" ${OXIDIZER}/custom.sh

# set path of oxidizer
sd "source OXIDIZER=.*" "source OXIDIZER=${OXIDIZER}/oxidizer.sh" ${OX_SHELL}

###################################################
# Loading Plugins
###################################################

if [ ! -d ${OXIDIZER}/plugins ]; then
    mkdir -p ${OXIDIZER}/plugins
fi

curl -o ${OXIDIZER}/plugins/ox-brew.sh https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/zsh-plugins/ox-brew.sh
curl -o ${OXIDIZER}/plugins/ox-utils.sh https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/zsh-plugins/ox-utils.sh
curl -o ${OXIDIZER}/plugins/ox-pueue.sh https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/zsh-plugins/ox-pueue.sh

case $(uname -a) in
*Darwin*)
    curl -o ${OXIDIZER}/plugins/ox-macos.sh https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/zsh-plugins/ox-macos.sh
    ;;
*Ubuntu* | *Debian* | *WSL*)
    curl -o ${OXIDIZER}/plugins/ox-debians.sh https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/zsh-plugins/ox-debians.sh
    ;;
esac

###################################################
# Editor
###################################################

if test ! "$(command -v nvim)"; then
    echo "⚙️ Using Vim as Default Terminal Editor"
    export EDITOR="vi"
else
    export EDITOR="nvim"
fi

printf "🎉 Oxidizer installation complete!\n"
echo "Don't forget to restart your terminal and run \'upox\' function"
