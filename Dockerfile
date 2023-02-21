FROM centos
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum update -y
RUN yum install wget -y
WORKDIR /opt
RUN wget https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u362-b09/OpenJDK8U-jdk_x64_linux_hotspot_8u362b09.tar.gz
RUN tar -zxvf OpenJDK8U-jdk_x64_linux_hotspot_8u362b09.tar.gz
RUN mv jdk8u362-b09/ java8
RUN sed -i '$a export JAVA_HOME=/opt/java8' /etc/profile
RUN sed -i '$a export PATH=$PATH:/opt/java8/bin' /etc/profile
RUN source /etc/profile
RUN wget https://dlcdn.apache.org/maven/maven-3/3.8.7/binaries/apache-maven-3.8.7-bin.tar.gz
RUN tar -zxvf apache-maven-3.8.7-bin.tar.gz 
RUN mv apache-maven-3.8.7 maven8
RUN sed -i '$a export M2_HOME=/opt/maven8' /etc/profile
RUN sed -i '$a export PATH=$PATH:/opt/maven8/bin' /etc/profile
RUN source /etc/profile
RUN rm -rf *.war
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.71/bin/apache-tomcat-9.0.71.tar.gz
RUN tar -zxvf apache-tomcat-9.0.71.tar.gz 
RUN mv apache-tomcat-9.0.71 tomcat9
RUN rm -rf *.tar.gz
RUN wget https://updates.jenkins.io/download/war/2.346.3/jenkins.war
RUN yum install fontconfig -y
RUN cp /opt/*.war /opt/tomcat9/webapps
RUN cd tomcat9/bin
