import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ElevatedButtonWidget extends ConsumerWidget {
  final VoidCallback onpressed;
  final String text;
  const ElevatedButtonWidget({
    super.key,
    required this.onpressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      child: Text(text),
    );
  }
}
