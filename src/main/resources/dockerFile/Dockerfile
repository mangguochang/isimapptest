FROM centos:7
LABEL maintainer="futs"
ENV container=docker

ENV pip_packages "ansible"

# Install systemd  
RUN yum -y update; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# Install requirements.
RUN yum makecache fast \
 && yum -y install deltarpm epel-release initscripts \
 && yum -y update \
 && yum -y install \
      sudo \
      which \
      python-pip \
 && yum clean all

# Install Ansible via Pip.
RUN pip install $pip_packages

# Disable requiretty.
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts1
RUN echo -e '[dev]\n127.0.0.1 ansible_connection=local' > /etc/ansible/hosts

# Install Java
ADD jdk-8u221-linux-x64.tar.gz /usr/local/       

ENV JAVA_HOME /usr/local/jdk1.8.0_221
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin

ADD   isimPlatform.jar       /app/isimPlatform.jar

# Install giit
RUN  yum install -y   zlib-devel perl-CPAN gettext curl-devel expat-devel gettext-devel openssl-devel
RUN  git config --global user.name 'codeSay'
RUN  git config --global user.email  '522587553@qq.com'

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]

CMD java -jar /app/isimPlatform.jar   

EXPOSE 8088



