# ARV — Arquitectura móvil

## Principio

ARV debe seguir funcionando aunque no haya Internet o Firebase no responda.

## Dispositivo

Flutter:
- SQLite: fuente local de experiencia.
- Notificaciones locales: avisos programados.
- Voz: creación rápida de acciones.
- Biometría: desbloqueo.
- Cámara/archivos: evidencias.

## Nube

Firebase:
- Authentication: identidad.
- Firestore: sincronización estructurada.
- Cloud Messaging: avisos remotos.
- Storage: opcional y limitado a archivos pequeños.

## Google

- Calendar: citas, reuniones y Meet.
- Gmail: detección de correos relevantes autorizados.
- Drive: opción preferida para documentos y archivos grandes.

## Estructura Firestore

/users/{uid}
/users/{uid}/agenda/{id}
/users/{uid}/cases/{id}
/users/{uid}/clients/{id}
/users/{uid}/evidence/{id}
/users/{uid}/settings/{id}

Nunca se mezclan documentos de dos usuarios.

## Sincronización

Cada registro local mantiene:
- id estable;
- updated_at;
- synced;
- origen.

Los cambios se guardan primero en SQLite. Luego se empujan a Firestore cuando hay conexión.

## Recordatorios

Los avisos críticos conocidos deben programarse en el dispositivo para no depender de la nube.

Ejemplo audiencia 10:00:
- 21:30 del día anterior.
- 07:00 del mismo día.
- 09:30.
- 09:50.
- 09:55 con acceso a Meet.

FCM queda para eventos nacidos en servidor o cambios externos.
