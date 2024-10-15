import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProrityBoxShape extends StatelessWidget {
  final bool isChecked;
  final Color color;
  const ProrityBoxShape(
      {super.key, required this.isChecked, required this.color});

  @override
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
