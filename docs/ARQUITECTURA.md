# ARV — arquitectura propuesta

## Objetivo
ARV no es solo un calendario. Es un asistente jurídico móvil que conecta agenda, casos, clientes, recordatorios, Meet, Gmail, evidencias y acciones posteriores.

## Capas

### App móvil
Flutter para Android y iOS con una sola base de código.

### Datos
Supabase:
- Auth
- PostgreSQL
- Row Level Security
- Storage privado
- Realtime

### Notificaciones
1. Notificación local para recordatorios simples y funcionamiento offline.
2. Push remoto mediante FCM/APNs para avisos generados desde servidor.
3. Resumen nocturno configurable.
4. Resumen matutino configurable.
5. Avisos escalonados antes de audiencias y reuniones.

### Google
OAuth independiente y revocable:
- Google Calendar: leer/crear/actualizar eventos.
- Gmail: detectar correos seleccionados como relevantes.
- Meet: usar el enlace incluido en el evento de Calendar.
- Drive: adjuntar documentos si el usuario lo autoriza.

Nunca se guardará la contraseña de Google.

### IA / interpretación
La app recibe texto o voz y lo transforma en una propuesta estructurada antes de guardar.

Ejemplo:
“Recuérdame mañana a las nueve llamar al Dr. Pérez por el caso Rodríguez y el viernes revisar si presentó el escrito.”

Resultado:
- Acción 1: llamada, mañana 09:00.
- Acción 2: seguimiento, viernes.
- Caso sugerido: Rodríguez.
- Relación entre ambas acciones.

El usuario confirma antes de persistir.

## Offline
La app debe permitir ver agenda reciente, crear notas, tareas y evidencias sin internet. Cuando vuelve la conexión, sincroniza.

## Seguridad
- Face ID / huella.
- PIN alternativo.
- Tokens en almacenamiento seguro.
- RLS en todas las tablas.
- Archivos privados.
- Ocultar contenido sensible de notificaciones si el usuario lo activa.

## Fases
1. Base visual + agenda + recordatorios + voz.
2. Clientes + casos + evidencias + timeline.
3. Supabase + autenticación + sincronización.
4. Calendar + Gmail + Meet.
5. Asistente contextual y resúmenes inteligentes.
