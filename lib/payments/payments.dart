import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:shopme/constants.dart/allconstants.dart';
import 'package:shopme/payments/khalti/khalti_payment.dart';
import 'package:shopme/utils/colors.dart';
import 'package:shopme/widgets/searchbar.dart';

class PaymentGateway extends StatelessWidget {
  const PaymentGateway({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Color.fromARGB(255, 228, 88, 8),
        centerTitle: true,
        title: const Text(
          'Payment Gateway',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 23),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, right: 20, left: 20),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
          ),
          children: [
            Container(
              height: 40,
              color: Colors.red,
              child: InkWell(
                child: Image.asset(
                  'assets/images/khaltip.jpg',
                  fit: BoxFit.fill,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => KhaltiPayment()));
                },
              ),
            ),
            Container(
              height: 40,
              color: Colors.red,
              child: InkWell(
                child: Image.asset(
                  'assets/images/esewapp.jpg',
                  fit: BoxFit.fill,
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
