import 'package:flutter/material.dart';
import 'package:shopme/widgets/cost_productwidget.dart';

class CartProductIntoWidget extends StatelessWidget {
  final String productName;
  final double cost;
  final String sellerName;
  const CartProductIntoWidget(
      {Key? key,
      required this.productName,
      required this.cost,
      required this.sellerName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // SizedBox(
    //   height: 5,
    // );
    return SizedBox(
      width: screenSize.width / 1.8,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Text(
                productName,
                style: const TextStyle(
                  fontSize: 18.0,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 3,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: CostWidget(color: Colors.black, cost: cost),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Sold by ",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                      text: sellerName,
                      style: const TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 11,
                          fontWeight: FontWeight.w500))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
