FROM centos:centos7
MAINTAINER Steven Edwards <cureadvocate@gmail.com>

RUN yum -y install epel-release

RUN yum -y install cpp gcc-c++ cmake git psmisc {binutils,boost,jemalloc}-devel \
    {sqlite,tbb,bzip2,openldap,readline,elfutils-libelf,gmp,lz4,pcre}-devel \
    lib{xslt,event,yaml,vpx,png,zip,icu,mcrypt,memcached,cap,dwarf}-devel \
    {unixODBC,expat,mariadb}-devel lib{edit,curl,xml2,xslt}-devel \
    glog-devel oniguruma-devel ocaml gperf enca libjpeg-turbo-devel make

WORKDIR /tmp
RUN git clone https://github.com/facebook/hhvm -b HHVM-3.7 hhvm --recursive

WORKDIR /tmp/hhvm
RUN cmake . -DMYSQL_UNIX_SOCK_ADDR=/dev/null

RUN make && make install && yum clean all && rm -rf /tmp/*

CMD echo "Success!"