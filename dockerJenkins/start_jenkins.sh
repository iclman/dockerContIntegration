#!/bin/bash

exec java -jar /home/jenkins/jenkins.war --prefix=/jenkins --httpPort=-1 --httpsPort=8443 --prefix=/jenkins --ajp13Port=-1 --httpsKeyStore=/home/jenkins/keystore.jks --httpsKeyStorePassword=changeit
