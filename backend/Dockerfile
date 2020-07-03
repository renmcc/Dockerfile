FROM centos:7
WORKDIR /opt
ARG Version=1.0.0
ENV Version=${Version} \
    LANG=en_US.utf8

ADD backend/.pip /root/.pip

RUN set -ex \
    && echo "LANG=en_US.utf8" > /etc/locale.conf \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && yum install -y gcc epel-release wget git net-tools mariadb-devel python36 python36-devel\
    #&& wget https://github.com/renmcc/SA/archive/${Version}.tar.gz \
    #&& tar -xf ${Version}.tar.gz \
    #&& mv SA-${Version} SA \
    && git clone https://github.com/renmcc/SA.git \
    && chown -R root:root SA \
    && python3.6 -m venv /opt/py3 \
    && source /opt/py3/bin/activate \
    && pip install -r SA/requirements.txt \
    && yum clean all \
    && rm -rf /var/cache/yum/* \
    && rm -rf /opt/*.tar.gz \
    && rm -rf /var/cache/yum* \
    && rm -rf ~/.cache/pip

COPY backend/entrypoint.sh SA/entrypoint.sh
RUN chmod 755 SA/entrypoint.sh


CMD ["./SA/entrypoint.sh"]
