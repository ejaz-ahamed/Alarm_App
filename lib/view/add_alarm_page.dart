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
              const TimePickerWidget()
            ],
          ),
        ),
      ),
    );
  }
}
