import 'package:alrm_app/providers/alarm_provider.dart';
import 'package:alrm_app/view/add_alarm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.delayed(Duration.zero, () {
        ref.read(alarmProvider.notifier).getAlarm();
      });

      return null;
    }, []);

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Consumer(builder: (context, ref, _) {
                  final alarms = ref.watch(alarmProvider);

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: alarms.length,
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
                              alarms[index].time,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    ref
                                        .read(alarmProvider.notifier)
                                        .deleteAlarm(alarms[index].id);
                                  },
                                  icon: const Icon(Icons.delete)),
                              Switch(
                                value: alarms[index].isActive,
                                onChanged: (value) {
                                  ref
                                      .read(alarmProvider.notifier)
                                      .toggleAlarm(alarms[index]);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ));
  }
}
