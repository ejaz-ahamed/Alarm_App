import 'package:alrm_app/object_box/object_box.dart';
import 'package:alrm_app/view/home_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ObjectBox.create();
  await AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    null,
    [
      NotificationChannel(
        channelGroupKey: 'test_alarm_group',
        channelKey: 'test_alarm',
        channelName: 'Alarm',
        channelDescription: 'Notification channel for basic alarm tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
      )
    ],
    debug: true,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alarm Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
