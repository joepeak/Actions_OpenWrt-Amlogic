FROM debian:buster

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/archive.ubuntu.com/cn.archive.ubuntu.com/g' /etc/apt/sources.list

RUN apt-get update -y &&\
    apt-get upgrade -y &&\
    apt-get install -y \
                sudo time git-core subversion build-essential g++ bash make libnftnl-dev libelf-dev \
                libssl-dev patch libncurses5 libncurses5-dev zlib1g-dev gawk \
                flex gettext wget unzip xz-utils python python-distutils-extra \
                python3 python3-distutils-extra python3-setuptools swig rsync curl \
                libsnmp-dev liblzma-dev libpam0g-dev cpio rsync gcc-multilib vim && \
    apt-get clean && \
    useradd -m user && \
    echo 'user ALL=NOPASSWD: ALL' >> /etc/sudoers

COPY . /home/user
#RUN  chmod +x /home/user/.*sh

VOLUME ["/builder"]

# set system wide dummy git config
RUN git config --system user.name "user" && git config --system user.email "user@example.com"

USER user
WORKDIR /home/user
