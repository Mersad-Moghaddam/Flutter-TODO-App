import 'package:flutter/material.dart';
import 'package:flutter_todo/main.dart';
import 'package:flutter_todo/widgets/prority_box_shape.dart';

class PriorityCheckBox extends StatelessWidget {
  final GestureTapCallback onTap;
  final String label;
  final Color color;
  final bool isChecked;
  const PriorityCheckBox(
      {super.key,
      required this.label,
      required this.color,
      required this.isChecked,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 40,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  width: 2, color: secondryTextColor.withOpacity(0.20)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                  spreadRadius: 1,
                )
              ]),
          child: Stack(children: [
            Center(
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            Positioned(
                right: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: ProrityBoxShape(isChecked: isChecked, color: color),
                )),
          ])),
    );
  }
}
