import 'package:flutter/material.dart';
import 'package:shopme/utils/colors.dart';

class ProductShow extends StatelessWidget {
  final String title;
  final List<Widget> children;
  ProductShow({Key? key, required this.title, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height / 4;
    double titleHeight = 25;
    return Container(
      margin: const EdgeInsets.all(13),
      padding: const EdgeInsets.all(8),
      height: height,
      width: screenSize.width,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: titleHeight,
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 18.0),
                  child: Text(
                    "Show more",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 102, 0),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height - (titleHeight + 56), //26
            width: screenSize.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: children,
            ),
          )
        ],
      ),
    );
  }
}
