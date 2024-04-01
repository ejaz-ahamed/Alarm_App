import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TimePickerWidget extends HookWidget {
  final ValueNotifier<TimeOfDay?> pickedTime;
  const TimePickerWidget({
    super.key,
    required this.pickedTime,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              final selectedTime = await showTimePicker(
                context: context,
                initialTime: pickedTime.value ?? TimeOfDay.now(),
              );
              if (selectedTime != null) {
                pickedTime.value = selectedTime;
              }
            },
            child: Center(
              child: Text(
                pickedTime.value!.format(context),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
