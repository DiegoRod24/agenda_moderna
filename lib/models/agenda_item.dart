enum AgendaItemType { audiencia, reunion, tarea, llamada, vencimiento, evidencia }

class AgendaItem {
  final String id;
  final String title;
  final String? subtitle;
  final DateTime startAt;
  final DateTime? endAt;
  final AgendaItemType type;
  final String? caseName;
  final String? meetUrl;
  final bool completed;
  final bool urgent;

  const AgendaItem({
    required this.id,
    required this.title,
    this.subtitle,
    required this.startAt,
    this.endAt,
    required this.type,
    this.caseName,
    this.meetUrl,
    this.completed = false,
    this.urgent = false,
  });
}
