import 'package:flutter/material.dart';

class NoOfProductBtn extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double dimension;
  final Color color;

  const NoOfProductBtn(
      {Key? key,
      required this.child,
      required this.onPressed,
      required this.color,
      required this.dimension})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: dimension,
        height: dimension,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}
