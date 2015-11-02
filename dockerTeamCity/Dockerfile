FROM ubuntu:14.04.3
ENV APT_GET_UPDATE 2015-07-16
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jre-headless wget && apt-get clean

# Inspired from ariya/centos6-teamcity-server

VOLUME  ["/data/teamcity"]
ENV TEAMCITY_DATA_PATH /data/teamcity
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-amd64

# Download and install TeamCity to /opt
ENV TEAMCITY_PACKAGE TeamCity-9.1.3.tar.gz
ENV TEAMCITY_DOWNLOAD http://download.jetbrains.com/teamcity
RUN wget $TEAMCITY_DOWNLOAD/$TEAMCITY_PACKAGE && \
    tar zxf $TEAMCITY_PACKAGE -C /opt && \
    rm -rf $TEAMCITY_PACKAGE

# 
COPY server.xml /opt/TeamCity/conf/
COPY web.xml /opt/TeamCity/conf/
COPY keystore_tomcat /opt/TeamCity/conf/

RUN useradd -d /home/teamcity -u 1001 -m -s /bin/bash teamcity
RUN chown teamcity:teamcity -R  /data/teamcity
RUN chown teamcity:teamcity -R  /opt/TeamCity

EXPOSE 8543
CMD ["/opt/TeamCity/bin/teamcity-server.sh", "run"]
