import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final int rating;
  const RatingStar({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (int i = 0; i < 5; i++) {
      children.add(i < rating
          ? const Icon(
              Icons.star,
              color: Colors.orange,
            )
          : const Icon(
              Icons.star_outline_outlined,
              color: Colors.orange,
            ));
    }

    return Row(
      children: children,
    );
  }
}
