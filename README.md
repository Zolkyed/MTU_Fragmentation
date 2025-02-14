# Script de test de fragmentation MTU

Ce script PowerShell est conçu pour tester la fragmentation de paquets lors de la transmission sur un réseau. Il ajuste dynamiquement la taille du tampon (buffer) en fonction des réponses aux tests de ping, afin de déterminer la taille du paquet maximale sans fragmentation.

## Fonctionnalités

- **Test de fragmentation** : Le script envoie des pings à une adresse IP spécifiée avec différentes tailles de buffer et identifie si des paquets sont fragmentés.
- **Détermination de la taille optimale** : Il ajuste automatiquement la taille du tampon en fonction des résultats du test pour trouver la taille maximale (MTU) sans fragmentation.

## Variables

- **$TailleBufferMax** : Taille maximale du tampon (buffer), par défaut 1500 octets.
- **$AdresseTest** : L'adresse IP cible pour tester la connexion (par défaut `1.1.1.1`).
- **$TailleBuffer** : Taille du tampon utilisée pour envoyer le ping, ajustée pendant le test.

## Utilisation

1. Exécutez le script en utilisant la commande suivante :
   .\mtuFragmentation.ps1


## Résultats

À la fin de l'exécution, le script affichera les informations suivantes :

- **MTU** : La taille maximale du tampon sans fragmentation.
- **MTU+EnTêtes** : La taille totale du paquet, incluant les en-têtes (ajout de 28 octets pour les en-têtes IP et ICMP).

## Exemple de sortie

750, 1125, 1312, 1406, 1453, 1476, 1464, 1470, 1473, 1472, trouvé.

MTU: 1472

MTU+EnTetes: 1500


