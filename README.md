# launchd-jobs
<details><summary><b>Version Française</b></summary>

## Procédure
Ceci est un répertoire contenant des scripts d'automatisation de tâches sur un environnement de travail MacOSX.
`osascript` sera souvent utilisé.

Chaque sous-répertoire est constitué de cette forme:
- un script effectuant la tâche.
- un fichier plist programmant la tâche.
- un README explicatif de la tâche.

C'est à vous de placer les fichiers aux bons endroits.

<details><summary><b>Le script</b></summary>

### Le script
Le script est à installer à sa convenance dans son espace `${HOME}`. 
- Il faudra lui donner les droits d'exécution => `chmod +x <scriptname>`. 
- Pas de `sudo` dans le script! => Il faudra aller voir du côté des daemons launchd pour ce faire.
- Ne pas oublier le shebang en début de script => `#!/bin/sh` pour un script shell, etc.
</details>

<details><summary><b>Le fichier de plannification</b></summary>

### Le fichier de plannification
Le fichier plist est à enregistrer dans son répertoire `${HOME}/Library/LaunchAgents`.
- C'est une bonne pratique que de préfixer son plist avec `local` => `local.update.brew.plist`. Ça permet de regrouper les scripts locaux et de les retrouver plus facilement.
- Il faudra absolument indiquer le chemin absolu du script à planifier, dans chacun des plist de ce dépôt, il faudra donc remplacer cette ligne => `<string>/absolute/path/to/executable/task-name.ext</string>`. `task-name.ext` est le nom du script! (ne mettez pas ceci littéralement, vous allez avoir des surprises). On ne met aucune variable d'environnemnt dans le chemin (on écrit tout en dur).
- Il faut absolument créer les scripts de log avant de lancer la premiere tâche => `touch /tmp/local.task.name.{err,out}`. Les noms des fichiers de log peuvent être ceux qui vous conviennent le mieux, j'ai trouvé plus simple de les nommer selon leurs tâches.
- Penser à modifier la planification si celle que j'y ai mise ne vous convient pas.
</details>

<details><summary><b>La plannification</b></summary>

### La plannification

<details><summary><b>Démarrer</b></summary>

#### Démarrer
Il faut charger et démarrer le fichier de plannification. `task-name.plist` est à remplacer par le nom du fichier de plannification et `task-name` par le nom de la tâche.

```sh
launchctl load ${HOME}/Library/LaunchAgents/task-name.plist
launchctl start task-name
```
</details>

<details><summary><b>Arrêter</b></summary>

#### Arrêter
Il faut stopper et décharger le fichier de plannification. `task-name.plist` est à remplacer par le nom du fichier de plannification et `task-name` par le nom de la tâche.

```sh
launchctl stop task-name
launchctl unload ${HOME}/Library/LaunchAgents/task-name.plist
```
</details>

<details><summary><b>Vérifier le status d'une tâche</b></summary>

#### Vérifier le status d'une tâche
`task-name.plist` est à remplacer par le nom du fichier de plannification et `task-name` par le nom de la tâche.

```sh
launchctl list | grep task-name | awk '{if ($2 != 0) {print $2}}' | xargs launchctl error
```
</details>

</details>

</details>

<details><summary><b>English Version</b></summary>

## Procedure
This is a directory containing task automation scripts on a MacOSX work environment.

`osascript` will be often used. 

Each subdirectory consists of this form: 
- a script performing the task. 
- a plist file programming the task. 
- a README describing the task.

It is on your own to move the files at the right place.

<details><summary><b>The script</b></summary>

### The script 
The script has to be installed at its convenience in its `${HOME}` space. 
- It will be necessary to give it the execution rights => `chmod +x <scriptname>`. 
- No `sudo` in the script! => You'll have to look at the launchd daemons side to do this. 
- Don't forget the shebang at the beginning of the script => `#!/bin/sh` for a shell script, etc. 
</details>

<details><summary><b>The planning file</b></summary>

### The planning file 
The plist file is to be saved in its directory `${HOME}/Library/LaunchAgents`. 
- It is a good practice to prefix your plist with `local` => `local.update.brew.plist`. This makes it possible to group local scripts and find them more easily.
- It will be absolutely necessary to indicate the absolute path of the script to be scheduled, in each of the plist of this repository, it will therefore be necessary to replace this line => `<string>/absolute/path/to/executable/task-name.ext</string>`. `task-name.ext` is the name of the script! (Do not put this literally, you will have surprises) 
- It is absolutely necessary to create the log scripts before launching the first task => `touch /tmp/local.task.name.{err,out}`. The names of the log files may be the ones that suit you best, I found it easier to name them according to their tasks. 
- Remember to change the schedule if the one I put on it does not suit you. 
</details>

<details><summary><b>The planning</b></summary>

### The planning 

<details><summary><b>Start</b></summary>

#### Start 
You must load and start the planning file. `task-name.plist` has to be replaced by the name of the planning file and `task-name` by the name of the task. 
```sh
launchctl load ${HOME}/Library/LaunchAgents/task-name.plist 
launchctl start task-name
 ```
</details>

<details><summary><b>Stop </b></summary>

#### Stop 
You must stop and unload the planning file. `task-name.plist` has to be replaced by the name of the planning file and `task-name` by the name of the task. 
```sh 
launchctl stop task-name 
launchctl unload ${HOME}/Library/LaunchAgents/task-name.plist 
``` 
</details>

<details><summary><b>Check the status of a task </b></summary>

#### Check the status of a task 
`task-name.plist` has to be replaced by the name of the planning file and `task-name` by the name of the task. 

```sh
launchctl list | grep task-name | awk '{if ($2! = 0) {print $2}}' | xargs launchctl error
```
</details>

</details>

</details>

## Tasks Listing
- [x] [clean.trash](./clean_trash/)
- [x] [update.brew](./update_brew/)

## Documentation

- Mon premier article sur le sujet, avec un exemple de mise en place : [Lien](https://medium.com/p/3cc98a795613)
- [Official launchd Documentation](https://www.launchd.info/)
- [LaunchControl (A GUI Scheduler based on launchd)](https://www.soma-zone.com/LaunchControl/)
- [Fixing cron jobs in Mojave](https://www.bejarano.io/fixing-cron-jobs-in-mojave/)
- [JXA](https://developer.apple.com/library/archive/releasenotes/InterapplicationCommunication/RN-JavaScriptForAutomation/Articles/Introduction.html#//apple_r)
- [AppleScript](https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/introduction/ASLR_intro.html#//apple_ref/doc/uid/TP40000983-CH208-SW1)
- [Apple Daemons Documentation](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/Introduction.html#//apple_ref/doc/uid/10000172i-SW1-SW1)
- [Script Management with Launchd](https://support.apple.com/fr-fr/guide/terminal/apdc6c1077b-5d5d-4d35-9c19-60f2397b2369/mac)