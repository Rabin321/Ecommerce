import 'package:flutter/material.dart';
import 'package:shopme/models/user_details_model.dart';

import '../../resources/cloudfirestore_methods.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetails;

  UserDetailsProvider()
      : userDetails = UserDetailsModel(name: "loading", address: "loading");

  Future getData() async {
    userDetails = await CloudFirestoreClass().getNameAndAddress();
    notifyListeners();
  }
}
