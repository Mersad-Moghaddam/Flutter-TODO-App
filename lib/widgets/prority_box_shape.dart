import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProrityBoxShape extends StatelessWidget {
  final bool isChecked;
  final Color color;
  const ProrityBoxShape(
      {super.key, required this.isChecked, required this.color});

  @override

  /// A widget that displays a checkmark in a circle if [isChecked] is true
  /// and a hollow circle if [isChecked] is false.
  ///
  /// The circle is 16x16 and the checkmark is 10x10. The color of the circle
  /// and the checkmark is [color].
  ///
  /// The [isChecked] parameter is required.
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
      child: isChecked
          ? const Icon(
              CupertinoIcons.checkmark,
              size: 10,
              color: Colors.white,
            )
          : null,
    );
  }
}
