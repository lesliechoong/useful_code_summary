#!/bin/bash

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne "0" ]]
then
    echo "Make sure you change to root user before running the script."
    exit 1
fi

# Get the username (login).

read -p 'Enter the username to create:'  USERNAME

read -p 'Enter the name of the person or application that will be using this account:' COMMENT

read -p 'Enter the password to use for the account:' PASSWORD

# Create the user with the password.

useradd -m "${COMMENT}" -c "${USERNAME}"

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne "0" ]]
then 
	echo "User ${USERNAME} was not set up successfully."
	exit 1
fi

# Set the password.
echo "${PASSWORD}" | passwd --stdin "${USERNAME}"

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne "0" ]]
then
	echo "Password was not setup successfully."
	exit 1
fi

# Force password change on next login by expiring it immediately
passwd -e "${USERNAME}"

# Display user, password and host
echo 
echo USERNAME: 
echo "${USERNAME}"
echo 
echo PASSWORD: 
echo "${PASSWORD}"
echo 
echo HOST: 
echo "${HOSTNAME}"


