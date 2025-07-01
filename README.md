# 🌍 Sistema de Turismo Flutter

Una aplicación móvil completa para gestión de lugares turísticos desarrollada en Flutter con Supabase como backend.

## 📱 Descripción

Sistema de turismo que permite a los usuarios registrarse con diferentes roles (Visitante/Publicador) para visualizar y gestionar lugares turísticos. Los publicadores pueden agregar nuevos lugares con imágenes, ubicación GPS y descripciones, mientras que los visitantes pueden explorar estos lugares y ver comentarios.

## ✨ Características Principales

### 🔐 Autenticación y Roles
- **Registro e inicio de sesión** con email y contraseña
- **Sistema de roles**: Visitante y Publicador
- **Validación de campos** y manejo de errores
- **Cerrar sesión** disponible en ambas vistas

### 👥 Funcionalidades por Rol

#### 📝 Publicador
- ✅ Agregar lugares turísticos con información completa
- ✅ Subir y redimensionar imágenes automáticamente (1080x1350px)
- ✅ Obtener ubicación GPS automática
- ✅ Generar enlaces de Google Maps
- ✅ Agregar comentarios a lugares
- ✅ Visualizar todos los lugares publicados

#### 👀 Visitante
- ✅ Explorar lugares turísticos disponibles
- ✅ Ver información detallada de cada lugar
- ✅ Visualizar comentarios (solo lectura)
- ✅ Abrir ubicaciones en Google Maps
- ❌ No puede agregar lugares ni comentarios

### 🗺️ Funcionalidades de Ubicación
- **GPS automático** para obtener coordenadas precisas
- **Integración con Google Maps** para visualizar ubicaciones
- **Enlaces directos** que abren Google Maps o navegador
- **Permisos de ubicación** configurados automáticamente

### 📸 Gestión de Imágenes
- **Captura desde cámara** o selección desde galería
- **Redimensionamiento automático** a 1080x1350 píxeles
- **Subida optimizada** a Supabase Storage
- **Vista previa** antes de guardar

### 💬 Sistema de Comentarios
- **Comentarios por lugar** turístico
- **Identificación por email** del usuario
- **Fecha y hora** de creación
- **Restricción por rol** (solo publicadores pueden comentar)

## 🛠️ Tecnologías Utilizadas

### Frontend
- **Flutter 3.32.3** - Framework de desarrollo móvil
- **Dart 3.8.1** - Lenguaje de programación

### Backend y Servicios
- **Supabase** - Backend as a Service (autenticación, base de datos, storage)
- **Supabase Auth** - Sistema de autenticación
- **Supabase Storage** - Almacenamiento de imágenes
- **PostgreSQL** - Base de datos relacional

### Dependencias Principales
```yaml
dependencies:
  flutter: sdk
  supabase_flutter: ^2.8.0
  image_picker: ^1.1.2
  image: ^4.2.0
  geolocator: ^13.0.4
  url_launcher: ^6.3.0
  permission_handler: ^11.4.0
  file_picker: ^8.3.7
```

## 🗄️ Estructura de Base de Datos

### Tabla: `lugares`
```sql
CREATE TABLE lugares (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL,
  ubicacion TEXT NOT NULL,
  resena TEXT,
  descripcion TEXT,
  url_imagen TEXT,
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  created_at TIMESTAMP DEFAULT NOW()
);
```

### Tabla: `comentarios`
```sql
CREATE TABLE comentarios (
  id SERIAL PRIMARY KEY,
  lugar_id NUMERIC NOT NULL,
  usuario_email VARCHAR NOT NULL,
  comentario TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY (lugar_id) REFERENCES lugares(id)
);
```

## 🚀 Instalación y Configuración

### Prerrequisitos
- Flutter SDK 3.32.3 o superior
- Android Studio con Android SDK 35
- Cuenta en Supabase
- Dispositivo Android o emulador

### 1. Clonar el Repositorio
```bash
git clone <url-del-repositorio>
cd taller_repaso
```

### 2. Instalar Dependencias
```bash
flutter pub get
```

