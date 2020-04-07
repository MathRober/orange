FROM jenkins/jenkins:latest



USER root
RUN \
wget https://apache.brunneis.com/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz && \
tar xzvf apache-maven-3.6.3-bin.tar.gz -C /opt/  && \
export PATH=/opt/apache-maven-3.6.3/bin:$PATH

USER jenkins
ENV PATH=/opt/apache-maven-3.6.3/bin:$PATHexport PATH=/opt/apache-maven-3.6.3/bin:$PATH

COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
#RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt


 

