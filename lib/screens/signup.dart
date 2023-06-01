import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopme/screens/signin.dart';
import 'package:shopme/utils/utils.dart';

import '../resources/authentication.dart';
import '../widgets/custom_in_out_btn.dart';
import '../widgets/textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  // Instance of AuthenticationMethod
  AuthenticationMethods authenticationMethods = AuthenticationMethods();

  bool isLoading = false;

  @override
  void dispose() {
    emailcontroller.dispose();
    namecontroller.dispose();
    passwordcontroller.dispose();
    addresscontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 201, 216, 224),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screensize.height,
          width: screensize.width,
          child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/images/logo1.png",
                      height: screensize.height * 0.15,
                      // width: screensize.width * 0.80,
                    ),
                    Container(
                        height: screensize.height * 0.58,
                        width: screensize.width * 0.8,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 27.0, fontWeight: FontWeight.bold),
                            ),
                            // const SizedBox(
                            //   height: 5,
                            // ),
                            CustomTextField(
                                title: "Name",
                                controller: namecontroller,
                                hinttext: "Enter your name",
                                obscureText: false),

                            CustomTextField(
                                title: "Address",
                                controller: addresscontroller,
                                hinttext: "Enter your address",
                                obscureText: false),

                            CustomTextField(
                                title: "Email",
                                controller: emailcontroller,
                                hinttext: "Enter your email address",
                                obscureText: false),

                            // SizedBox(
                            //   height: 10,
                            // ),
                            // password

                            CustomTextField(
                                title: "Password",
                                controller: passwordcontroller,
                                hinttext: "Enter your password",
                                obscureText: true),
                            // const SizedBox(
                            //   height: 8,
                            // ),

                            Center(
                              child: CustomButton(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 0.8,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  color: Colors.orange,
                                  isLoading: isLoading,
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    // print("${namecontroller.text} is name");
                                    // print("${emailcontroller.text} is email");
                                    // print("${passwordcontroller.text} is pass");
                                    String output =
                                        await authenticationMethods.signUpUser(
                                            name: namecontroller.text,
                                            address: addresscontroller.text,
                                            email: emailcontroller.text,
                                            password: passwordcontroller.text);

                                    setState(() {
                                      isLoading = false;
                                    });

                                    if (output == "success") {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const SigninScreen()));

                                      // Logic
                                      log("next step");
                                    } else {
                                      // error
                                      // log(output);
                                      // just using instead of print()
                                      Utils().showSnackBar(
                                          context: context, content: output);
                                    }
                                  }),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        child: Text("Back to Sign In",
                            style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 0.8,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                        color: Colors.blueGrey,
                        isLoading: false,
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const SigninScreen();
                          }));
                        }),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
