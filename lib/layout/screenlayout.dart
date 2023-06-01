import 'package:flutter/material.dart';
import 'package:shopme/utils/colors.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  changePage(int page) {
    pageController.jumpToPage(page);
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: PageView(
          controller: pageController,
          children: const [
            Center(
              child: Text("Home page"),
            ),
            Center(
              child: Text("Account page"),
            ),
            Center(
              child: Text("Cart page"),
            ),
            Center(
              child: Text("More page"),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color.fromARGB(255, 192, 190, 190),
                width: 1,
              ),
            ),
          ),
          child: TabBar(
              indicator: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: activeCyanColor, width: 4.0),
                ),
              ),
              onTap: changePage,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Icon(
                    Icons.home,
                    color: currentPage == 0 ? activeCyanColor : Colors.black,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.account_circle_rounded,
                    color: currentPage == 1 ? activeCyanColor : Colors.black,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.shopping_cart,
                    color: currentPage == 2 ? activeCyanColor : Colors.black,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.menu,
                    color: currentPage == 3 ? activeCyanColor : Colors.black,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
