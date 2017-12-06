ARG jenkins_version=2.73.3
FROM jenkins/jenkins:${jenkins_version}

USER root
## set timezone, install docker deps
RUN ln -fs /usr/share/zoneinfo/CET /etc/localtime \
    && apt-get update \
    && apt-get install --assume-yes --no-install-recommends libltdl7 \
    && rm -rf /var/lib/apt/lists/*

### install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt \
    && chown jenkins:jenkins -R /usr/share/jenkins ${JENKINS_HOME}

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
USER jenkins
COPY ./account.groovy /usr/share/jenkins/ref/init.groovy.d/ 
ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
