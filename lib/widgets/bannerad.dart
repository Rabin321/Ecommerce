import 'package:flutter/material.dart';
import 'package:shopme/constants.dart/allconstants.dart';
import 'package:shopme/utils/colors.dart';

class Bannerad extends StatefulWidget {
  const Bannerad({Key? key}) : super(key: key);

  @override
  State<Bannerad> createState() => _BanneradState();
}

class _BanneradState extends State<Bannerad> {
  int currentAd = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double smallAdHeight = screenSize.width / 4.3;
    double largeAdHeight = screenSize.height * 0.3;

    return GestureDetector(
      onHorizontalDragEnd: (_) {
        if (currentAd == (largeAds.length - 1)) {
          currentAd = -1;
        }
        setState(() {
          currentAd++;
        });
      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                largeAds[currentAd],
                width: screenSize.width,
              ),

              // only for gradient
              Positioned(
                bottom: 0,
                child: Container(
                    width: screenSize.width,
                    height: screenSize.height * 0.09,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                          backgroundColor,
                          backgroundColor.withOpacity(0),
                        ]))),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            // padding: EdgeInsets.all(2),
            color: Colors.transparent,
            width: screenSize.width,
            height: smallAdHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getSmallAdsFromIndex(0, smallAdHeight),
                getSmallAdsFromIndex(1, smallAdHeight),
                getSmallAdsFromIndex(2, smallAdHeight),
                getSmallAdsFromIndex(3, smallAdHeight)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getSmallAdsFromIndex(int index, double height) {
    return Container(
      height: height,
      width: height * 0.9,
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              smallAds[index],
              height: 70,
              width: 70,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(adItemNames[index])
          ],
        ),
      ),
    );
  }
}
