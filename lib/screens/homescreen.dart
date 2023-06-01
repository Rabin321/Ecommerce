import 'package:flutter/material.dart';
import 'package:shopme/constants.dart/allconstants.dart';
import 'package:shopme/resources/cloudfirestore_methods.dart';
import 'package:shopme/widgets/bannerad.dart';
import 'package:shopme/widgets/circularprogressindicator/loadingwidget.dart';
import 'package:shopme/widgets/product_categories.dart';
import 'package:shopme/widgets/productsshow.dart';
import 'package:shopme/widgets/searchbar.dart';
import 'package:shopme/widgets/userdetails_location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;

  List<Widget>? discount50;
  List<Widget>? discount20;
  List<Widget>? discount10;
  List<Widget>? discount0;

  // List<Widget> testChildren = [
  //   SimpleProductWidget(
  //     url:
  //         "https://static-01.daraz.com.np/p/94c10ac31975edbf245219262ad9f946.jpg",
  //   ),
  //   SimpleProductWidget(
  //     url:
  //         "https://static-01.daraz.com.np/p/acbe5de23f18b3c6c3e339372385da4b.jpg",
  //   ),
  //   SimpleProductWidget(
  //     url:
  //         "https://static-01.daraz.com.np/p/94c10ac31975edbf245219262ad9f946.jpg",
  //   ),
  //   SimpleProductWidget(
  //     url:
  //         "https://static-01.daraz.com.np/p/d138447378bd6d2a5758304d754e533e.jpg",
  //   ),
  // ];

  @override
  void initState() {
    super.initState();
    getData(); //

    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void getData() async {
    List<Widget> temp50 =
        await CloudFirestoreClass().getProductsFromDiscount(50);
    List<Widget> temp20 =
        await CloudFirestoreClass().getProductsFromDiscount(20);
    List<Widget> temp10 =
        await CloudFirestoreClass().getProductsFromDiscount(10);
    List<Widget> temp0 = await CloudFirestoreClass().getProductsFromDiscount(0);

    print("mildaixaa");
    setState(() {
      discount50 = temp50;
      discount20 = temp20;
      discount10 = temp10;
      discount0 = temp0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: true,
        hasBackButton: false,
      ),
      // drawer: const MyDrawer(),
      body: discount50 != null &&
              discount20 != null &&
              discount10 != null &&
              discount0 != null
          ? Stack(
              children: [
                SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: kAppBarHeight / 2,
                      ),

                      const CategoriesListView(), //1st row
                      const Bannerad(), // 2nd row

                      // 3rd row
                      ProductShow(title: "Upto 50% off", children: discount50!),
                      // SimpleProductWidget(
                      //   url:
                      //       "https://static-01.daraz.com.np/p/94c10ac31975edbf245219262ad9f946.jpg",
                      // ),
                      // SimpleProductWidget(
                      //   url:
                      //       "https://static-01.daraz.com.np/p/acbe5de23f18b3c6c3e339372385da4b.jpg",
                      // ),
                      // SimpleProductWidget(
                      //   url:
                      //       "https://static-01.daraz.com.np/p/94c10ac31975edbf245219262ad9f946.jpg",
                      // ),
                      // SimpleProductWidget(
                      //   url:
                      //       "https://static-01.daraz.com.np/p/d138447378bd6d2a5758304d754e533e.jpg",
                      // ),

                      // 4th row
                      ProductShow(title: "Upto 20% off", children: discount20!),

                      //5th row

                      ProductShow(title: "Upto 10% off", children: discount10!),

                      // 6th row explore
                      ProductShow(title: "Explore", children: discount0!),
                    ],
                  ),
                ),
                // 1.1 row
                UserDetailsLoc(
                  offset: offset,
                  // userDetails:  was used befo provider630
                  //     UserDetailsModel(name: "Rabin", email: "test@gmail.com"),
                ),
              ],
            )
          : const LoadingWidget(),
    );
  }
}
