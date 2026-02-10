FROM madebytimo/builder

ENV USER_GROUPS="sudo"

RUN install-autonomous.sh install Ansible Docker FFmpeg Fileorganizer Htop Java \
    MetadataEditors NetworkTools NodeJs OCRTools Screen SSHServer Subversion Sudo YtDlp \
    && apt update -qq && apt install -qq -y uidmap \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g @openai/codex \
    && mkdir /etc/codex \
    && download.sh --output /etc/codex/config-template.toml \
        "https://github.com/mbT-Infrastructure/template-config-files/raw/refs/heads/main/debian/\
codex/config.toml"  \
    && mkdir --mode 0755 --parents /var/run/sshd \
    && rm ~/.gitconfig \
    && usermod --password '*' user \
    && mkdir --parent "/run/user/$(id --user user)" \
    && chown user:user "/run/user/$(id --user user)" \
    && chmod 0700 "/run/user/$(id --user user)" \
    && usermod --append --groups "$USER_GROUPS" user

COPY files/env.sh /etc/profile.d/
COPY files/sshd_config /etc/ssh/

ENV AI_API_URL=""
ENV AI_API_KEY=""
ENV AUTHORIZED_PUBLIC_KEYS=""
ENV HOST_KEY=""

COPY files/entrypoint.sh files/healthcheck-sshd.sh files/run-sshd.sh /usr/local/bin/

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "run-sshd.sh" ]

HEALTHCHECK CMD [ "healthcheck-sshd.sh" ]
