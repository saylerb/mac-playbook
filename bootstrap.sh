# !/usr/bin/env bash

# To correctly run this file, source it (python venv is created)
# . ./bootstrap.sh

# Homebrew installs macOS command line tools automatically now, with python3
if [ ! `which brew` ]
then
    echo "Installing Homebrew..."
    ruby \
      -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
      </dev/null
fi

# Create and source the virtual environment
if [ -d "./venv" ]
then
    echo "venv directory exists, skipping creation"
else
    echo "Creating virtual environment..."
    virtualenv venv
fi

if [ ! `which ansible`]
then
    echo "activating venv..."
    source venv/bin/activate
    echo "Installing ansible within virtual environment..."
    pip install ansible
fi
