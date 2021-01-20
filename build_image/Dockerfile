FROM ubuntu:20.04
LABEL maintainer = "yhsiao"

ENV DEBIAN_FRONTEND noninteractive

# Set apt mirror, using NCHC's server
RUN sed -i 's/archive.ubuntu.com/free.nchc.org.tw/g' \
    /etc/apt/sources.list
# Update
RUN apt-get update
RUN apt-get upgrade -y
# Install missing system-tools
RUN apt-get install software-properties-common locales -y
# Set locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
# Install build tools
RUN apt-get install -y \
    cmake ninja-build \
    build-essential \
    device-tree-compiler
# Install LLVM toolchain
RUN apt-get install -y clang
# Install python3
RUN apt-get install -y \
    python3 python3-dev \
    python3-pip
# Install common tools
RUN apt-get install -y \
    vim git tmux wget curl p7zip \
    clang-format clang-tidy \
    gdb valgrind fish zsh
# Install oh-my-zsh
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN apt-get install -y graphviz
RUN apt-get update
RUN apt-get install -y yosys
RUN apt-get install -y opam

# enable ssh service 

RUN apt-add-repository -y -r ppa:saltmakrell/ppa
RUN add-apt-repository -y -r ppa:gnome-shell-extensions/ppa
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' | chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
RUN rm -rf /root/.ssh
RUN mkdir /root/.ssh

# Cleanup
RUN apt-get autoremove -y\
    && apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# test opam install 
COPY install_coatcheck.sh .
RUN  ./install_coatcheck.sh
#
EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]
#CMD ["/usr/bin/zsh"]
