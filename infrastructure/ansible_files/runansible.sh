#! /bin/bash
cd ~/.ssh
chmod 400 ssh-aws-pc.pem
cd ~/ansible_files
ansible-playbook -i inventory.yaml Playbook.yaml