import 'package:flutter/material.dart';
import 'package:shopme/constants.dart/allconstants.dart';
import 'package:shopme/screens/custom_search_screen.dart';

import '../utils/colors.dart';

class AccountScreenAppbar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  AccountScreenAppbar({Key? key})
      : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: kAppBarHeight,
      width: screenSize.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Image.asset(
              "assets/images/logo1.png",
              height: kAppBarHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Notification(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.notifications_none,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Notification extends StatelessWidget {
  const Notification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text("Work in progress"),
        ),
      ),
    );
  }
}
