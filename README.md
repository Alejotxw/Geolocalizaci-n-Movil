# 📍 App de Geolocalización e Interactividad

Este proyecto es una aplicación móvil desarrollada con **Flutter** que demuestra la integración de servicios de mapas y geolocalización en tiempo real utilizando la API de Google Maps.

## 🚀 Funcionalidades Demostradas

De acuerdo con los requerimientos de la tarea, la aplicación realiza las siguientes acciones:

1.  **Gestión de Permisos:** Al iniciar, la app verifica y solicita permisos de ubicación (`ACCESS_FINE_LOCATION`) de forma nativa.
2.  **Carga de API Key:** Integración correcta de Google Maps SDK mediante una clave de API configurada en el manifiesto de Android.
3.  **Localización en Tiempo Real:** Obtención de coordenadas (latitud y longitud) mediante el sensor GPS del dispositivo.
4.  **Interactividad y Animación:** * El mapa se centra automáticamente en el usuario con una animación fluida (`animateCamera`).
    * Se genera un marcador personalizado (`Marker`) en la posición exacta.
    * Soporte para gestos (mover el mapa, zoom).

## 🛠️ Tecnologías Utilizadas

* **Lenguaje:** Dart
* **Framework:** Flutter
* **Editor:** Visual Studio Code
* **Plugins:**
    * `Maps_flutter`: Para la visualización y control del mapa.
    * `location`: Para el manejo de permisos y adquisición de coordenadas.

## 📱 Configuración del Entorno

Para replicar este proyecto:

1.  Configurar la API Key en `android/app/src/main/AndroidManifest.xml`.
2.  Habilitar **Maps SDK for Android** en Google Cloud Console.
3.  Ejecutar `flutter pub get` para instalar las dependencias.
4.  Conectar un dispositivo físico (ej. Samsung SM-A325M) y ejecutar `flutter run`.

---
*Desarrollado como parte de la tarea de Geolocalización Móvil.*
