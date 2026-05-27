# Changelle - Movies App 🎬

Una aplicación iOS nativa desarrollada en **Swift** y **SwiftUI** que permite explorar películas en tendencia y gestionar una lista de favoritos local. El proyecto está diseñado bajo un enfoque modular, implementando principios **SOLID**, una arquitectura limpia orientada a componentes y persistencia avanzada con **Core Data**.

---

## 📺 Demostración en Vivo

¡Mira la aplicación en acción! Puedes ver el flujo de la app, el renderizado de la lista, las animaciones Lottie y la persistencia en tiempo real al marcar favoritos en el siguiente video de demostración:

<video src="https://github.com/user-attachments/assets/4f023fd3-7f33-4e92-a9be-52b3c1fcd8ec" width="100%" controls></video>













---

## ✨ Características

* 💾 **Persistencia con Core Data:** Gestión avanzada de películas favoritas guardadas localmente para acceso *Offline*.
* 🎨 **Arquitectura por Estrategias:** Uso de *Strategy Pattern* para intercambiar de forma dinámica el origen de los datos (Servicio Web vs Base de Datos local).
* 🧱 **UI Kit Interno:** Capa de componentes de interfaz altamente reutilizables, parametrizables y limpios.
* 🌪️ **Animaciones Fluida:** Integración de estados de carga dinámicos y atractivos con animaciones vectoriales Lottie.
* 🛠️ **Desacoplamiento de Navegación:** Implementación del patrón *Router* para manejar los flujos de pantallas sin acoplar las vistas.

---

## 🛠️ Tecnologías Utilizadas

<h4>Core Technologies</h4>
<span>
  <img src="https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=swift&logoColor=white" title="Swift">
  <img src="https://img.shields.io/badge/SwiftUI-1572B6?style=for-the-badge&logo=swift&logoColor=61DAFB" title="SwiftUI">
  <img src="https://img.shields.io/badge/Combine-412991?style=for-the-badge&logo=ios&logoColor=white" title="Combine Reactive">
  <img src="https://img.shields.io/badge/Core_Data-20232A?style=for-the-badge&logo=icloud&logoColor=white" title="Core Data">
  <img src="https://img.shields.io/badge/Alamofire-FF5733?style=for-the-badge&logo=swift&logoColor=white" title="Alamofire">
</span>

<h4>Other Tools and Technologies</h4>
<span>
  <img src="https://img.shields.io/badge/Xcode-147EFB?style=for-the-badge&logo=xcode&logoColor=white" title="Xcode">
  <img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white" title="Git">
  <img src="https://img.shields.io/badge/Lottie-000000?style=for-the-badge&logo=adobeanimiate&logoColor=F9F9F9" title="Lottie Animations">
  <img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" title="Linux">
  <img src="https://img.shields.io/badge/Mac_OS-000000?style=for-the-badge&logo=apple&logoColor=white" title="macOS">
</span>

---

## 📐 Arquitectura y Principios SOLID

El proyecto se rige bajo estrictas buenas prácticas de desarrollo móvil, enfocadas en el desacoplamiento, la mantenibilidad y la facilidad de pruebas:

* **Single Responsibility Principle (SRP):** Los servicios de red (`MovieService`), la lógica de almacenamiento (`CoreDataFavoriteStorage`) y las vistas están completamente aislados.
* **Open/Closed Principle (OCP):** El uso de protocolos (`MovieLocalStorageProtocol`) permite añadir nuevas fuentes de datos o filtros sin modificar el código existente en los ViewModels.
* **Interface Segregation Principle (ISP):** Definición de protocolos específicos para que los componentes solo dependan de los métodos que realmente necesitan consumir.
* **Dependency Inversion Principle (DIP):** Los ViewModels e Interactors dependen de abstracciones, facilitando la inyección de dependencias.

---

## 💾 Configuración de Core Data

Para este proyecto se implementó un mapeo **Manual/None (Codegen)** de la entidad de Core Data (`Favorite`), enlazado directamente a una estructura Swift optimizada de forma nativa (`CDMovie.swift`), asegurando un control absoluto sobre los atributos del modelo relacional:

* **Entidad:** `Favorite`
* **Clave Primaria:** `idMovie` (Manejado como `String` para compatibilidad directa con estructuras de red).
* **Propiedades Persistidas:** `title`, `img` (Ruta de póster), y `releaseDate`.

---

## 💻 Instalación y Ejecución Local

### Prerrequisitos
Asegúrate de tener instalado Xcode en tu equipo macOS:
```bash
# Verificar que las herramientas de Xcode estén activas
xcode-select -p
