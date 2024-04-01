import 'package:alrm_app/view/add_alarm_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alarms"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddAlarmPage(),
                    ));
              },
              icon: const Icon(
                Icons.add,
                size: 35,
              ))
        ],
      ),
    );
  }
}
