FROM centos

WORKDIR /usr/lab3
COPY ./lab3.s ./lab3.c .

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum update-minimal

RUN yum install -y gcc
RUN yum install -y gdb

RUN gcc -no-pie -o lab3 lab3.c lab3.s -g

RUN echo -e "1 1 1 \\n 2 2 2" > arr.txt

ENTRYPOINT /bin/bash
