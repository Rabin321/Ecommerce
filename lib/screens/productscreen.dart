import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopme/constants.dart/allconstants.dart';
import 'package:shopme/models/productmodel.dart';
import 'package:shopme/models/reviewmodel.dart';
import 'package:shopme/models/user_details_model.dart';
import 'package:shopme/resources/cloudfirestore_methods.dart';
import 'package:shopme/utils/colors.dart';
import 'package:shopme/utils/utils.dart';
import 'package:shopme/widgets/cost_productwidget.dart';
import 'package:shopme/widgets/custom_in_out_btn.dart';
import 'package:shopme/widgets/product_save_dlt_btn.dart';
import 'package:shopme/widgets/review/ratingstar_widget.dart';
import 'package:shopme/widgets/review/review_dialogbox.dart';
import 'package:shopme/widgets/review/reviewwidget.dart';
import 'package:shopme/widgets/searchbar.dart';
import 'package:shopme/widgets/userdetails_location.dart';

import '../state/provider/userdetailsprovider.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({Key? key, required this.productModel}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Expanded littlespace = Expanded(child: Container());
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: SearchBarWidget(
        hasBackButton: true,
        isReadOnly: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 33),
              child: Column(
                children: [
                  SizedBox(
                    // before was sizedboz
                    // height: screenSize.height -
                    //     (kAppBarHeight + (kAppBarHeight / 2)),
                    height: screenSize.height * 0.68,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: kAppBarHeight / 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      widget.productModel.sellerName,
                                      style: const TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 17),
                                    ),
                                  ),
                                  Text(
                                    widget.productModel.productName,
                                    style: const TextStyle(
                                        fontSize: 19,
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 3,
                                  ),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                ],
                              ),
                              RatingStar(rating: widget.productModel.rating),
                            ],
                          ),
                        ),

                        // for product image.
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                            height: screenSize.height / 3.5,
                            constraints: BoxConstraints(
                                maxHeight: screenSize.height / 3.5),
                            child: Image.network(widget.productModel.url),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CostWidget(
                            color: Colors.black,
                            cost: widget.productModel.cost),
                        CustomButton(
                          color: const Color.fromARGB(255, 43, 199, 29),
                          isLoading: false,
                          onPressed: () async {
                            await CloudFirestoreClass().addProductToOrders(
                                model: widget.productModel,
                                userDetails: Provider.of<UserDetailsProvider>(
                                        context,
                                        listen: false)
                                    .userDetails);
                            Utils().showSnackBar(
                                context: context, content: "Done");
                          },
                          child: const Text(
                            "Buy Now",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                letterSpacing: 0.3),
                          ),
                        ),
                        //littlespace,

                        CustomButton(
                          color: Colors.orange,
                          isLoading: false,
                          onPressed: () async {
// first add product to db. Then add product to user's cart.
                            await CloudFirestoreClass().addProductToCard(
                                productModel: widget.productModel);
                            Utils().showSnackBar(
                                context: context, content: "Added to cart");
                          },
                          child: const Text(
                            "Add to cart",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                letterSpacing: 0.3),
                          ),
                        ),
                        // littlespace,
                        const SizedBox(
                          height: 20,
                        ),
                        CustomReviewButton(
                          text: "Add a review",
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => ReviewDialog(
                                    productUid: widget.productModel.uid));
                          },
                        ),

                        // const SizedBox(
                        //   height: 50,
                        // ),
                      ],
                    ),
                  ), ////
                  SizedBox(
                    // before was sizebox

                    // height: kAppBarHeight / 2,
                    height: screenSize.height,
                    width: screenSize.width,
                    child: StreamBuilder(
                      // will constantly listen to any changes in cloud firestore.
                      stream: FirebaseFirestore.instance
                          .collection("Products")
                          .doc(widget.productModel.uid)
                          .collection("reviews")
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
                                ReviewModel model =
                                    ReviewModel.getModelFromJson(
                                        json:
                                            snapshot.data!.docs[index].data());

                                return ReviewWidget(
                                  review: model,
                                );
                              });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const UserDetailsLoc(
            offset: 0,
            // userDetails: was used before providerdb630
            //     UserDetailsModel(name: "Rabin", email: "rabin123@gmail.com"),
          ),
        ],
      ),
    ));
  }
}

// CUSTOM REVIEW BUTTON

class CustomReviewButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomReviewButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color.fromARGB(255, 235, 223, 213),
            border: Border.all(color: Colors.grey, width: 1)),
        child: Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
