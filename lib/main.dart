import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/theme/arv_theme.dart';
import 'screens/login_screen.dart';
import 'services/firebase_bootstrap_service.dart';
import 'services/local_database_service.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('es_PE');
  await LocalDatabaseService.instance.init();
  await NotificationService.instance.init();

  final firebaseReady = await FirebaseBootstrapService.instance.initialize();

  runApp(ArvApp(firebaseReady: firebaseReady));
}

class ArvApp extends StatelessWidget {
  final bool firebaseReady;

  const ArvApp({super.key, required this.firebaseReady});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ARV',
      theme: buildArvTheme(),
      locale: const Locale('es', 'PE'),
      supportedLocales: const [
        Locale('es', 'PE'),
        Locale('es'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: LoginScreen(firebaseReady: firebaseReady),
    );
  }
}
