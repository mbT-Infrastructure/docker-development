FROM madebytimo/java-nodejs-python

RUN install-autonomous.sh install Ansible Basics FFmpeg Fileorganizer Htop MetadataEditors \
    OCRTools Podman Screen Scripts ScriptsAdvanced ScriptsDesktop ScriptsDevelopment Subversion \
    Sudo && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p --mode 0755 /var/run/sshd
COPY sshd_config /etc/ssh/

RUN mkdir --parents /media/user
RUN usermod --password '*' user && \
    usermod --append --groups sudo user

ENV AUTHORIZED_PUBLIC_KEYS=""
ENV HOST_KEY=""

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/sbin/sshd", "-D", "-e" ]
