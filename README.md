# EUR8217

Dépôt de mes notes de cours et bouts de code pour le cours  
*EUR8217 - Méthodes quantitatives appliquées aux études urbaines*   
de l'INRS, dans le cadre du   
[Programme court de 2e cycle en analyse de données spatiales (0894).][0894]

# Notes de cours

Les notes de cours sont dans `notes`.

# Labo

Les bouts de code de stats. Nécessite l'environnement technique ci-dessous.

Mon objectif est de coder les mêmes exercices en R et en Python.

# Environnement technique

La science doit être ouverte. Elle doit donc reposer sur des outils ouverts et des données ouvertes. Comment reproduire les résultats autrement?

Ci-dessous les instructions pour créer un **environnement technique scientifique ouvert**, identique à celui que j'ai utilisé.

Essentiellement, il s'agit d'un environnement technique qui peut être installé
par n'importe qui, sur n'importe quel ordinateur, et qui offre une suite scientifique complète et ouverte,
notamment pour les statistiques.

L'environnement technique repose sur **Anaconda**, un package manager à l'origine pour **Python** mais qui supporte plusieurs langages, notamment **R**. Anaconda, avec son utilitaire `conda`, simplifie grandement la gestion des paquets. Il s'agit d'un logiciel open source créé par la compagnie Continuum Analytics.

Anaconda s'installe "localement" dans le répertoire de votre utilisateur (`home`). Pas besoin d'avoir les droits d'administrateur sur votre machine (on n'installe rien "côté système")... si vous voulez supprimer ensuite Anaconda, vous n'avez qu'à supprimer le répertoire où il a été installé (par défaut `anaconda` ou `anaconda3`).

En installant Anaconda, on installe par défaut **Jupyter** qui permet la création de notebook : du code que l'on peut encadrer de texte et qu'on peut exécuter interactivement... et exporter/partager.

Jupyter peut gérer du code R ou Python, pour peu que R ait été installé. On installera R avec conda.

Jupyter permet de saisir du texte avec la syntaxe **Markdown** : utile pour mettre des titres, commenter, mettre des liens, lister des étapes, etc.

## Pré-requis technique

Aucun, sinon une connexion Internet pour télécharger Anaconda et les paquets de R.

Fonctionne sous Linux, Mac, Windows.

## Anaconda

https://anaconda.org/
https://www.continuum.io/why-anaconda

* downloader Anaconda : https://www.continuum.io/downloads
    * choisir préférablement Python3 pour sa plateforme (Linux, Mac, Windows | 32-64 bits)
    * *les ordinateurs récents ont des systèmes d'exploitation 64 bits*
        * si 64 bits ne fonctionne pas, alors prendre 32-bit ;)
    * ex.: Python3 pour Linux 64-bit
* suivre les instructions sur le site au besoin
    * ex.: Python 3 pour Linux 64-bit : `$ bash Anaconda3-2.4.1-Linux-x86_64.sh`
* accepter le "prepand" du path Python
    * sur votre système, Python par défaut deviendra le Python de Anaconda
* fermer le terminal
* Anaconda se supprime entièrement en supprimant le répertoire local `anaconda` ou `anaconda3`

## R

https://www.r-project.org/
https://journal.r-project.org/

* ouvrir un terminal
* installer les packages r
```
$ conda install -c r r-essentials
```
* on peut installer des packages R au besoin, dans les notebooks

## Python

https://www.python.org/

* installé par défaut avec Anaconda

## Autres ressources pour R avec Jupyter

* https://www.continuum.io/blog/developer/jupyter-and-conda-r
* http://blog.revolutionanalytics.com/2015/09/using-r-with-jupyter-notebooks.html

# Utilisation

Un coup l'environnement technique créé, lancer Jupyter pour coder en R ou Python et rédiger en Markdown!

## Jupyter

http://jupyter.org/

* ouvrir un terminal
* taper
```
$ jupyter notebook
```
* une page web locale s'ouvre dans votre navigateur (jupyter fait le serveur)
* elle affiche l'arborescence des fichiers du répertoire d'où vous avez lancé le terminal
    * par défaut votre `home`
* ouvrir un fichier .ipynb existant ou en créer un
* pour créer un notebook en R, cliquez sur "New" en haut à droite et choisissez "R"
    * donnez un nom à votre notebook
    * ajoutez des blocs (cells) de texte en markdown
        * pour rendu visuel : ctrl+enter
    * ajoutez des blocs (cells) de code en R
        * pour exécuter : ctrl+enter
    * regarder l'aide et les raccourcis clavier pour devenir efficace
* **coder, rédiger**
* sauvegarder au besoin (il y a aussi des sauvegardes automatiques)
* fermer le navigateur
* quitter le terminal
* partager les .ipynb avec des personnes ayant le même environnement technique scientifique ouvert

## Markdown

https://daringfireball.net/projects/markdown/syntax

* utilisé dans Jupyter pour les blocs de texte
* voir le lien pour la syntaxe officielle : https://daringfireball.net/projects/markdown/syntax

## R

Pour installer de nouveaux packages R, il faut fournir le repo voulu
* ce code ne suffit pas
```
install.packages("nortest")
```
* ce code fonctionne
```
install.packages("nortest", repos="http://cran.rstudio.com/")
```

# R et Python dans un même notebook

* installer un module Python qui communique avec R
```
$ pip install rpy2
```
* dans Jupyter, charger l'extension ipython (ancien nom de Jupyter) disponible dans le module rpy2 installé (idéalement en début de fichier, avant les import Python)
```
%load_ext rpy2.ipython
```
* commencer ses *code cells* avec `%%R`
* utiliser en *inline* R dans du code Python avec `%R -o` et `%R -i` (ex.: passer array numpy à R)

## Autres approches (moins intéressantes)

* http://www.kdnuggets.com/2015/12/using-python-r-together.html
* [Beaker Notebook][http://decisionstats.com/2015/12/07/decisionstats-interview-scott-draves-beaker-notebook/]
    * https://github.com/twosigma/beaker-notebook/wiki/Roadmap

# Packages Python

```
$ pip install -r requirements.txt
```

Si erreur avec pip install, télécharger manuellement les sources de pipy et installez-les avec pip en local
ex.:
* download tar.gz de https://pypi.python.org/pypi/sas7bdat
* extract
* install with pip

```
$ pip install ./sas7bdat-2.0.7
```

# Impression

On peut convertir un Jupyter notebook en PDF.
Sur votre système (ici : Linux basé sur Debian, ex.: Ubuntu 14.04), pandoc et latex doivent être installés:
```
$ sudo apt-get install pandoc
$ sudo apt-get install tex-common texlive-latex-base texlive-lang-french
sudo apt-get install --no-install-recommends texlive-latex-extra
sudo apt-get install --no-install-recommends texlive-fonts-recommended
sudo apt-get install --no-install-recommends texlive-generic-recommended
```

Pour imprimer en ligne de commande :
```
$ jupyter nbconvert /labo/labo2.ipynb --to pdf
```

Pour imprimer via interfaces graphiques :
* File > Download as > PDF via LaTeX (.pdf)

# Remerciements

* Merci à deuxpi de Montréal-Python pour R dans Python

# Références

* http://www.math.univ-toulouse.fr/~besse/Wikistat/pdf/st-tutor1-python-start.pdf
* https://www.kevinsheppard.com/images/0/09/Python_introduction.pdf

---

[0894]:http://www.inrs.ca/static/prog/UCS-ProgrammeCourtDe2ECycleEnAnalyseDeDonneesSpatial-0894.html
