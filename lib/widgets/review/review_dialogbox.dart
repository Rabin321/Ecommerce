import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shopme/models/reviewmodel.dart';
import 'package:shopme/resources/cloudfirestore_methods.dart';
import 'package:shopme/state/provider/userdetailsprovider.dart';

class ReviewDialog extends StatelessWidget {
  final String productUid;
  const ReviewDialog({Key? key, required this.productUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      // your app's name?
      title: const Text(
        'Rate this product',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      // encourage your user to leave a high rating?
      // message: Text(
      //   'Tap a star to set your rating. Add more description here if you want.',
      //   textAlign: TextAlign.center,
      //   style: const TextStyle(fontSize: 15),
      // ),
      // your app's logo?

      // image: Image.asset(
      //   "assets/images/esewa.jpg",
      //   width: 70,
      //   height: 70,
      // ),
      image: Center(
        child: LottieBuilder.asset(
          "assets/images/reviewstaranimation.json",
          // "https://assets3.lottiefiles.com/packages/lf20_4vijf7k3.json",

          width: 50,
          height: 70,
          frameRate: FrameRate(200),
          repeat: true,
          fit: BoxFit.fitHeight,
        ),
      ),

      submitButtonText: 'Send',
      commentHint: 'Type here',
      onCancelled: () => print('cancelled'),
      onSubmitted: (RatingDialogResponse res) async {
        CloudFirestoreClass().uploadReviewToDatabase(
            productUid: productUid,
            model: ReviewModel(
                senderName:
                    Provider.of<UserDetailsProvider>(context, listen: false)
                        .userDetails
                        .name,
                description: res.comment,
                rating: res.rating.toInt()));
      },
    );
  }
}

// class Starlottieanimation extends StatelessWidget {
//   const Starlottieanimation({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LottieBuilder.network(
//         "https://assets1.lottiefiles.com/packages/lf20_t5335f9l.json",
//         // width: 30,
//         // height: 30,
//         fit: BoxFit.fill,
//         repeat: true,
//       ),
//     );
//   }
// }
