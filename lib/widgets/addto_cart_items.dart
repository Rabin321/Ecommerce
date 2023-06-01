import 'package:flutter/material.dart';
import 'package:shopme/models/productmodel.dart';
import 'package:shopme/resources/cloudfirestore_methods.dart';
import 'package:shopme/screens/productscreen.dart';
import 'package:shopme/utils/colors.dart';
import 'package:shopme/utils/utils.dart';
import 'package:shopme/widgets/cart_products_info.dart';
import 'package:shopme/widgets/no_of_product_btn.dart';
import 'package:shopme/widgets/product_save_dlt_btn.dart';

// Here we need to pass folloeing values like product name, description, price , quqntity to confirmed page if user clicked in Proceed to buy items.
// For doing so, a model should be created and then pass it to confirmed page.
class CartItemWidget extends StatelessWidget {
  final ProductModel product;

  const CartItemWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      // padding: EdgeInsets.all(5),
      height: screenSize.height / 2.5,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, top: 30),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProductScreen(productModel: product);
                      },
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: SizedBox(
                        width: screenSize.width / 3.3,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Image.network(
                            // Changed this "https://static-01.daraz.com.np/p/351b2acfb69381c3b7e3559251de9769.jpg", into product.url (after creating productmodel)
                            product.url,
                          ),
                        ),
                      ),
                    ),
                    CartProductIntoWidget(
                      productName:
                          // "Men's Abc watch with brown leather straps, waterproof",
                          product.productName,
                      cost: product.cost,
                      // 3000.78,
                      sellerName: product.sellerName,
                    ),
                    // "Rolex King")
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  NoOfProductBtn(
                    onPressed: () {},
                    color: backgroundColor,
                    dimension: 40,
                    child: const Icon(Icons.remove),
                  ),
                  // const SizedBox(
                  //   width: 4,
                  // ),
                  NoOfProductBtn(
                    onPressed: () {},
                    color: Colors.white,
                    dimension: 40,
                    child: const Text(
                      "1",
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 23,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 4,
                  // ),
                  NoOfProductBtn(
                    onPressed: () async {
                      await CloudFirestoreClass().addProductToCard(
                          productModel: ProductModel(
                              product.url,
                              product.productName,
                              product.cost,
                              product.discount,
                              Utils().getUid(),
                              product.sellerName,
                              product.sellerUid,
                              product.rating,
                              product.noOfRating));
                    },
                    color: backgroundColor,
                    dimension: 40,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      // CustomproductdelsaveButton(
                      //   text: "Remove",
                      //   onPressed: () async {
                      //     CloudFirestoreClass()
                      //         .deleteProductFromCart(uid: product.uid);
                      //   },
                      // ),

                      NoOfProductBtn(
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            CloudFirestoreClass()
                                .deleteProductFromCart(uid: product.uid);
                          },
                          color: Colors.white,
                          dimension: 40),
                      // IconButton(
                      //     onPressed: () async {
                      //       CloudFirestoreClass()
                      //           .deleteProductFromCart(uid: product.uid);
                      //     },
                      //     icon: const Icon(
                      //       Icons.delete,
                      //       color: Colors.deepOrange,
                      //     )),
                      const SizedBox(
                        width: 7,
                      ),
                      NoOfProductBtn(
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.green,
                          ),
                          onPressed: () async {
                            CloudFirestoreClass()
                                .deleteProductFromCart(uid: product.uid);
                          },
                          color: Colors.white,
                          dimension: 40),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 18.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "See more like this",
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
