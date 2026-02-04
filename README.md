# Template pour projet C++ moderne

## Table des matières

- [Fonctionnalités](#fonctionnalités)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Contribution](#contribution)
- [FAQ](#faq)
- [Licence](#licence)
- [Auteurs](#auteurs)

## Fonctionnalités

Ce dépôt est un template pour projets C++ modernes. Il utilise Docker avec une image Debian 13.3 (trixie) comme environnement de développement.

La toolchain inclut les outils suivants avec leurs versions :
- **g++** : 14.2.0 (compilateur C++)
- **git** : 2.47.3 (gestion de versions)
- **valgrind** : 3.24.0 (détection de fuites mémoire)
- **cccc** : 3.1.6 (analyse de métriques code)
- **cppcheck** : 2.17.1 (analyse statique)
- **gdb** : 16.3 (débogueur)
- **doxygen** : 1.9.8 (génération de documentation)
- **uncrustify** : 0.78.1 (formatage de code)
- **cmake** : 3.31.6 (système de build)
- **make** : 4.4.1 (outil de build)

Le template inclut également :
- Un workflow GitHub Actions CI/CD prêt à l'emploi (fichier `.github/workflows/c-cpp.yml`)
- Configuration pré-établie pour le formatage de code avec uncrustify (fichier `.uncrustify`)
- Configuration doxygen pour la génération de documentation
- Un fichier `.gitignore` adapté aux projets C++

**Détails sur la configuration uncrustify :**
Le fichier `.uncrustify` est configuré pour formater le code C++ selon les conventions snake_case, avec des règles adaptées pour les noms de variables, fonctions et classes.

## Prérequis

Pour utiliser ce template, vous avez besoin de :
- **VSCode** avec l'extension **Dev Containers** (ou **VSCodium** avec **DevPod**)
- **Docker** installé et fonctionnel sur votre machine
- **Git** pour le contrôle de version
- **Compilateur C++** (g++ ou clang++) pour le développement local (optionnel)

**Recommandations supplémentaires :**
- **Extension C/C++** pour VSCode/Codium pour une meilleure expérience de développement
- **Extension CMake Tools** pour la gestion des builds CMake

## Installation

1. Créez un nouveau dépôt GitHub/GitLab en utilisant ce template
2. Clonez votre nouveau dépôt localement
3. Ouvrez le projet dans VSCode/VSCodium
4. Utilisez la commande "Reopen in Container" pour lancer l'environnement Docker
5. Le container se construira automatiquement avec tous les outils nécessaires

## Utilisation

Une fois dans le container :
- Le projet est configuré avec CMake
- Utilisez `make` pour compiler
- Les outils d'analyse (cppcheck, valgrind, etc.) sont disponibles
- Les tests peuvent être exécutés avec la commande appropriée
- Utilisez `doxygen` pour générer la documentation
- Utilisez `uncrustify` pour formater le code selon les règles définies

**Commandes utiles :**
```bash
# Générer le projet
make configure

# Compiler le projet
make build

# Exécuter les tests
make test

# Analyser le code avec cppcheck
make analyse

# Formater le code avec uncrustify
make format
```

## Contribution

Pour l'instant, ce projet est maintenu uniquement par OliveiraDF. Les contributions sont les bienvenues !

## FAQ

**Q: Comment ajouter des dépendances ?**
R: Modifiez le fichier CMakeLists.txt et ajoutez vos dépendances via `find_package()` ou `add_subdirectory()`.

**Q: Comment exécuter les tests ?**
R: Utilisez `make test` dans le répertoire de build.

**Q: Comment analyser la qualité du code ?**
R: Utilisez `cppcheck` pour l'analyse statique et `valgrind` pour détecter les fuites mémoire.

## Licence

Ce projet est sous licence CeCILL. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

## Auteurs

- **OliveiraDF** - Créateur et mainteneur principal