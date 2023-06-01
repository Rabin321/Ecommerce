import 'package:flutter/material.dart';
import 'package:shopme/constants.dart/allconstants.dart';
import 'package:shopme/screens/custom_search_screen.dart';
import 'package:shopme/screens/results/resultscreen.dart';
import 'package:shopme/utils/colors.dart';

class SearchBarWidget extends StatelessWidget with PreferredSizeWidget {
  final bool isReadOnly;
  final bool hasBackButton;

  SearchBarWidget(
      {Key? key, required this.isReadOnly, required this.hasBackButton})
      : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 1,
    ),
  );
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      // bottom: true,
      // top: true,
      child: Container(
        height: kAppBarHeight,
        // color: Colors.red,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: backgroundGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),

        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          hasBackButton
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                )
              : Container(),
          // const Drawer(),
          SizedBox(
            width: screenSize.width * 0.76,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 30, top: 12, bottom: 12, right: 0),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 50,
                  spreadRadius: 0.5,
                  offset: const Offset(0, 6),
                ),
              ]),
              child: TextField(
                onSubmitted: (String query) {
                  // this is of resultsScreen,widgets.
                  // print("submmit");
                  // print("Submitted ${query}");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsScreen(query: query),
                    ),
                  );
                },
                cursorColor: Colors.black,
                cursorHeight: 21,
                readOnly: isReadOnly,
                onTap: () {
                  if (isReadOnly) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen()));
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.black,
                  ),

                  // suffixIcon: Icon(
                  //   Icons.camera_alt_outlined,
                  //   color: Colors.black,
                  // ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.mic_none_rounded,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 7,
                      )
                    ],
                  ),

                  // icon: Icon(Icons.search),
                  contentPadding: const EdgeInsets.only(left: 15),
                  hintText: "Search for your product",
                  hintStyle: const TextStyle(fontSize: 16.0),
                  fillColor: Colors.white,
                  filled: true,
                  border: border,
                  focusedBorder: border,
                ),
              ),
            ),
          ),

          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border_outlined,
                color: Colors.white,
                size: 27.0,
              )),
        ]),
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
