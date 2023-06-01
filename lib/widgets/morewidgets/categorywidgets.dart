import 'package:flutter/material.dart';
import 'package:shopme/constants.dart/allconstants.dart';
import 'package:shopme/screens/results/resultscreen.dart';

class MyWidget extends StatelessWidget {
  final int index;
  const MyWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ResultsScreen(query: categoriesList[index]);
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                categoryLogos[index],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  categoriesList[index],
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
