import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopme/screens/results/results_widget.dart';
import 'package:shopme/widgets/circularprogressindicator/loadingwidget.dart';
import 'package:shopme/widgets/searchbar.dart';

import '../../models/productmodel.dart';

class ResultsScreen extends StatelessWidget {
  final String query;
  const ResultsScreen({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(isReadOnly: false, hasBackButton: true),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: "Showing results for ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      )),
                  TextSpan(
                    text: query,
                    style: const TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                  ),
                ]),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("products")
                      .where("productName", isEqualTo: query)
                      .get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget();
                    } else {
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 30,
                                  crossAxisSpacing: 3,
                                  crossAxisCount: 3,
                                  childAspectRatio: 2 / 3),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ProductModel product =
                                ProductModel.getModelFromJson(
                                    json: snapshot.data!.docs[index].data());
                            return ResultWidget(product: product);
                          });
                    }
                  }))
        ],
      ),
    );
  }
}