### 3. Configurar Supabase
1. Crear proyecto en [Supabase](https://supabase.com)
2. Configurar las tablas de base de datos
3. Configurar el Storage bucket llamado `uploads`
4. Actualizar las credenciales en `lib/main.dart`:

```dart
await Supabase.initialize(
  url: 'TU_SUPABASE_URL',
  anonKey: 'TU_SUPABASE_ANON_KEY',
);
```

### 4. Configurar Permisos Android
Los permisos ya están configurados en `android/app/src/main/AndroidManifest.xml`:
- Internet y red
- Ubicación GPS (precisa y aproximada)
- Cámara
- Archivos y galería

### 5. Compilar la Aplicación

#### Modo Debug
```bash
flutter build apk --debug
```

#### Modo Release
```bash
flutter build apk --release
```

### 6. Instalar en Dispositivo
```bash
flutter install
```

## 📋 Estructura del Proyecto

```
lib/
├── main.dart              # Punto de entrada y configuración
├── login_page.dart        # Pantalla de login y registro
└── turismo_page.dart      # Pantalla principal del sistema

android/
├── app/
│   ├── src/main/
│   │   └── AndroidManifest.xml  # Permisos y configuración
│   └── build.gradle.kts         # Configuración de compilación
└── key.properties              # Configuración de firma

assets/
└── (archivos de recursos si los hay)
```

## 🔧 Configuración Avanzada

### Permisos Android Configurados
```xml
<!-- Internet y red -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!-- Ubicación GPS -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

<!-- Cámara y archivos -->
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
```

### Configuración de Compilación
- **compileSdk**: 35
- **targetSdk**: 35
- **minSdk**: 21
- **Java**: Version 11
- **NDK**: 26.3.11579264

## 🎯 Funcionalidades Implementadas

### ✅ Autenticación
- [x] Registro de usuarios con roles
- [x] Inicio de sesión con validación
- [x] Cerrar sesión desde cualquier vista
- [x] Navegación basada en roles

### ✅ Gestión de Lugares
- [x] Agregar lugares con formulario completo
- [x] Validación de campos obligatorios
- [x] Subida de imágenes optimizada
- [x] Obtención automática de GPS
- [x] Generación de enlaces Google Maps

### ✅ Visualización
- [x] Cards atractivas para lugares
- [x] Imágenes con fallback de error
- [x] Información organizada y clara
- [x] Botones de acción intuitivos

### ✅ Comentarios
- [x] Sistema de comentarios por lugar
- [x] Restricción por rol de usuario
- [x] Identificación por email
- [x] Fechas de creación

### ✅ Integración Maps
- [x] Botón "Ver en Maps" funcional
- [x] Apertura en aplicación externa
- [x] Fallback a navegador web

## 🚧 Mejoras Futuras

### Funcionalidades Adicionales
- [ ] Sistema de favoritos para visitantes
- [ ] Calificaciones con estrellas
- [ ] Filtros por categoría o ubicación
- [ ] Búsqueda por nombre o descripción
- [ ] Notificaciones push
- [ ] Modo offline básico

### Mejoras Técnicas
- [ ] Estado global con Provider/Riverpod
- [ ] Cache de imágenes
- [ ] Paginación para lugares
- [ ] Tests unitarios y de integración
- [ ] CI/CD pipeline

### UI/UX
- [ ] Tema oscuro
- [ ] Animaciones de transición
- [ ] Indicadores de carga mejorados
- [ ] Onboarding para nuevos usuarios

## 🔒 Seguridad

### Implementado
- ✅ Autenticación con Supabase Auth
- ✅ Validación de roles en frontend
- ✅ Row Level Security (RLS) en Supabase
- ✅ Validación de entrada de datos

### Recomendaciones
- Implementar RLS policies en todas las tablas
- Validación de roles en backend
- Sanitización de inputs
- Rate limiting para uploads

## 🐛 Solución de Problemas

### Problemas Comunes

#### Error de permisos de ubicación
```bash
# Verificar permisos en AndroidManifest.xml
# Solicitar permisos manualmente en el dispositivo
```

#### Error de compilación NDK
```bash
# Limpiar el proyecto
flutter clean
flutter pub get
```

#### Error de Supabase conexión
```bash
# Verificar URL y API key
# Comprobar conectividad a internet
```

### Logs y Debug
```bash
# Ver logs en tiempo real
flutter logs

# Debug en dispositivo
flutter run --debug
```

## 📱 APK Disponibles

### Archivos Generados
- **Debug**: `build/app/outputs/flutter-apk/app-debug.apk`
- **Release**: `build/app/outputs/flutter-apk/app-release.apk`

### Instalación Manual
```bash
# Instalar APK debug
adb install build/app/outputs/flutter-apk/app-debug.apk

# Instalar APK release
adb install build/app/outputs/flutter-apk/app-release.apk
```

## 👥 Contribución

### Proceso de Contribución
1. Fork del proyecto
2. Crear rama de feature (`git checkout -b feature/nueva-caracteristica`)
3. Commit de cambios (`git commit -m 'Agregar nueva característica'`)
4. Push a la rama (`git push origin feature/nueva-caracteristica`)
5. Crear Pull Request

### Estándares de Código
- Seguir las convenciones de Dart/Flutter
- Documentar funciones públicas
- Mantener archivos organizados
- Incluir tests para nuevas funcionalidades

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 🎉 Agradecimientos

- Flutter team por el excelente framework
- Supabase por el backend simplificado
- Comunidad open source por las librerías utilizadas

---

**Desarrollado con ❤️ usando Flutter y Supabase**

> Este sistema de turismo demuestra las capacidades de Flutter para crear aplicaciones móviles completas con backend en la nube, gestión de roles, ubicación GPS y multimedia.
