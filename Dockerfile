# zartsoft/fedora:36
# minimal fedora 36 image with no extras

# fedora own registry
FROM       registry.fedoraproject.org/fedora:36 as base

# my minimal core
RUN        echo install_weak_deps=False >> /etc/dnf/dnf.conf && \
           rm /etc/dnf/protected.d/sudo.conf && \
           dnf -y mark install gzip && \
           dnf -y erase sudo vim-minimal yum libpwquality && \
           dnf -y install hostname iproute iputils less procps-ng && \
           dnf -y update

# minimize layers
FROM       scratch as fedora
COPY       --from=base / /
ENV        DISTTAG=36container \
           FGC=f36 \
           container=oci
LABEL      vendor="Fedora Project" \
           name="fedora" \
           version="36" \
           license="MIT"
CMD        ["/bin/bash"]
