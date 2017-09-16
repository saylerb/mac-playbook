# mac-playbook

This is a repo for bootstrapping my mac!

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

To run the ansible-playbook to provision your mac, run the command:

```bash
ansible-playbook main.yml -i hosts.ini -v
```

## TODO
* Add a passphrase to the ssh-keygen
* Add ssh-key to ssh-agent
* Use uri module instead of curl for github key
