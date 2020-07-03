FROM centos:7
WORKDIR /opt
ARG Version=1.0.0
ENV Version=${Version} \
    LANG=en_US.utf8

RUN set -ex \
    && yum install -y epel-release wget \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "LANG=en_US.utf8" > /etc/locale.conf \
    && echo -e "[nginx-stable]\nname=nginx stable repo\nbaseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/\ngpgcheck=1\nenabled=1\ngpgkey=https://nginx.org/keys/nginx_signing.key\nmodule_hotfixes=true" > /etc/yum.repos.d/nginx.repo \
    && yum install -y nginx \
    && echo > /etc/nginx/conf.d/default.conf \
    && wget https://github.com/renmcc/UI/releases/download/${Version}/dist.tar.gz \
    && tar -xf dist.tar.gz \
    && rm -rf /opt/*.tar.gz \
    && yum remove -y wget \
    && yum clean all \
    && rm -rf /var/tmp/yum*

ADD nginx/backendstatic.tar.gz .

COPY nginx/nginx.conf /etc/nginx/

CMD ["nginx", "-g", "daemon off;"]
