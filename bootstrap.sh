# !/usr/bin/env bash

# Install Command Line Tools without GUI prompt, required for pip to install ansible

touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
PROD=$(softwareupdate -l |
  grep "\*.*Command Line" |
  head -n 1 | awk -F"*" '{print $2}' |
  sed -e 's/^ *//' |
  tr -d '\n')
softwareupdate -i "$PROD" --verbose;

# End of Command Line Tools Script

if [ ! `which pip`]
then
    echo "Installing pip..."
    sudo easy_install pip
fi

sudo pip install --upgrade
sudo pip install ansible==2.3.2.0

# Avoid prompt to continue by redirecting stdin from /dev/null
if [ ! `which brew` ]
then
    echo "Installing Homebrew..."
    ruby \
      -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
      </dev/null
fi

# verify that Command Line Tools are correctly installed
# xcode-select -p
# should output /Library/Developer/CommandLineTools

# which pip
# which ansible
