FROM madebytimo/builder

RUN install-autonomous.sh install Ansible Basics FFmpeg Fileorganizer Go Htop Java MetadataEditors \
    NetworkTools NodeJs OCRTools Podman Python Screen Scripts ScriptsAdvanced ScriptsDevelopment \
    SSHServer Subversion Sudo YtDlp \
    && rm -rf /var/lib/apt/lists/* \
    \
    && mkdir --mode 0755 --parents /var/run/sshd \
    && rm ~/.gitconfig \
    && mkdir --parents /media/user \
    && usermod --password '*' user \
    && usermod --append --groups sudo user

COPY sshd_config /etc/ssh/

ENV AUTHORIZED_PUBLIC_KEYS=""
ENV HOST_KEY=""

COPY files/entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/sbin/sshd", "-D", "-e" ]
