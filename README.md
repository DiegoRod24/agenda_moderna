# ⚖️ ARV — Agenda Jurídica Inteligente

Aplicación móvil para Android y iPhone pensada como asistente jurídico personal.

**Perfil piloto:** Diego Alfredo Rodríguez Villalobos
**Identidad visual:** azul marino + dorado, basada en el sello ARV.

## Arquitectura actual

ARV usa una estrategia **local-first**:

- SQLite en el teléfono como base de trabajo inmediata.
- Firebase para autenticación, sincronización y push.
- Google Calendar / Gmail / Meet por OAuth.
- Si Firebase todavía no está configurado, la app puede abrir en **modo local**.

## Qué ya contiene

- Pantalla móvil “Hoy”.
- Login ARV preparado para Google/Firebase.
- Modo local sin nube.
- Base SQLite inicial.
- Resumen del día.
- Agenda demo.
- Captura por voz.
- Acceso a Meet.
- Notificación local de prueba.
- Tema azul marino + dorado.

## Primer arranque

1. Clonar el repositorio.
2. Ejecutar `flutter create . --platforms=android,ios` si las carpetas nativas aún no existen.
3. Ejecutar `flutter pub get`.
4. Ejecutar `flutter run`.

## Configurar Firebase

En tu PC instala FlutterFire CLI:

`dart pub global activate flutterfire_cli`

Después, dentro de la carpeta del proyecto:

`flutterfire configure`

Selecciona tu proyecto Firebase y marca Android e iOS.

## Firebase Console

Activa:

1. Authentication → Google.
2. Firestore Database.
3. Cloud Messaging.
4. Storage solo si decidimos usarlo para archivos pequeños.

## Flujo

Usuario → ARV Flutter → SQLite local → cola de sincronización → Firebase.

Sin Internet se podrá seguir usando agenda, notas, tareas y recordatorios locales. Cuando vuelve Internet, ARV sincroniza.

## Próximo bloque

- CRUD local real de citas.
- Navegación Hoy / Agenda / Casos / ARV.
- Sincronización Firestore.
- Recordatorios múltiples.
- Resumen matutino/nocturno.
- Biometría.
- Google Calendar / Gmail / Meet.
- Evidencias foto/video/documentos.
- Timeline de casos.