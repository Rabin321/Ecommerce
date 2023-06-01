import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopme/resources/cloudfirestore_methods.dart';
import 'package:shopme/state/provider/userdetailsprovider.dart';
import 'package:shopme/utils/utils.dart';
import 'package:shopme/widgets/circularprogressindicator/loadingwidget.dart';
import 'package:shopme/widgets/custom_in_out_btn.dart';
import 'package:shopme/widgets/textfield.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isLoading = false;
  int selected = 1; // for radio
  Uint8List? image; // need to store this image into db

  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  List<int> keysForDiscount = [0, 50, 20, 10];

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    costController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: !isLoading
          ? SingleChildScrollView(
              child: SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          children: [
                            image == null
                                ? Image.network(
                                    "https://static-01.daraz.com.np/p/351b2acfb69381c3b7e3559251de9769.jpg",
                                    height: screenSize.height / 10,
                                  )
                                : Image.memory(
                                    image!,
                                    height: screenSize.height / 10,
                                  ),
                            IconButton(
                              onPressed: () async {
                                Uint8List? temp = await Utils().pickImage();
                                if (temp != null) {
                                  setState(() {
                                    image = temp;
                                  });
                                }
                              },
                              icon: const Icon(Icons.file_upload_sharp,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          height: screenSize.height * 0.6,
                          width: screenSize.width * 0.8,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Add a Product",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                CustomTextField(
                                    title: "Name",
                                    controller: nameController,
                                    obscureText: false,
                                    hinttext: "Enter Product Name"),
                                CustomTextField(
                                  title: "Cost",
                                  controller: costController,
                                  obscureText: false,
                                  hinttext: 'Cost of item',
                                ),
                                const Text(
                                  "Discount",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                ListTile(
                                  title: const Text("None"),
                                  leading: Radio(
                                    value: 1,
                                    groupValue: selected,
                                    onChanged: (int? i) {
                                      setState(
                                        () {
                                          selected = i!;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text("50%"),
                                  leading: Radio(
                                    value: 2,
                                    groupValue: selected,
                                    onChanged: (int? i) {
                                      setState(
                                        () {
                                          selected = i!;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text("20%"),
                                  leading: Radio(
                                    value: 3,
                                    groupValue: selected,
                                    onChanged: (int? i) {
                                      setState(
                                        () {
                                          selected = i!;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text("10%"),
                                  leading: Radio(
                                    value: 4,
                                    groupValue: selected,
                                    onChanged: (int? i) {
                                      setState(
                                        () {
                                          selected = i!;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ]),
                        ),
                        CustomButton(
                          color: const Color.fromARGB(255, 238, 143, 0),
                          isLoading: isLoading,
                          onPressed: () async {
                            String output = await CloudFirestoreClass()
                                .uploadProductToDatabase(
                                    image,
                                    nameController.text,
                                    costController.text,
                                    keysForDiscount[selected - 1],
                                    Provider.of<UserDetailsProvider>(context,
                                            listen: false)
                                        .userDetails
                                        .name,
                                    FirebaseAuth.instance.currentUser!.uid);

                            if (output == "success") {
                              Utils().showSnackBar(
                                  context: context,
                                  content: "Successfully added a product");
                            } else {
                              Utils().showSnackBar(
                                  context: context, content: output);
                            }
                          },
                          child: const Text(
                            "Sell",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                        CustomButton(
                          color: Colors.grey[400]!,
                          isLoading: isLoading,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Back",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const LoadingWidget(),
    ));
  }
}
