import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:shopme/constants.dart/allconstants.dart';
import 'package:shopme/models/orderrequests.dart';
import 'package:shopme/models/productmodel.dart';
import 'package:shopme/models/user_details_model.dart';
import 'package:shopme/screens/sellscreen.dart';
import 'package:shopme/state/provider/userdetailsprovider.dart';
import 'package:shopme/utils/colors.dart';
import 'package:shopme/widgets/account_screen_appbar.dart';
import 'package:shopme/widgets/custom_in_out_btn.dart';
import 'package:shopme/widgets/productsshow.dart';

import '../widgets/product_fifty.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AccountScreenAppbar(),
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Column(
              children: [
                const IntroaccountWidget(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    color: const Color.fromARGB(255, 231, 187, 120),
                    isLoading: false,
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Text(
                      "Sign out",
                      style: TextStyle(color: Colors.black, fontSize: 21),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    color: const Color.fromARGB(255, 230, 148, 123),
                    isLoading: false,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SellScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sell ",
                      style: TextStyle(color: Colors.black, fontSize: 21),
                    ),
                  ),
                ),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("orders")
                        .get(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        List<Widget> children = [];

                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          ProductModel model = ProductModel.getModelFromJson(
                              json: snapshot.data!.docs[i].data());
                          children.add(SimpleProductWidget(
                            productModel: model,
                          ));
                        }
                        return ProductShow(
                            title: "Your orders", children: children);
                      }
                    }),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Order Requests",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                    child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("orderRequests")
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            OrderRequestsModel model =
                                OrderRequestsModel.getModelFromJson(
                                    json: snapshot.data!.docs[index].data());
                            return ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Order: ${model.orderName}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 19),
                                ),
                              ),
                              subtitle: Text(
                                "Address: ${model.buyersAddress}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection("orderRequests")
                                        .doc(snapshot.data!.docs[index].id)
                                        .delete();
                                  },
                                  icon: const Icon(Icons.check)),
                            );
                          });
                    }
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IntroaccountWidget extends StatelessWidget {
  const IntroaccountWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context)
            .userDetails; // get data(name, email) from db
    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Container(
        height: kAppBarHeight / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.000000001),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Hello, ",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: userDetailsModel.name, // name from db
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_5PRtuAPKOWhkz7Lgn55iK1Z1JhhzKlmLUg&usqp=CAU"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
