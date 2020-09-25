FROM jenkins/jenkins:lts

USER root
RUN curl -o /usr/local/bin/terraform.zip https://releases.hashicorp.com/terraform/0.13.3/terraform_0.13.3_linux_amd64.zip
RUN unzip /usr/local/bin/terraform.zip -d /usr/local/bin/
RUN mkdir -p /etc/pki/jenkins
RUN apt-get update && apt-get install -y gcc awscli openjdk-8-jdk
RUN keytool -genkey -keyalg RSA -alias jenkins -keystore /etc/pki/jenkins/keystore.jks -storepass password -validity 360 -keysize 2048 -noprompt -dname "CN=jenkins, ou=unit, O=organization, L=City, S=State, C=US"
RUN chown -R jenkins /etc/pki/jenkins

USER jenkins
RUN mkdir ~/.aws
COPY config ~/.aws/config
COPY credentials ~/.aws/credentials

ENV JENKINS_OPTS --httpPort=-1 --httpsPort=8443 --httpsKeyStore=/etc/pki/jenkins/keystore.jks --httpsKeyStorePassword=password

EXPOSE 8443 50000
