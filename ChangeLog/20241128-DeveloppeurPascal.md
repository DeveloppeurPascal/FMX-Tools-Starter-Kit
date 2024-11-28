# 20241128 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

* mise à jour des dépendances
* ajout du dépôt de client Delphi pour l'API de gestion de licences CilTseg
* ajout de nouveau paramètres dans la configuration par défaut pour gérer des clés de licence et leur activation
* ajout de nouvelles constantes sur le projet pur prendre en charge cette URL et les licences
* ajout d'un fichier à paramétrer pour utiliser (ou pas) l'API de CilTseg
* ajout de l'URL facultative de la page de vente du logiciel en constante
* conditionnement d'un bouton de la boite "à propos" pour acheter le logiciel
* conditionnement d'une option de menu pour acheter le logiciel
* ajout des boutons "register" et "show license" à la boite de dialogue "à propos"
* ajout d'une option de menu "register" au menu principal avec son action
* ajout d'une constante (indépendante de CilTseg) pour gérer l'affichage des options de menus et boutons en lien avec la saisie d'un numéro de licence (charge au développeur final de surcharger les méthodes concernées afin d'y mettre le code qui l'intéresse)
* ajout d'un contrôle de la saisie du numéro de licence au démarrage du programme lorsqu'elle est nécessaire avec affichage de la boite d'enregistrement ou la boite à propos selon si CiltTseg est actif ou non sur le projet.
* ajout d'une fonction de recherche de la nouvelle version du logiciel avec son option de menu et sa constante permettant de l'afficher ou non
