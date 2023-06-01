import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;

  const CustomButton(
      {Key? key,
      required this.child,
      required this.color,
      required this.isLoading,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        fixedSize: Size(screensize.width * 0.52, 35),
      ),
      onPressed: onPressed,
      child: !isLoading
          ? child
          : const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
