#!/bin/bash

# Set permissions for SSH directory
chmod 700 /root/.ssh

# Check if the public key exists
if [ -f /root/.ssh/latex_id_ed25519.pub ]; then
    # Add the public key to authorized_keys if it’s not already present
    if ! grep -q "$(cat /root/.ssh/latex_id_ed25519.pub)" /root/.ssh/authorized_keys; then
        cat /root/.ssh/latex_id_ed25519.pub >> /root/.ssh/authorized_keys
    fi
    chmod 600 /root/.ssh/authorized_keys
fi

# Start SSH service
exec /usr/sbin/sshd -D
