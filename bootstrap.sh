# !/usr/bin/env bash

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
if is_bin_in_path brew
then
     echo "brew already installed"
else
    echo "Installing Homebrew..."
    ruby \
      -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
      </dev/null
fi

if [ -d "./venv" ]
then
    echo "venv directory exists, skipping creation"
else
    echo "Creating virtual environment..."
    virtualenv venv
fi

echo "activating venv..."
source venv/bin/activate

if [[ "$VIRTUAL_ENV" != "" ]]
then
    echo "inside virtual env"
else
    echo "Failed to activate virtual env"
fi

if is_bin_in_path ansible
then
     echo "ansible already installed, skipping"
else
     echo "ansible not installed, activating venv..."
     source venv/bin/activate
     echo "Installing ansible within virtual environment..."
     pip install ansible
fi

echo "complete! use source ./venv/bin/activate to enter virtual environment"

