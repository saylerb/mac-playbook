# mac-playbook

This is Ansible playbook for bootstrapping my mac!

There are many tools out there for provisioning machines and scripting a mac
setup.  I wanted to learn how to use Ansible playbooks, and wanted something
that was idempotent for running my mac setup. My goal here is to do both: to
learn the different modules available while creating something useful to me.

Run the commands below to execute:

The playbook requires the following ENV variables to be defined to set up a
global git config:

```bash
export NAME=your_name_here
export EMAIL=your_email_here
```

To automatically generate and setup ssh keys for github, the playbook needs a
github api token. Go to github settings, personal access tokens and generate
one, copy to your clipboard. Then run the command below:

```bash
export GITHUB_API_TOKEN=`pbpaste`
```

Set zsh as default shell (will be prompted for password)

```bash
chsh -s $(which zsh)
```

Currently I'm using ansible vault to store some encrypted keys. To run the
playbook, save the password in a single-line file in the working directory as
`vault_pass.txt`.  To run the ansible-playbook to provision your mac, run the
command:

```bash
ansible-playbook main.yml -i hosts.ini --vault-password-file ./.vault_pass.txt -vvv
```

Alternatively, you can run the playbook with a prompt to enter the password:

```bash
ansible-playbook main.yml -i hosts.ini --ask-vault-pass -vvv
```

# iTerm2

## Silence bell
Preferences -> Profiles -> Terminal tab -> Check "Silence bell"

## Fonts
The playbook should install the iterm colors in ~/Downloads
Open iterm and go to Profiles -> Colors -> Color Presets -> import color.
Then import the downloaded file e.g. `gruvbox-dark.itermcolors`

## Clipboard
* Can now remove `reattach-to-user-namespace`
* Must enable "Applications in terminal may access clipboard" in iTerm2

## TODO
* Add a passphrase to the ssh-keygen
* Add ssh-key to ssh-agent
* Move global git config to dotfiles repo
* Use uri module instead of curl for github key
* Automate changing of default shell to zsh
* Add ability to ask for sudo password at beginning of run
* Check if zshrc backup is actually working as intended
* Vim plugin installation
  * When running Vundle's plugin install, it exits with error code 1
  * Currently doing an `ignore_error`, but need to find a way around this
* Automate installation of color profile for iTerm
* Automate installation of Quiver
* include Java installation stuff in the main.yml
* improve nvm installation. Add nvm load in bashrc. 
  Need to source zshrc after to get it to work
