import 'package:objectbox/objectbox.dart';

@Entity()
class AlarmEntity {
  @Id()
  int id = 0;

  final DateTime time;
  final String label;
  final bool isActive;

  AlarmEntity(
      {required this.time, required this.label, required this.isActive});
}
