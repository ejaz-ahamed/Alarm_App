import 'package:objectbox/objectbox.dart';

@Entity()
class AlarmEntity {
  @Id()
  int id = 0;

  String time;
  String label;
  bool isActive;

  AlarmEntity(
      {required this.time,
      required this.label,
      required this.isActive,
      this.id = 0});

  // @override
  // bool operator ==(Object other) {
  //   return hashCode == other.hashCode;
  // }

  // @override
  // int get hashCode =>
  //     time.hashCode + label.hashCode + isActive.hashCode + id.hashCode;
}
