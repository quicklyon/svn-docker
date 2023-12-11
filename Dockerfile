FROM alpine:3.15

# Add s6-overlay
ENV S6_OVERLAY_VERSION=v1.22.1.0
ENV GO_DNSMASQ_VERSION=1.0.7
ENV S6_URL="https://github.com/just-containers/s6-overlay/releases/download"
ENV DNSMASQ_URL="https://github.com/janeczku/go-dnsmasq/releases/download"
ENV RT_VER=1.0.6
ENV RT_URL="https://github.com/bitnami/render-template/releases/download"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
	&& apk add --no-cache bind-tools curl libcap apache2 apache2-utils \
                          apache2-webdav mod_dav_svn subversion php7 \
                          php7-apache2 php7-session php7-json php7-ldap \
                          php7-xml wget unzip bash tzdata \
	&& mkdir -pv /run/apache2/ /etc/subversion \
	&& ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -sSL ${S6_URL}/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz | tar xfz - -C / \
	&& curl -sSL ${DNSMASQ_URL}/${GO_DNSMASQ_VERSION}/go-dnsmasq-min_linux-amd64 -o /bin/go-dnsmasq \
	&& chmod +x /bin/go-dnsmasq \
	&& addgroup go-dnsmasq \
	&& adduser -D -g "" -s /bin/sh -G go-dnsmasq go-dnsmasq \
	&& setcap CAP_NET_BIND_SERVICE=+eip /bin/go-dnsmasq

RUN curl -sLk https://github.com/mfreiholz/iF.SVNAdmin/archive/stable-1.6.2.zip -o /tmp/svnadmin.zip \
	&& unzip /tmp/svnadmin.zip -d /opt \
	&& rm /tmp/svnadmin.zip \
	&& mv /opt/iF.SVNAdmin-stable-1.6.2 /opt/svnadmin

RUN curl -sLk ${RT_URL}/v${RT_VER}/render-template-linux-amd64.tar.gz | tar xfz - -C /usr/bin/ \
    && ln -s /usr/bin/render-template-linux-amd64 /usr/bin/render-template

# Solve a security issue (https://alpinelinux.org/posts/Docker-image-vulnerability-CVE-2019-5021.html)	
RUN sed -i -e 's/^root::/root:!:/' /etc/shadow

# Add services configurations
COPY --chown=apache:apache rootfs /

# Set HOME in non /root folder
ENV HOME /data

VOLUME ["/data"]

# Expose ports for http and custom protocol access
EXPOSE 80 3690

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
