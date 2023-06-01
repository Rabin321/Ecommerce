import 'package:flutter/material.dart';
import 'package:shopme/utils/colors.dart';

class CustomproductdelsaveButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomproductdelsaveButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color.fromARGB(255, 235, 223, 213),
            border: Border.all(color: Colors.grey, width: 1)),
        child: Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
