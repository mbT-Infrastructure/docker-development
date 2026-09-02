FROM madebytimo/builder

ENV USER_GROUPS="sudo,user"

RUN install-autonomous.sh install AndroidTools Ansible Docker FFmpeg Fileorganizer Htop Java \
    MetadataEditors NetworkTools NodeJs OCRTools Screen SSHServer Subversion Sudo YtDlp \
    && apt update -qq && apt install -qq -y uidmap \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir --mode 0755 --parents /var/run/sshd \
    && rm ~/.gitconfig \
    && usermod --password '*' user \
    && mkdir --parent "/run/user/$(id --user user)" \
    && chown user:user "/run/user/$(id --user user)" \
    && chmod 0700 "/run/user/$(id --user user)" \
    && usermod --append --groups "$USER_GROUPS" user

COPY files/sshd_config /etc/ssh/

ENV AUTHORIZED_PUBLIC_KEYS=""
ENV DOCKER_HOST=""
ENV HOST_KEY=""

COPY files/entrypoint-development.sh files/healthcheck-docker.sh files/healthcheck-sshd.sh \
    files/run-docker.sh files/run-sshd.sh /usr/local/bin/

WORKDIR /media/user
ENTRYPOINT [ "entrypoint-development.sh" ]
CMD [ "run-parallel.sh", "run-docker.sh", "run-sshd.sh" ]

HEALTHCHECK CMD [ "bash", "-c", "healthcheck-docker.sh && healthcheck-sshd.sh" ]
