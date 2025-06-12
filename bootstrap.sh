#!/usr/bin/env bash
set -e

# True if $1 is an executable in $PATH
# Works in both {ba,z}sh
function is_bin_in_path {
  if [[ -n $ZSH_VERSION ]]; then
    builtin whence -p "$1" &> /dev/null
  else  # bash:
    builtin type -P "$1" &> /dev/null
  fi
}

# Homebrew installs macOS command line tools automatically now
if is_bin_in_path /opt/homebrew/bin/brew; then
  echo "brew already installed"
else
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command -v brew &>/dev/null; then
  echo "brew is not on the path, adding it"
  export PATH="/opt/homebrew/bin:$PATH"
fi

# Install pyenv
if is_bin_in_path pyenv; then
  echo "pyenv installed"
else
  echo "Installing pyenv"
  brew install pyenv
  echo "pyenv installed"
fi

echo "Setting up pyenv"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"

python_version_to_install=$(cat .python-version)

# Rebuild pyenv shims
echo "Rebuilding pyenv shims"
pyenv rehash

if pyenv versions --bare | grep -Fxq "$python_version_to_install"; then
  echo "Python $python_version_to_install found"
else
  echo "Python $python_version_to_install not found, attempting install"
  pyenv install "$python_version_to_install"
fi

# Set the local python version
echo "Setting local python"
pyenv local

if [ -d "./.venv" ]; then
  echo ".venv directory exists, skipping creation"
else
  echo "Creating virtual environment..."
  python -m venv .venv
fi

echo "Activating venv..."
source .venv/bin/activate

if [[ "$VIRTUAL_ENV" != "" ]]; then
  echo "Inside virtual env"
else
  echo "Failed to activate virtual env"
fi

if is_bin_in_path ansible; then
  echo "ansible already installed, skipping"
else
  echo "ansible not installed, installing..."
  source .venv/bin/activate
  python -m pip install --upgrade pip
  ansible_community_version=$(cat .ansible-version)
  echo "Installing ansible $ansible_community_version within virtual environment..."
  pip install "ansible==$ansible_community_version"
fi

echo "Complete! Use 'source ./.venv/bin/activate' to enter virtual environment"

