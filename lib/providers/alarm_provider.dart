import 'package:alrm_app/models/alarm_entity.dart';
import 'package:alrm_app/models/alarm_model.dart';
import 'package:alrm_app/object_box/object_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/timezone.dart' as tz;

part 'alarm_provider.g.dart';

@riverpod
class Alarm extends _$Alarm {
  final box = ObjectBox.instance.alarmBox;
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Alarm() {
    initializeFlutterLocalNotificationsPlugin();
  }

  void initializeFlutterLocalNotificationsPlugin() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  List<AlarmModel> build() {
    final alarmsEntity = box.getAll();
    final List<AlarmModel> alarmModel = alarmsEntity
        .map(
          (e) => AlarmModel(time: e.time, label: e.label, isActive: e.isActive),
        )
        .toList();
    return alarmModel;
  }

  Future<void> addAlarm(AlarmModel alarm, String text) async {
    final alarmEntity = AlarmEntity(
        time: alarm.time.toString(),
        label: alarm.label,
        isActive: alarm.isActive);
    box.put(alarmEntity);

    final time = DateFormat.jm();
    TimeOfDay selectedTime = TimeOfDay.fromDateTime(time.parse(alarmEntity.time));

    getAlarm();
    await scheduleAlarm(text, selectedTime);
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

  Future<void> scheduleAlarm(String text, TimeOfDay time) async {
    final now = DateTime.now();
    final selectedTime = time;
    final scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'alarm_channel',
      'Alarm Notification',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      5,
      'Alarm',
      text,
      scheduledTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
