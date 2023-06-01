import 'package:flutter/material.dart';
import 'package:shopme/widgets/morewidgets/categorywidgets.dart';

import 'package:shopme/widgets/searchbar.dart';

import '../constants.dart/allconstants.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(isReadOnly: true, hasBackButton: false),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.2 / 3.5,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            // mainAxisExtent: 200
          ),
          itemCount: categoriesList.length,
          itemBuilder: (context, index) => MyWidget(index: index),
        ),
      ),
    );
  }
}
