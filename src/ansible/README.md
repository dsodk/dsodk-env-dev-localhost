# Configure DevSecOps Local Machine with Ansible

## Usage

* **Step 1)** Set the following environment variables in your SHELL rc file by running these commands.  Be sure to replace the values with your own.

```zsh
$ export SHELL_BASENAME=$(basename $(echo $SHELL)) \
  && export SHELL_RCFILE=".${SHELL_BASENAME}rc" \
  && echo 'export SHELL_BASENAME=$(basename $(echo $SHELL))' >> $HOME/$SHELL_RCFILE \
  && echo 'export SHELL_RCFILE=".${SHELL_BASENAME}rc"' >> $HOME/$SHELL_RCFILE
```

```zsh

$ SHELL_RCFILE_BLOCK='
################################
# PERSONAL
################################

export GITHUB_PERSONAL_USERNAME="<<MyPersonalGitHubUserName>>"
export GITHUB_PERSONAL_USEREMAIL="<<MyPersonalGitHubEmail>>"
export GITHUB_PERSONAL_REALNAME="<<Firstname Lastname>>"

export GITLAB_PERSONAL_USERNAME="<<MyPersonalGitLabUsername>>"
export GITLAB_PERSONAL_USEREMAIL="<<MyPersonalGitLabEmail>>"
export GITLAB_PERSONAL_REALNAME="<<Firstname Lastname>>"

export GPGKEY_PERSONAL_USERNAME="<<MyPersonalGpgKeyUsername>>"
export GPGKEY_PERSONAL_USEREMAIL="<<MyPersonalGpgKeyEmail>>"
export GPGKEY_PERSONAL_REALNAME="<<Firstname Lastname>>"
export GPGKEY_PERSONAL_ID_SIGN="<<MyPersonalGpgKeySignatureID>>"  # Populate once gpg key has already been generated

export OBSIDIAN_VAULT_DIR="$HOME/path/to/obsidian-vault-dir"
'

$ echo ${SHELL_RCFILE_BLOCK} >> $HOME/$SHELL_RCFILE

```

```zsh

$ SHELL_RCFILE_BLOCK='
################################
# WORK
################################

export GITHUB_WORK_USERNAME="<<MyWorkGitHubUserName>>"
export GITHUB_WORK_USEREMAIL="<<MyWorkGitHubEmail>>"
export GITHUB_WORK_REALNAME="<<Firstname Lastname>>"

export GITLAB_WORK_USERNAME="<<MyWorkGitLabUsername>>"
export GITLAB_WORK_USEREMAIL="<<MyWorkGitLabEmail>>"
export GITLAB_WORK_REALNAME="<<Firstname Lastname>>"

export GITLAB_WORK_HOSTNAME=""

export GPGKEY_WORK_USERNAME="<<MyWorkGpgKeyUsername>>"
export GPGKEY_WORK_USEREMAIL="<<MyWorkGpgKeyEmail>>"
export GPGKEY_WORK_REALNAME="<<Firstname Lastname>>"
export GPGKEY_WORK_ID_SIGN="<<MyWorkGpgKeySignatureID>>"  # Populate once gpg key has already been generated
'

$ echo ${SHELL_RCFILE_BLOCK} >> $HOME/$SHELL_RCFILE

```

* **Step 2)** Set environment variables for GPGKEY_PASSPHRASE if the 3 conditions (listed below) apply to you:  
> *If one or all below conditions do not apply to you - skip this step and proceed to **Step 3***

  * Condition 1) You are running this playbook for the first time and do not already have a gpg identity key living on this machine
  * Condition 2) You have the ```gpg-identity``` role enabled in ```site.yml```  
  * Condition 3) You wish to have a passphrase set for your gpg key
----

  * If the 3 conditions above apply to you - then you must run the following command to set a temporary environment variable in your shell for GPGKEY_*_PASSPHRASE
 
```zsh

$ export GPGKEY_PERSONAL_PASSPHRASE="MyLongAndSecureSecretPassPhrase-123"   # This variable will be unset (removed) in your shell once ansible successfully creates your gpg key
$ export GPGKEY_WORK_PASSPHRASE="MyLongAndSecureSecretPassPhrase-123"   # This variable will be unset (removed) in your shell once ansible successfully creates your gpg key

```

* **Step 3)** Set GITHUB_TOKEN_HTTPS environment variable if you wish to have the following set in your ```git global config```

```url.'https://${GITHUB_TOKEN_HTTPS}@github.com'.insteadOf 'https://github.com'```

```zsh
$ export GITHUB_TOKEN_HTTPS="ght/ABCDEFG1234567HIJKLMNO890"
```

* **Step 4)** Run the ansible playbook with the following command: 

```zsh
$ ansible-playbook site.yml
```
