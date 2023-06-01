import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shopme/models/orderrequests.dart';
import 'package:shopme/models/productmodel.dart';
import 'package:shopme/models/reviewmodel.dart';
import 'package:shopme/models/user_details_model.dart';
import 'package:shopme/utils/utils.dart';
import 'package:shopme/widgets/product_fifty.dart';
import 'package:shopme/widgets/userdetails_location.dart';

// About database
class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future uploadNameAndAddressToDatabase(
      {required UserDetailsModel user}) async {
    await firebaseFirestore
        .collection(
            "users") // this will create users collection if it doesn't exist.
        .doc(firebaseAuth.currentUser!
            .uid) // this will create document with user id if it doesn't exist.
        .set(// it takes as a json or we can say map.
            user.getJson());
  }

// Get values from database(firebase). It we update values in db then it gets updated in our app.=> provider.
  Future getNameAndAddress() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    // print(snap);

// Create instance from map.
    UserDetailsModel userModel = UserDetailsModel.getModelFromJson(
      snap.data() as dynamic,
    );
// print json of that instance.
    // print(userModel.getJson());

    return userModel;
  }

  Future<String> uploadProductToDatabase(
    Uint8List? image,
    String productName,
    String rawCost,
    int discount,
    String sellerName,
    String sellerUid,
    // int rating,
    // int noOfRating
  ) async {
    // ProductModel(url, productName, cost, discount, uid, sellerName, sellerUid, rating, noOfRating)

    productName.trim();
    rawCost.trim();

    String output = "Something went wrong";

    if (image != null && productName != "" && rawCost != "") {
      try {
        String uid = Utils().getUid();
        String url = await uploadImageToDatabase(image: image, uid: uid);

        double cost = double.parse(rawCost);
        // discount logic
        cost = cost - (cost * (discount / 100));

        ProductModel product = ProductModel(
          url,
          productName,
          cost,
          discount,
          uid,
          sellerName,
          sellerUid,
          5,
          0,
        );

        await firebaseFirestore
            .collection("Products")
            .doc(uid)
            .set(product.getJson());

        print(url);
        output = "Successfuly added a product";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please fill all the fields";
    }

    return output;
  }

  // now upload product to db

  Future<String> uploadImageToDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child("Products")
        .child(
            uid); // "Products" is the name of the folder in storage.(Firebase)

    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot task = await uploadTask;

    return task.ref
        .getDownloadURL(); // Get uid so that we can use it to get the image from storage and use it in .
  }
  // image uploaded to storage with uid.

  // list/Sort products in storage on the basis of discount.

  Future<List<Widget>> getProductsFromDiscount(int discount) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("Products")
        .where("discount", isEqualTo: discount)
        .get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];

      ProductModel model = ProductModel.getModelFromJson(
        json: (docSnap.data() as dynamic),
      );
      children.add(SimpleProductWidget(productModel: model));
    }

    return children;
  }

  Future uploadReviewToDatabase({
    required String productUid,
    required ReviewModel model,
  }) async {
    await firebaseFirestore
        .collection("Products")
        .doc(productUid)
        .collection("reviews")
        .add(model.getJson());
    await changeAverageRating(productUid: productUid, reviewModel: model);
  }

  Future addProductToCard({required ProductModel productModel}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(productModel.uid)
        .set(productModel.getJson());
  }

  Future deleteProductFromCart({required String uid}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(uid)
        .delete();
  }

  Future buyAllItemsInCart({required UserDetailsModel userDetails}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      ProductModel model =
          ProductModel.getModelFromJson(json: snapshot.docs[i].data());
      addProductToOrders(model: model, userDetails: userDetails);
      await deleteProductFromCart(uid: model.uid);
    }
  }

  Future addProductToOrders(
      {required ProductModel model,
      required UserDetailsModel userDetails}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("orders")
        .add(model.getJson());
    await sendOrderRequests(model: model, userDetails: userDetails);
  }

  Future sendOrderRequests(
      {required ProductModel model,
      required UserDetailsModel userDetails}) async {
    OrderRequestsModel orderRequestsModel = OrderRequestsModel(
        orderName: model.productName,
        buyersAddress:
            userDetails.address); // NEED TO FIX ADDRESS INSTEAD OF EMAIL.

    await firebaseFirestore
        .collection("users")
        .doc(model.sellerUid)
        .collection("orderRequests")
        .add(orderRequestsModel.getJson());
  }

  Future changeAverageRating(
      {required String productUid, required ReviewModel reviewModel}) async {
    DocumentSnapshot snapshot =
        await firebaseFirestore.collection("Products").doc(productUid).get();

    ProductModel model =
        ProductModel.getModelFromJson(json: (snapshot.data() as dynamic));

    int currentRating = model.rating;
    int newRating = ((currentRating + reviewModel.rating) ~/ 2).toInt();

    await firebaseFirestore
        .collection("Products")
        .doc(productUid)
        .update({"rating": newRating});
  }
}
