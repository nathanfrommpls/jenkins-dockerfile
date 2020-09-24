FROM jenkins/jenkins:lts

USER root
RUN mkdir -p /etc/pki/jenkins
RUN apt-get update && apt-get install -y gcc
RUN keytool -genkey -keyalg RSA -alias jenkins -keystore /etc/pki/jenkins/keystore.jks -storepass password -validity 360 -keysize 2048 -noprompt -dname "CN=jenkins, ou=unit, O=organization, L=City, S=State, C=US"
RUN chown -R jenkins /etc/pki/jenkins
USER jenkins

ENV JENKINS_OPTS --httpPort=-1 --httpsPort=8443 --httpsKeyStore=/etc/pki/jenkins/keystore.jks --httpsKeyStorePassword=password

EXPOSE 8083 50000
