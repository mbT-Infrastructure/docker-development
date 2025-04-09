FROM madebytimo/builder

RUN install-autonomous.sh install Ansible Basics Docker FFmpeg Fileorganizer Go Htop Java \
    MetadataEditors NetworkTools NodeJs OCRTools Python Screen Scripts ScriptsAdvanced \
    ScriptsDevelopment SSHServer Subversion Sudo YtDlp \
    apt update -qq && apt install -qq -y uidmap \
    && rm -rf /var/lib/apt/lists/* \
    \
    && mkdir --mode 0755 --parents /var/run/sshd \
    && rm ~/.gitconfig \
    && mkdir --parents /media/user \
    && usermod --password '*' user \
    && mkdir --parent "/run/user/$(id --user user)" \
    && chown user:user "/run/user/$(id --user user)" \
    && chmod 0700 "/run/user/$(id --user user)"

COPY --chown=user:user files/env.sh /etc/profile.d/
COPY files/sshd_config /etc/ssh/

ENV AUTHORIZED_PUBLIC_KEYS=""
ENV HOST_KEY=""
ENV USER_GROUPS="docker,sudo"

COPY files/entrypoint.sh files/healthcheck-sshd.sh files/run-sshd.sh /usr/local/bin/

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "run-sshd.sh" ]

HEALTHCHECK CMD [ "healthcheck-sshd.sh" ]
