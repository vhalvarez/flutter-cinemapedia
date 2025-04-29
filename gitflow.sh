#!/bin/bash

# GitFlow Helper para el proyecto Cinemapedia
# Este script ayuda a gestionar las ramas siguiendo el modelo GitFlow

case "$1" in
  feature)
    if [ -z "$2" ]
    then
      echo "Debes especificar un nombre para la característica"
      echo "Ejemplo: ./gitflow.sh feature nueva-pantalla"
      exit 1
    fi
    
    echo "Creando nueva rama feature/$2 desde develop..."
    git checkout develop
    git pull origin develop
    git checkout -b feature/$2
    echo "Rama feature/$2 creada. Ahora puedes comenzar a desarrollar."
    ;;
    
  finish-feature)
    if [ -z "$2" ]
    then
      echo "Debes especificar el nombre de la característica a finalizar"
      echo "Ejemplo: ./gitflow.sh finish-feature nueva-pantalla"
      exit 1
    fi
    
    echo "Finalizando feature/$2..."
    git checkout develop
    git pull origin develop
    git merge --no-ff feature/$2
    git push origin develop
    git branch -d feature/$2
    echo "Feature finalizada y fusionada en develop."
    ;;
    
  release)
    if [ -z "$2" ]
    then
      echo "Debes especificar una versión para la release"
      echo "Ejemplo: ./gitflow.sh release 1.0.0"
      exit 1
    fi
    
    echo "Creando nueva rama release/$2 desde develop..."
    git checkout develop
    git pull origin develop
    git checkout -b release/$2
    echo "Rama release/$2 creada. Realiza las correcciones finales y ajustes de metadatos."
    ;;
    
  finish-release)
    if [ -z "$2" ]
    then
      echo "Debes especificar la versión de la release a finalizar"
      echo "Ejemplo: ./gitflow.sh finish-release 1.0.0"
      exit 1
    fi
    
    echo "Finalizando release/$2..."
    git checkout main
    git pull origin main
    git merge --no-ff release/$2
    git tag -a v$2 -m "Versión $2"
    git push origin main --tags
    
    git checkout develop
    git pull origin develop
    git merge --no-ff release/$2
    git push origin develop
    
    git branch -d release/$2
    echo "Release $2 finalizada y desplegada en main y develop."
    ;;
    
  hotfix)
    if [ -z "$2" ]
    then
      echo "Debes especificar un nombre para el hotfix"
      echo "Ejemplo: ./gitflow.sh hotfix correccion-login"
      exit 1
    fi
    
    echo "Creando nueva rama hotfix/$2 desde main..."
    git checkout main
    git pull origin main
    git checkout -b hotfix/$2
    echo "Rama hotfix/$2 creada. Corrige el error crítico."
    ;;
    
  finish-hotfix)
    if [ -z "$2" ] || [ -z "$3" ]
    then
      echo "Debes especificar el nombre del hotfix y la nueva versión"
      echo "Ejemplo: ./gitflow.sh finish-hotfix correccion-login 1.0.1"
      exit 1
    fi
    
    echo "Finalizando hotfix/$2 con versión $3..."
    git checkout main
    git pull origin main
    git merge --no-ff hotfix/$2
    git tag -a v$3 -m "Versión $3"
    git push origin main --tags
    
    git checkout develop
    git pull origin develop
    git merge --no-ff hotfix/$2
    git push origin develop
    
    git branch -d hotfix/$2
    echo "Hotfix $2 finalizado y desplegado en main (v$3) y develop."
    ;;
    
  *)
    echo "GitFlow Helper para Cinemapedia"
    echo ""
    echo "Uso: ./gitflow.sh [comando] [argumentos]"
    echo ""
    echo "Comandos disponibles:"
    echo "  feature [nombre]         - Crea una nueva rama de característica"
    echo "  finish-feature [nombre]  - Finaliza una rama de característica"
    echo "  release [version]        - Crea una nueva rama de release"
    echo "  finish-release [version] - Finaliza una rama de release"
    echo "  hotfix [nombre]          - Crea una nueva rama de hotfix"
    echo "  finish-hotfix [nombre] [version] - Finaliza una rama de hotfix"
    echo ""
    echo "Ejemplos:"
    echo "  ./gitflow.sh feature pantalla-detalles"
    echo "  ./gitflow.sh release 1.0.0"
    ;;
esac
