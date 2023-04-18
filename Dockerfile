FROM madebytimo/base

RUN install-autonomous.sh install Ansible Basics Docker htop Java npm Scripts Subversion ScriptsDevelopment && \
    rm -rf /var/lib/apt/lists/*

RUN adduser user --disabled-password --gecos "" --home /media/user
RUN mkdir -p --mode 0755 /var/run/sshd
COPY sshd_config /etc/ssh/

RUN mkdir --parents /media/user

ENV PUBLIC_KEYS=""

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/sbin/sshd", "-D" ]
