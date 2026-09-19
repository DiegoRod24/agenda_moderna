import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();
  static final instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );
  }

  Future<void> showTestReminder() async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'arv_agenda',
        'Agenda ARV',
        channelDescription: 'Recordatorios jurídicos importantes',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
      ),
    );

    await _plugin.show(
      1001,
      '⚖️ ARV · Buenos días, Doctor',
      'No olvide revisar su agenda. Tiene compromisos importantes hoy.',
      details,
    );
  }
}
