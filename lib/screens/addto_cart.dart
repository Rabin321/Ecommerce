import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopme/constants.dart/allconstants.dart';
import 'package:shopme/models/productmodel.dart';
import 'package:shopme/payments/khalti/khalti_payment.dart';
import 'package:shopme/payments/payments.dart';

import 'package:shopme/resources/cloudfirestore_methods.dart';
import 'package:shopme/state/provider/userdetailsprovider.dart';

import 'package:shopme/utils/utils.dart';
import 'package:shopme/widgets/addto_cart_items.dart';
import 'package:shopme/widgets/custom_in_out_btn.dart';
import 'package:shopme/widgets/searchbar.dart';
import 'package:shopme/widgets/userdetails_location.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(isReadOnly: true, hasBackButton: false),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: kAppBarHeight / 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("cart")
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CustomButton(
                            color: const Color.fromARGB(255, 29, 173, 34),
                            isLoading: true,
                            onPressed: () {},
                            child: const Text(
                              "Loading",
                            ),
                          );
                        } else {
                          return CustomButton(
                            color: const Color.fromARGB(255, 29, 173, 34),
                            isLoading: false,

                            // WITH NO PAYMENTS.

                            // onPressed: () async {
                            //   await CloudFirestoreClass().buyAllItemsInCart(
                            //       userDetails: Provider.of<UserDetailsProvider>(
                            //               context,
                            //               listen: false)
                            //           .userDetails);

                            //   Utils().showSnackBar(
                            //       context: context, content: "Done");
                            // },

                            // after khalti
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PaymentGateway()));
                            },
                            child: Text(
                              "Proceed to buy ${snapshot.data!.docs.length} items",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          );
                        }
                      }),
                ),
                Expanded(
                  // BEFORE Add to cart backend.
                  //  child:  ListView.builder(
                  //     itemCount: 5,
                  //     itemBuilder: (context, index) {
                  //       return CartItemWidget(
                  //         product: ProductModel(
                  //             "https://static-01.daraz.com.np/p/351b2acfb69381c3b7e3559251de9769.jpg",
                  //             "Men's watch Add to cart ",
                  //             3999,
                  //             0,
                  //             "001A",
                  //             "King",
                  //             "Z001",
                  //             4,
                  //             6),

                  //         // product: ProductModel(url, productName, cost, discount, uid, sellerName, sellerUid, rating, noOfRating),
                  //         //  url:"https://static-01.daraz.com.np/p/351b2acfb69381c3b7e3559251de9769.jpg", productName:"Men's watch", cost:3999, discount:0, uid:"001A", sellerName:"King", sellerUid:"Z001", rating:4.5, noOfRating:6
                  //       );
                  //     }),

                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("cart")
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                ProductModel model =
                                    ProductModel.getModelFromJson(
                                        json:
                                            snapshot.data!.docs[index].data());

                                return CartItemWidget(product: model);
                              });
                        }
                      }),
                )
              ],
            ),
            const UserDetailsLoc(
              offset: 0,
              // userDetails:  was used befo provider.
              //     UserDetailsModel(name: "Rabin", email: "rabin123@gmail.com"),
            ),
          ],
        ),
      ),
    );
  }
}
