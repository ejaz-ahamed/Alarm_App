import 'package:alrm_app/models/alarm_entity.dart';
import 'package:alrm_app/models/alarm_model.dart';
import 'package:alrm_app/object_box/object_box.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alarm_provider.g.dart';

@riverpod
class Alarm extends _$Alarm {
  final box = ObjectBox.instance.alarmBox;

  @override
  List<AlarmModel> build() {
    return [];
  }

  void addAlarm(AlarmModel alarm) {
    final alarmEntity = AlarmEntity(
        time: alarm.time.toString(),
        label: alarm.label,
        isActive: alarm.isActive);
    box.put(alarmEntity);

    getAlarm();
  }

  void toggleAlarm(AlarmModel alarm) async {
    box.put(
      AlarmEntity(
          id: alarm.id,
          time: alarm.time,
          label: alarm.label,
          isActive: !alarm.isActive),
    );

    getAlarm();
  }

  void getAlarm() {
    final alarms = box.getAll();
    final data = [
      for (var alarm in alarms)
        AlarmModel(
            id: alarm.id,
            time: alarm.time,
            label: alarm.label,
            isActive: alarm.isActive)
    ];
    state = data;
  }

  void deleteAlarm(int id) {
    box.remove(id);
    getAlarm();
  }
}
