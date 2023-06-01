import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopme/models/user_details_model.dart';
import 'package:shopme/resources/cloudfirestore_methods.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  CloudFirestoreClass cloudFirestoreClass = CloudFirestoreClass();

  Future<String> signUpUser(
      {required String name,
      required String address,
      required String email,
      required String password}) async {
    name.trim(); // This will remove space from the start and end of the string.If User pressed it accidentally.
    email.trim(); // SImply means accept spaces at the end of string.
    address.trim();
    password.trim();

// Some validation to check if the user has entered the required details.
    String output = "Something went wrong";
    if (name != "" && address != "" && email != "" && password != "") {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        UserDetailsModel user = UserDetailsModel(name: name, address: address);

        await cloudFirestoreClass.uploadNameAndAddressToDatabase(
          user: user,
        );
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
      // logic

    } else {
      output = "Please fill all the fields";
    }
    return output;
  }

  // for signin

  Future<String> signInUser(
      {required String email, required String password}) async {
    // This will remove space from the start and end of the string.If User pressed it accidentally.
    email.trim(); // SImply means accept spaces at the end of string.
    password.trim();

// Some validation to check if the user has entered the required details.
    String output = "Something went wrong";
    if (email != "" && password != "") {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
      // logic

    } else {
      output = "Please fill all the fields";
    }
    return output;
  }
}
