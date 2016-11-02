FROM       fedora:24
ENV        container docker
STOPSIGNAL SIGRTMIN+3
LABEL      name="Fedora Base Image"
CMD        [ "/sbin/init" ]

RUN        /usr/bin/systemctl unmask --no-reload systemd-logind.service getty.target console-getty.service ;\
           /usr/sbin/useradd user ;\
           echo -e "root:\nuser:" | /usr/sbin/chpasswd -e ;\
           /usr/bin/dnf -y makecache
