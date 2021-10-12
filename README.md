# Enoncé du test technique 
## Objet
Ce test a pour but d'évaluer vos compétences sur les technologies utilisées chez
Centreon dans le cadre de son release management.
Seront ensuite jugés non seulement le résultat mais aussi la démarche adoptée pour
arriver au bout de l’exercice.
## Sujet
Voici ce qui est attendu pour ce test :
* Rédiger un script shell qui retourne en console la liste des repo Github de
l'organisation Centreon
Une mise en forme propre de l’affichage serait un plus.
* Configurer un fichier de spec RPM qui permet de builder un RPM qui se
charge de déployer ce script
* Rédiger un pipeline Jenkins (Jenkinsfile) qui
  * checkout le repo Github qui contient le code
  * build le RPM dans docker
* Monter un jenkins avec un job qui exécute ce pipeline
## Livrables attendus
Les livrables sont attendus dans un repository sur github avec :
* le code du script shell
* le code de spec RPM
* le Dockerfile de l’image qui permet de build le RPM
* le Jenkinsfile qui décrit le pipeline
* optionnellement : un Dockerfile qui permet de démarrer une image Jenkins
avec ce job de configuré
N’hésitez pas à commenter ou documenter votre travail.

# Documentation du test technique
## Livrables
* le code du script shell : [centreon-github-repositories-explorer/SOURCES/centreon-github-repositories-explorer-0.0.1/centreon-github-repositories-explorer.sh](https://github.com/ghilesdamien/centreon-technical-test/blob/main/centreon-github-repositories-explorer/SOURCES/centreon-github-repositories-explorer-0.0.1/centreon-github-repositories-explorer.sh)
* le code de spec RPM : [centreon-github-repositories-explorer/SPECS/centreon-github-repositories-explorer.spec](https://github.com/ghilesdamien/centreon-technical-test/blob/main/centreon-github-repositories-explorer/SPECS/centreon-github-repositories-explorer.spec)
* le Dockerfile de l’image qui permet de build le RPM : [rpmbuilder/Dockerfile](https://github.com/ghilesdamien/centreon-technical-test/blob/main/rpmbuilder/Dockerfile)
* le Jenkinsfile qui décrit le pipeline : [jenkins/Jenkinsfile](https://github.com/ghilesdamien/centreon-technical-test/blob/main/jenkins/Jenkinsfile)

