# mac-playbook

This is a repo for bootstrapping my mac!

Run the commands below to execute:

```bash
export NAME=your_name_here
export EMAIL=your_email_here
export GITHUB_API_TOKEN=token_here

ansible-playbook main.yml -i hosts.ini -v
```

## TODO
* Add a passphrase to the ssh-keygen
* Add ssh-key to ssh-agent
