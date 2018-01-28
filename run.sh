name=$1

if [[ -n "$name" ]]; then
    ansible-playbook main.yml -i hosts.ini --vault-password-file ./.vault_pass.txt --tags $name -vvv
else
   echo "You didn't specify any tags!"
fi
