import 'package:alrm_app/controller/services/api_services.dart';
import 'package:alrm_app/models/alarm_model.dart';
import 'package:alrm_app/controller/providers/alarm_provider.dart';
import 'package:alrm_app/view/widgets/elevated_button_widget.dart';
import 'package:alrm_app/view/widgets/textfield_widget.dart';
import 'package:alrm_app/view/widgets/timepicker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddAlarmPage extends HookConsumerWidget {
  const AddAlarmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final pickedTime = useState<TimeOfDay?>(TimeOfDay.now());
    final isLoading = useState<bool>(false);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Set Alarm"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: ApiServices.getCurrentWeather(), //Fetch weather data
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final currentWeather =
                        snapshot.data; // Get the current weather data
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 60,
                        width: 120,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2,
                                  color: Colors.white.withOpacity(.50)),
                            ],
                            border:
                                Border.all(color: Colors.grey.withOpacity(.20)),
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            '🌦️$currentWeather ℃', // Display current weather
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              const Text(
                "Title",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextFieldWidget(controller: titleController, text: 'Add a Title'),
              const SizedBox(
                height: 20,
              ),
              TimePickerWidget(
                pickedTime: pickedTime,
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButtonWidget(
            child: isLoading.value
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : const Text('Save'),
            onpressed: () async {
              isLoading.value = true;
              await ref.read(alarmProvider.notifier).addAlarm(AlarmModel(
                    time: pickedTime.value!.format(context),
                    label: titleController.text,
                    isActive: true,
                  ));
              Future.sync(() => Navigator.pop(context));
            },
          ),
        ),
      ),
    );
  }
}
