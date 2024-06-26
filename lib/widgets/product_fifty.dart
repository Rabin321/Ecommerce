import 'package:flutter/material.dart';
import 'package:shopme/models/productmodel.dart';
import 'package:shopme/screens/productscreen.dart';

class SimpleProductWidget extends StatelessWidget {
  // final String url;  comment this after using productModel.
  final ProductModel productModel;
  const SimpleProductWidget(
      {Key? key,

      //  required this.url,
      required this.productModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductScreen(productModel: productModel);
        }));
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.network(productModel.url),
          ),
        ),
      ),
    );
  }
}
