import 'package:alrm_app/controller/providers/alarm_provider.dart';
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              StreamBuilder(
                  stream: ref.read(alarmProvider.notifier).getAlarm(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                        itemBuilder: (context, index) => Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  snapshot.data![index].time,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Switch(
                                value: snapshot.data![index].isActive,
                                onChanged: (value) {},
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text("No Alarms"),
                      );
                    }
                  })
            ],
          ),
        ));
  }
}
