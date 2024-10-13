import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/main.dart';

class MyChecBox extends StatelessWidget {
  final bool isChecked;
  const MyChecBox({super.key, required this.isChecked});

  @override

  /// A widget that displays a checkmark in a circle if [isChecked] is true
  /// and a hollow circle if [isChecked] is false.
  ///
  /// The circle is 24x24 and the checkmark is 16x16. The color of the circle
  /// and the checkmark is [primaryColor].
  ///
  /// The [isChecked] parameter is required.
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
