import '../models/agenda_item.dart';

List<AgendaItem> demoAgendaForToday() {
  final now = DateTime.now();
  DateTime at(int hour, int minute) =>
      DateTime(now.year, now.month, now.day, hour, minute);

  return [
    AgendaItem(
      id: '1',
      title: 'Llamar al Dr. Pérez',
      subtitle: 'Confirmar documentación pendiente',
      startAt: at(8, 30),
      type: AgendaItemType.llamada,
      caseName: 'Rodríguez vs. Municipalidad',
    ),
    AgendaItem(
      id: '2',
      title: 'Audiencia virtual',
      subtitle: 'Revisar contestación antes de ingresar',
      startAt: at(10, 0),
      type: AgendaItemType.audiencia,
      caseName: 'Caso Ramírez',
      meetUrl: 'https://meet.google.com/',
      urgent: true,
    ),
    AgendaItem(
      id: '3',
      title: 'Reunión con cliente',
      subtitle: 'Definir próximos pasos',
      startAt: at(15, 0),
      type: AgendaItemType.reunion,
      caseName: 'Ana Torres',
    ),
  ];
}
