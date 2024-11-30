FROM madebytimo/java-nodejs-python

RUN install-autonomous.sh install Ansible Basics FFmpeg Fileorganizer Go Htop MetadataEditors \
    OCRTools Podman Screen Scripts ScriptsAdvanced ScriptsDevelopment Subversion Sudo \
    && apt update -qq && apt install -y -qq openssh-server \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p --mode 0755 /var/run/sshd

COPY sshd_config /etc/ssh/

RUN mkdir --parents /media/user \
    && usermod --password '*' user \
    && usermod --append --groups sudo user

ENV AUTHORIZED_PUBLIC_KEYS=""
ENV HOST_KEY=""

COPY files/entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/sbin/sshd", "-D", "-e" ]
