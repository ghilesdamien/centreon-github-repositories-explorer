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
## Avant propos
* J'ai fait le choix pour ce test d'utiliser un dépot git et docker registry publics pour ne pas m'encombrer de notion d'authentification et faciliter le partage, ce ne serait pas le cas dans un contexte de production.
* J'ai aussi fait le choix de mettre en configuration l'archive utilisée comme source pour le RPM, vu que le nom de cette archive est lié au fichier spec fourni, ce n'est pas au job jenkins qui fait le build d'archiver les sources. Cependant dans un contexte de production, on pourrait créer un script ou un job jenkins qui génère le fichier de spec et l'archive.
* J'ai fait une première version 0.0.1 du script pour récupérer les dépots GitHub de façon brute, puis une 0.0.2 avec un affichage amélioré.
## Livrables
* le code du script shell : [centreon-github-repositories-explorer/SOURCES/centreon-github-repositories-explorer-0.0.1/centreon-github-repositories-explorer.sh](https://github.com/ghilesdamien/centreon-technical-test/blob/main/centreon-github-repositories-explorer/SOURCES/centreon-github-repositories-explorer-0.0.1/centreon-github-repositories-explorer.sh)
* le code de spec RPM : [centreon-github-repositories-explorer/SPECS/centreon-github-repositories-explorer.spec](https://github.com/ghilesdamien/centreon-technical-test/blob/main/centreon-github-repositories-explorer/SPECS/centreon-github-repositories-explorer.spec)
* le Dockerfile de l’image qui permet de build le RPM : [rpmbuilder/Dockerfile](https://github.com/ghilesdamien/centreon-technical-test/blob/main/rpmbuilder/Dockerfile)
  * J'ai essayé de faire une image la plus générique possible pour construire n'importe quel RPM.
  * L'image générée est à disposition sur mon registry GitHub : ghcr.io/ghilesdamien/rpmbuilder:latest
  * Pour utiliser un container à partir de cette image il faut :
    * Un volume liant le dossier contenant les sources vers le dossier /home/rpmbuilder/rpmbuild/SOURCES du container
    * Un volume liant le dossier contenant les spécifications vers le dossier /home/rpmbuilder/rpmbuild/SPECS du container
    * Une variable d'environnement SPEC_FILE contenant le nom du fichier de spécification
    * Eventuellement un volume liant le dossier qui contiendra le résultat de la construction vers le dossier /home/rpmbuilder/rpmbuild/RPMS du container (le dossier doit être créé avec le bon utilisateur auparavant)
  * Exemple de lancement :
    * `docker run -it --rm -v $(pwd)/SPECS:/home/rpmbuilder/rpmbuild/SPECS -v $(pwd)/SOURCES:/home/rpmbuilder/rpmbuild/SOURCES -v $(pwd)/RPMS:/home/rpmbuilder/rpmbuild/RPMS --env SPEC_FILE=centreon-github-repositories-explorer-0.0.2.spec ghcr.io/ghilesdamien/rpmbuilder:latest`
  * Le résultat de la construction se trouvera dans le dossier -v $(pwd)/RPMS
* le Jenkinsfile qui décrit la pipeline : [jenkins/Jenkinsfile](https://github.com/ghilesdamien/centreon-technical-test/blob/main/jenkins/Jenkinsfile)
  * J'ai essayé de faire une pipeline la plus générique possible pour construire un RPM à partir de n'importe quel dépot git public.
  * Nécessite 4 paramètres :
    * spec_file : le nom du fichier de spécification se trouvant dans le dossier SPECS (centreon-github-repositories-explorer-0.0.2.spec)
    * git_repo :  l'url de dépot public git (https://github.com/ghilesdamien/centreon-technical-test)
    * sources_folder_path : le chemin vers le dossier du dépot git contenant les sources du RPM (centreon-github-repositories-explorer/SOURCES)
    * specs_folder_path : le chemin vers le dossier du dépot git contenant le fichier de spécification du RPM (centreon-github-repositories-explorer/SPECS)
  * La pipeline a besoin du plugin Jenkins [Docker Pipeline](https://plugins.jenkins.io/docker-workflow)
  * Je n'ai pas réussi à utiliser un volume pour le dossier RPMS dans la pipeline, pour ne pas y passer trop de temps, j'ai choisi de faire un "docker cp" précédé d'un "sleep 1" car parfois le dossier copié était vide. Dans un contexte de production il faudrait faire mieux, tout comme pour la gestion des erreurs.

