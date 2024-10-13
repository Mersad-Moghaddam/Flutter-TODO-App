import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/main.dart';

class MyChecBox extends StatelessWidget {
  final bool isChecked;
  const MyChecBox({super.key, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isChecked ? primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: isChecked ? primaryColor : Colors.grey,
          width: 2,
        ),
      ),
      child: isChecked
          ? const Icon(
              CupertinoIcons.checkmark,
              size: 16,
              color: Colors.white,
            )
          : null,
    );
  }
}
