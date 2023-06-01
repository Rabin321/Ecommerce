import 'package:flutter/material.dart';
import 'package:shopme/resources/authentication.dart';
import 'package:shopme/screens/signup.dart';
import 'package:shopme/widgets/custom_in_out_btn.dart';
import 'package:shopme/widgets/textfield.dart';

import '../utils/utils.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  // Instance of AuthenticationMethod
  AuthenticationMethods authenticationMethods = AuthenticationMethods();

  bool isLoading = false;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 201, 216, 224),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screensize.height,
          width: screensize.width,
          child: Padding(
              padding: const EdgeInsets.symmetric(
                // horizontal: 20,
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
                    const SizedBox(
                      height: 0,
                    ),
                    Container(
                        height: screensize.height * 0.48,
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
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 27.0, fontWeight: FontWeight.bold),
                            ),
                            // const SizedBox(
                            //   height: 5,
                            // ),
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
                            const SizedBox(
                              height: 3,
                            ),

                            Center(
                              child: CustomButton(
                                  child: Text("Sign In",
                                      style: TextStyle(
                                          fontSize: 16,
                                          letterSpacing: 0.8,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                  color: Colors.orange,
                                  isLoading: isLoading,
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    // Future.delayed(const Duration(seconds: 1));

                                    String output =
                                        await authenticationMethods.signInUser(
                                            email: emailcontroller.text,
                                            password: passwordcontroller.text);

                                    setState(() {
                                      isLoading = false;
                                    });

                                    if (output == "success") {
                                    } else {
                                      // error
                                      Utils().showSnackBar(
                                          context: context, content: output);
                                    }
                                  }),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        )),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          "New to Deal Mart ?",
                          style:
                              TextStyle(fontSize: 13.0, color: Colors.black87),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    CustomButton(
                        child: Text("Create a Deal Mart account",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 0.8,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                        color: Colors.blueGrey,
                        isLoading: false,
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const SignUp();
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
