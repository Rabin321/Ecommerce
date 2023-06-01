import 'dart:ui';

import 'package:flutter/material.dart';

class CostWidget extends StatelessWidget {
  final Color color;
  final double cost;
  const CostWidget({Key? key, required this.color, required this.cost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Rs ",
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black
              // fontFeatures: [
              //   FontFeature.superscripts(),
              // ],
              ),
        ),

        Text(
          cost.toInt().toString(),
          style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.deepOrange),
        ),

// decimal value -> after .
// for eg. If cost  is 555.88 then decimal = 555.88-555 == .88
        Text(
          (cost - cost.toInt()).toString(),
          style: TextStyle(
            fontSize: 10.0,
            color: color,
            // fontFeatures: [
            //   FontFeature.superscripts(),
            // ],
          ),
        )
      ],
    );
  }
}
