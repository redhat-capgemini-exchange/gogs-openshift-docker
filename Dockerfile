FROM registry.access.redhat.com/ubi7/ubi-minimal

MAINTAINER Michael Kuehl <mkuehl@gmail.com>

ARG GOGS_VERSION="0.11.91"

LABEL name="Gogs - Go Git Service" \
      vendor="Gogs" \
      io.k8s.display-name="Gogs - Go Git Service" \
      io.k8s.description="The goal of this project is to make the easiest, fastest, and most painless way of setting up a self-hosted Git service." \
      summary="The goal of this project is to make the easiest, fastest, and most painless way of setting up a self-hosted Git service." \
      io.openshift.expose-services="3000,gogs" \
      io.openshift.tags="gogs" \
      build-date="2021-01-18" \
      version="${GOGS_VERSION}" \
      release="1"

ENV HOME=/var/lib/gogs

COPY ./root /

RUN yum -y nss_wrapper gettext

#RUN wget -O /etc/yum.repos.d/gogs.repo \
#    https://dl.packager.io/srv/gogs/gogs/main/installer/el/7.repo \
#    yum install gogs

RUN yum -y clean all && \
    mkdir -p /var/lib/gogs

RUN /usr/bin/fix-permissions /var/lib/gogs && \
    /usr/bin/fix-permissions /home/gogs && \
    /usr/bin/fix-permissions /opt/gogs && \
    /usr/bin/fix-permissions /etc/gogs && \
    /usr/bin/fix-permissions /var/log/gogs

EXPOSE 3000
USER 997

CMD ["/usr/bin/rungogs"]
