# mac-playbook

This is Ansible playbook for bootstrapping my mac!

There are many tools out there for provisioning machines and scripting a mac
setup.  I wanted to learn how to use Ansible playbooks, and wanted something
that was idempotent for running my mac setup. My goal here is to do both: to
learn the different modules available while creating something useful to me.

## Installing Ansible

In order to use the Playbook to provision your machine, you'll need to have
Ansible installed. There's a simple bash script `bootstrap.sh` which will
automate the installation creating a virtual Python environment.

```bash
./bootstrap.sh
```

## Required additional setup

To automatically generate and setup ssh keys for github, the playbook needs a
github api token. Go to github settings > developer settings > personal access
tokens and generate one. When generating a new key, make sure to select the
correct scopes. For example, if you want to programmically add a public key to
github, check the `admin:public_key` scope. When you're done, copy the API key
to your clipboard.  Edit encrypted vault file so the ansible script can read it
out:

```
ansible-vault edit vault.yml
```
When done, you can delete the existing api key in github.

#### Ansible vault

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

If you want to edit the encrypted file, run the command below and enter the
vault password when prompted.

```
ansible-vault edit vault.yml
```

#### Running tasks selectively

Running the playbook in step: provide the `--step` flag to be asked a
confirmation before running each task.
Running specific tags by tag, provide the `--tags=TAGS` flag

```bash
ansible-playbook main.yml -i hosts.ini --ask-vault-pass --tags="packages, brew" --step
```

There's a shell script that will run ansible playbook. Note: It's import to
_source_ the file if the Python virtual environment is not already activated. 

```
source run.sh [tags]
```

# iTerm2

## Silence bell
Preferences -> Profiles -> Terminal tab -> Check "Silence bell"

## Color scheme
The playbook should install the iterm colors in ~/Downloads
Open iterm and go to Profiles -> Colors -> Color Presets -> import color.
Then import the downloaded file e.g. `gruvbox-dark.itermcolors`

## Fonts
Playbook should install patched powerline fonts automatically. Go to iterm2
Preferences -> Profiles -> Text -> Change Font and select any of the fonts
for Powerline.

## Natural Text Editing

- Go to Preferences... > Profiles > Keys (not Preferences... > Keys)
- Press Presets...
- Select Natural Text Editing

## Clipboard
* Can now remove `reattach-to-user-namespace`
* Must enable "Applications in terminal may access clipboard" in iTerm2

## TODO
* Add ssh-key to ssh-agent
* Use uri module instead of curl for github key
* Add ability to ask for sudo password at beginning of run
* Vim plugin installation
  * When running Vundle's plugin install, it exits with error code 1
  * Currently doing an `ignore_error`, but need to find a way around this
  * Maybe us Plug instead of Vundle
* Automate installation of color profile for iTerm
* Improve nvm installation. Add nvm load in bashrc.
* Install global yarn/npm packages
* ncu (npm check update)
* Deprecation warning for installing multiple brew packages within a loop
* Add note about checking against github's ssh fingerprint. Details [here](https://help.github.com/en/github/authenticating-to-github/githubs-ssh-key-fingerprints).
* When symlinking dotfile, check for existing and gracefully replace
* When symlinking vscode settings for the first time, settings files do not exist and the symlink fails.
* Symlinking deprecation warning: need to specify hard or link
* Set default node version to erbium
* Add personal and work gitconfig to script
