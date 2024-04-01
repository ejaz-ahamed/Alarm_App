import 'package:alrm_app/providers/alarm_provider.dart';
import 'package:alrm_app/view/add_alarm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        body: Column(
          children: [
            FutureBuilder(
                future: ref.read(alarmProvider.notifier).getAlarm(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => Row(
                        children: [Text(snapshot.data![index].time)],
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("No Alarms"),
                    );
                  }
                })
          ],
        ));
  }
}
