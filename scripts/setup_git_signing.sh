#!/usr/bin/env bash
set -e

if ! command -v gpg >/dev/null; then
  echo "GPG is not installed. Installing via Homebrew..."
  brew install gnupg
fi

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 /path/to/your/private-key.asc"
  exit 1
fi

GPG_KEY_FILE="$1"
if [ ! -f "$GPG_KEY_FILE" ]; then
  echo "GPG key file not found at $GPG_KEY_FILE"
  exit 1
fi

echo "Importing GPG key from $GPG_KEY_FILE..."
gpg --import "$GPG_KEY_FILE"

GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | awk '/sec/{print $2}' | head -n 1 | cut -d'/' -f2)
if [ -z "$GPG_KEY_ID" ]; then
  echo "Unable to determine GPG key ID."
  exit 1
fi

echo "GPG key imported. Used key ID: $GPG_KEY_ID"

if [ -n "$BASH_VERSION" ] && ! grep -q "export GPG_TTY" "${HOME}/.bashrc"; then
  echo "export GPG_TTY=$(tty)" >> "${HOME}/.bashrc"
  echo "Added GPG_TTY to your .bashrc. Please reload your shell or source .bashrc."
elif [ -n "$ZSH_VERSION" ] && ! grep -q "export GPG_TTY" "${HOME}/.zshrc"; then
  echo "export GPG_TTY=$(tty)" >> "${HOME}/.zshrc"
  echo "Added GPG_TTY to your .zshrc. Please reload your shell or source .zshrc."
fi

echo "GPG Git commit signing setup complete."
