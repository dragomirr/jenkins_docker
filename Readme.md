# Jenkins setup for Laravel testing
---

  * Files:
    * `Dockerfile` for building docker image.
    * `docker-compose.yml` for running image as service.
    * `plugins.txt` list of Jenkins plugins to be installed on image creation.
    * `Jenkinsfile` list of commands for running tests. To be converted to scripted pipeline later.
    * `account.groovy` scipt for creating user(s). Default is `admin:admin`.
