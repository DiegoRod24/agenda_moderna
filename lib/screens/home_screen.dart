import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/theme/arv_theme.dart';
import '../data/demo_data.dart';
import '../models/agenda_item.dart';
import '../services/notification_service.dart';
import '../services/voice_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _voice = VoiceService();
  final _textController = TextEditingController();
  bool _listening = false;

  IconData _iconFor(AgendaItemType type) {
    return switch (type) {
      AgendaItemType.audiencia => Icons.gavel_rounded,
      AgendaItemType.reunion => Icons.groups_2_rounded,
      AgendaItemType.tarea => Icons.task_alt_rounded,
      AgendaItemType.llamada => Icons.call_rounded,
      AgendaItemType.vencimiento => Icons.warning_amber_rounded,
      AgendaItemType.evidencia => Icons.photo_camera_rounded,
    };
  }

  Future<void> _toggleVoice() async {
    if (_listening) {
      await _voice.stop();
      setState(() => _listening = false);
      return;
    }

    setState(() => _listening = true);
    await _voice.listen(
      onText: (text) {
        setState(() {
          _textController.text = text;
          _textController.selection = TextSelection.collapsed(offset: text.length);
        });
      },
    );
  }

  void _showQuickCreate() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: ArvColors.navySoft,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('¿Qué desea registrar?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _QuickAction(icon: Icons.mic_rounded, label: 'Dictar', onTap: _toggleVoice),
                  _QuickAction(icon: Icons.event_rounded, label: 'Cita', onTap: () {}),
                  _QuickAction(icon: Icons.task_alt_rounded, label: 'Tarea', onTap: () {}),
                  _QuickAction(icon: Icons.gavel_rounded, label: 'Caso', onTap: () {}),
                  _QuickAction(icon: Icons.photo_camera_rounded, label: 'Evidencia', onTap: () {}),
                  _QuickAction(icon: Icons.note_alt_rounded, label: 'Nota', onTap: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = demoAgendaForToday();
    final date = DateFormat("EEEE d 'de' MMMM", 'es').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ARV', style: TextStyle(color: ArvColors.gold, fontWeight: FontWeight.w800)),
            Text('Asistente Jurídico Personal', style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Probar aviso',
            onPressed: NotificationService.instance.showTestReminder,
            icon: const Icon(Icons.notifications_active_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showQuickCreate,
        backgroundColor: ArvColors.gold,
        foregroundColor: ArvColors.navy,
        child: const Icon(Icons.add_rounded, size: 30),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 110),
          children: [
            Text(
              'Buenos días, Dr. Diego Rodríguez',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(date.toUpperCase(), style: const TextStyle(color: ArvColors.goldSoft, letterSpacing: 1.2)),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.auto_awesome_rounded, color: ArvColors.gold),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text('Doctor, hoy tiene 3 compromisos. La audiencia de las 10:00 requiere atención.',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _textController,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Escriba o dígame: “Recuérdame mañana llamar al Dr. Pérez…”',
                        suffixIcon: IconButton(
                          onPressed: _toggleVoice,
                          icon: Icon(
                            _listening ? Icons.mic_rounded : Icons.mic_none_rounded,
                            color: _listening ? ArvColors.danger : ArvColors.gold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.auto_awesome),
                      label: const Text('Interpretar y agendar'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            const Row(
              children: [
                Expanded(child: _StatCard(label: 'Urgente', value: '1', icon: Icons.priority_high_rounded, color: ArvColors.danger)),
                SizedBox(width: 10),
                Expanded(child: _StatCard(label: 'Pendientes', value: '3', icon: Icons.pending_actions_rounded, color: ArvColors.warning)),
                SizedBox(width: 10),
                Expanded(child: _StatCard(label: 'Correos', value: '2', icon: Icons.mark_email_unread_rounded, color: ArvColors.gold)),
              ],
            ),
            const SizedBox(height: 24),
            Text('Mi día', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(22),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: item.urgent ? ArvColors.danger.withValues(alpha: .15) : ArvColors.gold.withValues(alpha: .12),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(_iconFor(item.type), color: item.urgent ? ArvColors.danger : ArvColors.gold),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateFormat('HH:mm').format(item.startAt),
                                  style: const TextStyle(color: ArvColors.goldSoft, fontWeight: FontWeight.w700)),
                              Text(item.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                              if (item.caseName != null) Text(item.caseName!, style: TextStyle(color: Colors.white.withValues(alpha: .7))),
                              if (item.subtitle != null) ...[
                                const SizedBox(height: 4),
                                Text(item.subtitle!, maxLines: 2, overflow: TextOverflow.ellipsis),
                              ],
                            ],
                          ),
                        ),
                        if (item.meetUrl != null)
                          IconButton.filledTonal(
                            tooltip: 'Abrir Meet',
                            onPressed: () async {
                              final uri = Uri.parse(item.meetUrl!);
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            },
                            icon: const Icon(Icons.videocam_rounded),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
            const SizedBox(height: 8),
            FilledButton.tonalIcon(
              onPressed: () {},
              icon: const Icon(Icons.bedtime_outlined),
              label: const Text('Vista previa del resumen nocturno'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Hoy'),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), label: 'Agenda'),
          NavigationDestination(icon: Icon(Icons.gavel_outlined), label: 'Casos'),
          NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), label: 'ARV'),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 6),
              Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
              Text(label, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      );
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 98,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: ArvColors.gold.withValues(alpha: .12),
                  child: Icon(icon, color: ArvColors.gold),
                ),
                const SizedBox(height: 7),
                Text(label),
              ],
            ),
          ),
        ),
      );
}
