# Jenkins setup for Laravel testing
---

  * Files:
    * `Dockerfile` for building docker image.
    * `docker-compose.yml` for running image as service.
    * `plugins.txt` list of Jenkins plugins to be installed on image creation.
    * `Jenkinsfile` list of commands for running tests. To be converted to scripted pipeline later.
    * `account.groovy` scipt for creating user(s). Default is `admin:admin`.

## Jenkins setup

  * Jenkins master run command `docker run -p 127.0.0.1:8080:8080 --name=jenkins-master -d --env JAVA_OPTS="-Xmx8192m" --env JENKINS_OPTS="--handlerCountStartup=100 --handlerCountMax=300" <jenkins_docker_image>`. [link](https://engineering.riotgames.com/news/putting-jenkins-docker-container)

## Jenkins jobs

  * gator -- used to run tests on gator [project](https://bitbucket.org/xceedcloud/gator)

## Triggering Jenkins builds manually

There are 2 steps to running build manually:

  1. Get CSRF protection by getting Jenkins crumb. `wget -q --auth-no-challenge --user USERNAME --password PASSWORD --output-document - \
  'JENKINS_URL/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)'` while swapping USERNAME, PASSWORD and JENKINS\_URL with actual real values.
  2. Add result of previous request as header to request sent to Jenkins to trigger build manually.
    * `curl -u USERNAME:PASSWORD -H "result of previous command" JENKINS_URL/job/JOB_NAME/build`
