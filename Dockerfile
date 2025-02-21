FROM quay.io/toolbx-images/debian-toolbox:12 

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    biber \
    latexmk \
    openssh-server \
    texlive-full && \
    rm -rf /var/lib/apt/lists/*

# Create directory for sshd
RUN mkdir /var/run/sshd && mkdir -p /root/.ssh

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Set permissions for the entrypoint script
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose port 9001image
EXPOSE 9001

# Change SSH configuration to use port 9001 and set landing directory for SSH sessions
RUN sed -i 's/#Port 22/Port 9001/' /etc/ssh/sshd_config && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    # echo 'ForceCommand cd /root/latexb0x && exec "$SHELL"' >> /etc/ssh/sshd_config

# Set working directory
WORKDIR /root/latexb0x

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
