import 'package:flutter/material.dart';
import 'package:shopme/screens/productscreen.dart';
import 'package:shopme/utils/colors.dart';
import 'package:shopme/widgets/cost_productwidget.dart';
import 'package:shopme/widgets/review/ratingstar_widget.dart';

import '../../models/productmodel.dart';

class ResultWidget extends StatelessWidget {
  final ProductModel product;
  const ResultWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(productModel: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenSize.width / 2,
              child: Image.network(
                product.url,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                product.productName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: screenSize.width / 5,
                      child:
                          FittedBox(child: RatingStar(rating: product.rating))),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      product.noOfRating.toString(),
                      style: const TextStyle(color: activeCyanColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
              child: FittedBox(
                child: CostWidget(color: Colors.deepOrange, cost: product.cost),
              ),
            )
          ],
        ),
      ),
    );
  }
}
