# mac-playbook

This is a repo for bootstrapping my mac!

Run the commands below to execute:

```bash
export NAME=your_name_here
export EMAIL=your_email_here

ansible-playbook main.yml -i hosts.ini -v
```

## SSH keys

```bash
pbcopy < ~/.ssh/id_rsa.pub 
# Copies the contents of the id_rsa.pub file to your clipboard
# Log into Github and add the ssh key
```

## TODO
* Add a passphrase to the ssh-keygen
* Add ssh-key to ssh-agent

* set up Name and Email for gitconfig
