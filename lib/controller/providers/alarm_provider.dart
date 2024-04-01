import 'package:alrm_app/models/alarm_entity.dart';
import 'package:alrm_app/models/alarm_model.dart';
import 'package:alrm_app/object_box/object_box.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alarm_provider.g.dart';

@riverpod
class Alarm extends _$Alarm {
  final box = ObjectBox.instance.alarmBox;

  @override
  List<AlarmEntity> build() {
    return [];
  }

  Future<void> addAlarm(AlarmModel alarm) async {
    final alarmEntity = AlarmEntity(
        time: alarm.time.toString(), label: alarm.label, isActive: alarm.isActive);
    box.put(alarmEntity);
  }

  Stream<List<AlarmModel>> getAlarm() async* {
    final alarms = box.getAll();
    final data = [
      for (var alarm in alarms)
        AlarmModel(
            time: alarm.time, label: alarm.label, isActive: alarm.isActive)
    ];
    yield data;
  }
}
