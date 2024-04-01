class AlarmModel {
  final int id;
  final String time;
  final String label;
  bool isActive;

  AlarmModel({
    this.id = 0,
    required this.time,
    required this.label,
    required this.isActive,
  });
}
