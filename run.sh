name=$1

# Activate python virtual environment
source .venv/bin/activate

if [[ -n "$name" ]]; then
    ansible-playbook main.yml \
      -i hosts.ini \
      --vault-password-file ./.vault_pass.txt \
      --tags $name \
      -vvv \
      --ask-become-pass \
      --step
else
   echo "You didn't specify any tags! Running all tasks"
   ansible-playbook main.yml \
      -i hosts.ini \
      --vault-password-file ./.vault_pass.txt \
      -vvv \
      --ask-become-pass \
      --step
fi
