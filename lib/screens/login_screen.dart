import 'package:flutter/material.dart';

import '../core/theme/arv_theme.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool firebaseReady;

  const LoginScreen({super.key, required this.firebaseReady});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();
  bool _loading = false;
  String? _error;

  Future<void> _loginGoogle() async {
    if (!widget.firebaseReady) {
      setState(() {
        _error = 'Firebase todavía no está configurado en este dispositivo. Puede entrar en modo local.';
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await _auth.signInWithGoogle();
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _localMode() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                children: [
                  Container(
                    width: 132,
                    height: 132,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [ArvColors.goldSoft, ArvColors.gold],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ArvColors.gold.withValues(alpha: .18),
                          blurRadius: 35,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: ArvColors.navy,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'ARV',
                          style: TextStyle(
                            color: ArvColors.gold,
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  const Text(
                    'ARV',
                    style: TextStyle(
                      color: ArvColors.gold,
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Asistente Jurídico Personal',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Diego Alfredo Rodríguez Villalobos',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white.withValues(alpha: .68)),
                  ),
                  const SizedBox(height: 34),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.gavel_rounded,
                            size: 32,
                            color: ArvColors.gold,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Su agenda, casos y recordatorios en un solo lugar.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.firebaseReady
                                ? 'Nube disponible · puede sincronizar sus datos.'
                                : 'Modo local disponible · Firebase pendiente de configuración.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: widget.firebaseReady
                                  ? ArvColors.success
                                  : ArvColors.warning,
                            ),
                          ),
                          const SizedBox(height: 22),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: _loading ? null : _loginGoogle,
                              icon: const Icon(Icons.account_circle_outlined),
                              label: Text(
                                _loading
                                    ? 'Ingresando...'
                                    : 'Continuar con Google',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: _localMode,
                              icon: const Icon(Icons.phone_android_rounded),
                              label: const Text('Usar solo en este teléfono'),
                            ),
                          ),
                          if (_error != null) ...[
                            const SizedBox(height: 14),
                            Text(
                              _error!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: ArvColors.warning),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Protección biométrica y sincronización se activarán en el siguiente bloque.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: .5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
