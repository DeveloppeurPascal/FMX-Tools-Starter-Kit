# 20240902 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

* mise à jour des dépendances
* ajout d'une option de configuration pour afficher/masquer l'option de menu pour paramétrer le style de l'application
* ajout d'une option de configuration pour afficher/masquer l'option de menu pour paramétrer la langue de l'application
* ajout d'une option de configuration pour afficher/masquer l'option de menu pour paramétrer les options de l'application
* ajout d'une option de configuration pour afficher/masquer l'option de menu pour paramétrer les options du projet actuel
* gestion de l'affichage de l'option Help/Support en fonction de l'existence ou non de l'URL associée en paramètres du programme avec une option permettant de contourner ce fonctionnement
* modification des actions pour rendre leur fonctionnement plus personnalisable dans les fenêtres descendantes sans toucher aux propriétés des composants de la fiche ancêtre
* réactivation des plateformes iOS et "simulateur iOS" sur le projet
* modification des informations de version en RELEASE pour la compilation 32/64 sur Android64, Intel+ARM sur macOS ARM, l'incrément automatique des numéros de version et le nom de packet par défaut en "olfsoftware.fmxtoolstemplate.*"
* masquage du menu principal pour iOS et Android (il faudra faire une TToolBar pour ces plateformes)
* sur macOS on déplace le contenu du menu "Tools" vers le menu de l'application en "Réglages" ou "Preferences"
* ajout d'un filtrage des styles au niveau de leur référencement dans le projet afin de n'accepter que ceux qui ont une implémentation ou un contenu pour la plateforme cible actuelle (par rapport au compilateur utilisé)
* ajout d'une fenêtre de choix des styles pour les cas pris en charge (light/dark en systeme ou au choix)
* appel de la fenêtre de paramétrage des styles depuis le menu de la fiche principale ancêtre
* ajout des styles Polar light et dark au projet d'exemple (en privé)
* forçage en minuscules des noms des thèmes dans la configuration pour s'assurer que les comparaisons sont faites partout de la même façon

## Reste à faire

* implémenter un référencement des langues disponibles et de leurs traductions
* écran de paramétrage de la langue active à partir des langues disponibles dans le projet
* menus de gestion d'un document
* menus de gestion des documents précédents
* menus de gestion des documents ouverts (si pris en charge dans les paramètres du programme)
* finaliser la classe "document" par défaut
* ajouter les commentaires XML Doc sur toutes les unités du projet
* ajouter un "how to start" sous forme de doc
* gérer le chiffrement des documents enregistrés en RELEASE (à répercuter sur Gamolf FMX Game Starter Kit aussi)
* mettre en place un site avec la documentation du projet
* mettre en place de présentation du projet
