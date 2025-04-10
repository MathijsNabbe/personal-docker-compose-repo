# SonarQube
This container will initialise a SonarQube instance, used for active code analysis by a Github Runner.

## Community Plugin
Certain features are behind a paywall in SonarQube. Fortunatly, a community plugin that enabels these features exists. The installation of this is fairly simple, and is instructed on the [original repository](https://github.com/mc1arke/sonarqube-community-branch-plugin?tab=readme-ov-file#installation). The necessary volumes have been mapped:

* /var/lib/docker/volumes/sonarqube_sonarqube_extensions/_data/plugins
* /var/lib/docker/volumes/sonarqube_sonarqube_conf/_data/sonar.properties