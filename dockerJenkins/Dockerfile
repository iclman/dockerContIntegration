FROM ubuntu:14.04.3

ENV APT_GET_UPDATE 2015-07-16
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jre-headless wget && apt-get clean
ENV JENKINS_HOME /var/jenkins_home
RUN useradd -d "$JENKINS_HOME" -u 1000 -m -s /bin/bash jenkins
RUN mkdir -p /home/jenkins
RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d

# init.groovy will set the JENKINS_SLAVE_AGENT_PORT for jnlp
ENV JENKINS_SLAVE_AGENT_PORT 50000
COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy
WORKDIR /home/jenkins
ENV JENKINS_DOWNLOAD https://updates.jenkins-ci.org/download/war
ENV JENKINS_VERSION 1.625.1
ENV JENKINS_WAR jenkins.war
RUN wget $JENKINS_DOWNLOAD/$JENKINS_VERSION/$JENKINS_WAR

COPY keystore.jks /home/jenkins/
COPY start_jenkins.sh /home/jenkins/
ENV JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
ENV PATH=$PATH:/usr/lib/jvm/java-7-openjdk-amd64/bin
ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log
ENV JENKINS_UC https://updates.jenkins-ci.org
RUN chown -R jenkins "$JENKINS_HOME" /usr/share/jenkins/ref
# /usr/share/jenkins/
RUN chmod +x /home/jenkins/start_jenkins.sh
VOLUME /var/jenkins_home
USER jenkins

# EXPOSE 8443 for HTTPS and 50000 for slave connections
EXPOSE 8443
EXPOSE 50000
#CMD=["start_jenkins.sh"]
ENTRYPOINT ["/home/jenkins/start_jenkins.sh"]

