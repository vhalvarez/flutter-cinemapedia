# GitFlow para Cinemapedia

Este proyecto utiliza GitFlow como metodología de trabajo para gestionar el ciclo de vida del desarrollo de software.

## Estructura de ramas

- **main**: Rama principal que contiene el código en producción.
- **develop**: Rama de desarrollo donde se integran todas las nuevas características.
- **feature/**: Ramas para el desarrollo de nuevas características (ej. `feature/movie-details`).
- **release/**: Ramas para preparar una nueva versión (ej. `release/1.0.0`).
- **hotfix/**: Ramas para corregir errores críticos en producción (ej. `hotfix/login-crash`).

## Flujo de trabajo

1. **Desarrollo de nuevas características**:
   - Crear una rama `feature/nombre-caracteristica` desde `develop`.
   - Desarrollo de la característica.
   - Pull Request a `develop` cuando la característica esté completa.

2. **Preparación de releases**:
   - Crear una rama `release/x.y.z` desde `develop`.
   - Corregir pequeños bugs y preparar metadatos.
   - Merge a `main` y `develop` cuando esté listo.

3. **Hotfixes para producción**:
   - Crear una rama `hotfix/descripcion` desde `main`.
   - Corregir el error.
   - Merge a `main` y `develop`.

## Comandos útiles

```bash
# Crear nueva característica
git checkout develop
git pull origin develop
git checkout -b feature/nombre-caracteristica

# Finalizar característica
git checkout develop
git merge --no-ff feature/nombre-caracteristica
git push origin develop
git branch -d feature/nombre-caracteristica

# Crear release
git checkout develop
git checkout -b release/x.y.z

# Finalizar release
git checkout main
git merge --no-ff release/x.y.z
git tag -a x.y.z
git push origin main --tags
git checkout develop
git merge --no-ff release/x.y.z
git push origin develop
git branch -d release/x.y.z

# Crear hotfix
git checkout main
git checkout -b hotfix/descripcion

# Finalizar hotfix
git checkout main
git merge --no-ff hotfix/descripcion
git tag -a x.y.z
git push origin main --tags
git checkout develop
git merge --no-ff hotfix/descripcion
git push origin develop
git branch -d hotfix/descripcion
```