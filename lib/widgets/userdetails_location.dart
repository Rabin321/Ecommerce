import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopme/models/user_details_model.dart';
import 'package:shopme/state/provider/userdetailsprovider.dart';
import 'package:shopme/utils/colors.dart';

import '../constants.dart/allconstants.dart';

class UserDetailsLoc extends StatelessWidget {
  final double offset;
  // final UserDetailsModel userDetails;
  const UserDetailsLoc({
    Key? key,
    required this.offset,
    //  required this.userDetails
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    UserDetailsModel userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Positioned(
      top: -offset / 4,
      child: Container(
        width: screenSize.width,
        height: kAppBarHeight / 2,
        decoration: const BoxDecoration(
          color: userdetailsloccolor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 20,
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                width: screenSize.width * 0.7,
                child: Text(
                  "Deliver to ${userDetails.name} - ${userDetails.address}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black87, fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
