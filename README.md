# Cinemapedia Flutter

Aplicación de películas desarrollada con Flutter.

## Configuración inicial

1. Copiar el .env.template y renombrarlo a .env
2. Cambiar las variables de entorno (The MovieDB)
3. Cambios en la entidad, hay que ejecutar el comando
```
flutter pub run build_runner build
```

## Flujo de trabajo con GitFlow

Este proyecto utiliza GitFlow como metodología de gestión del ciclo de vida del desarrollo. Para más información, consulta el archivo [GITFLOW.md](GITFLOW.md).

### Estructura de ramas

- **main**: Código en producción
- **develop**: Rama de desarrollo e integración
- **feature/**: Nuevas características
- **release/**: Preparación de versiones
- **hotfix/**: Correcciones urgentes en producción