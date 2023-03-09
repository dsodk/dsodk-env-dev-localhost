
echo "#---------------------------------"
echo "# CONFIG: RUNNING ANSIBLE PLAYBOOK: src/ansible/site.yml"
echo "#---------------------------------" ; echo ""

(cd src/ansible ; ansible-playbook site.yml)