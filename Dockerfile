# Set base image
FROM docker.io/library/archlinux:base-devel

# Install dependencies
RUN pacman -Syu --needed --noconfirm openssh git

# Setup user
RUN useradd --create-home --shell /bin/bash builder && \
    passwd --delete builder && \
    chown -vR builder:builder /home/builder && \
    usermod -aG wheel builder && \
    echo 'wheel  ALL=(ALL:ALL) ALL' >> /etc/sudoers

# Copy files
COPY LICENSE README.md /
COPY /.ssh /.ssh
COPY /scripts /scripts
COPY entrypoint.sh /entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
