set(COMPILER_WARNINGS 
	/WX								# Traite tous les warnings comme des erreurs
	/W4								# Active le niveau maximal d’avertissements utile
	/wd4068							# Supprime l'avertissement de directive de compilation inconnue
	/wd4275							# Supprime l'avertissement DLL interface manquante sur une classe de base
)

set(COMPILER_RELEASE_OPTIMISATION
	/O2								# Optimisation maximale de code en Release (favorise la vitesse)
)

set(COMPILER_DEBUG_OPTIMISATION
	/Zi								# Génère les informations de débogage dans un fichier PDB
	/Od								# Désactive les optimisations, utile pour déboguer
)

set(CPPCHECK_PLATFORM "win64")