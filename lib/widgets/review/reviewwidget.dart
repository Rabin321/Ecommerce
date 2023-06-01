import 'package:flutter/material.dart';
import 'package:shopme/models/reviewmodel.dart';
import 'package:shopme/widgets/review/ratingstar_widget.dart';
import 'package:shopme/constants.dart/allconstants.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;
  const ReviewWidget({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.senderName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: SizedBox(
                    width: screenSize.width / 4,
                    child: FittedBox(
                      child: RatingStar(rating: review.rating),
                    ),
                  ),
                ),
                Text(
                  keyOfRating[review.rating - 1],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          Text(
            review.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
