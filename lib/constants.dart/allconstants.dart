import 'package:flutter/material.dart';
import 'package:shopme/screens/account.dart';
import 'package:shopme/screens/addto_cart.dart';
import 'package:shopme/screens/homescreen.dart';
import 'package:shopme/screens/morescreen.dart';
import 'package:shopme/widgets/product_fifty.dart';

import '../models/productmodel.dart';

const double kAppBarHeight = 70;

const String amazonLogoUrl =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Amazon_icon.svg/2500px-Amazon_icon.svg.png";

// of bottom_nav_bar

const List<Widget> screens = [
  HomeScreen(),
  Account(),
  CartScreen(),
  MoreScreen(),
];
const List<String> categoriesList = [
  "Deal Mart",
  "Mobiles",
  "Fashion",
  "Electronics",
  "Home",
  "Fresh",
  "Appliances",
  "Books, Toys",
  "Essential"
];

const List<String> categoryLogos = [
  "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/116KbsvwCRL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/115yueUc1aL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11qyfRJvEbL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11BIyKooluL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11CR97WoieL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/01cPTp7SLWL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11yLyO9f9ZL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11M0jYc-tRL._SX90_SY90_.png",
];

const List<String> largeAds = [
  "https://cdn.esewa.com.np/ui/images/slider/gkGC68lvkTFAcyiJeNbBRamailo%20games%20slider%20new.jpg",
  "https://www.onlinekhabar.com/wp-content/uploads/2022/07/52EA3CC6-4893-4CA1-B949-D3CD698CFCB2.jpeg",
  "https://scontent.fktm8-1.fna.fbcdn.net/v/t1.6435-9/120298670_771770496952624_2833226084771537033_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=B61vPO9GixkAX9rgT9E&_nc_ht=scontent.fktm8-1.fna&oh=00_AT9izNiaIKYm4mStank4LtX0tGHiDvcob6zJts1aHP9dgw&oe=62EC6B56",
  "https://nepaldrives.com/wp-content/uploads/2020/09/Booking-Open-Thee-GO.jpg",
  "https://cdn.esewa.com.np/ui/images/slider/RMUgGEk6YsliQelRdGn6Account%20link%20updated%20June%2019.jpg",
];

const List<String> smallAds = [
  "assets/images/esewa.jpg",
  "assets/images/esewa.jpg",
  "assets/images/esewa.jpg",
  "assets/images/esewa.jpg",
];

// for networkk images.

// const List<String> smallAds = [
//   "assets/images/esewa.jpg",
//   "https://m.media-amazon.com/images/I/11iTpTDy6TL._SS70_.png",
//   "https://m.media-amazon.com/images/I/11dGLeeNRcL._SS70_.png",
//   "https://m.media-amazon.com/images/I/11kOjZtNhnL._SS70_.png",
// ];

const List<String> adItemNames = [
  "E-Sewa",
  "E-Sewa",
  "E-Sewa",
  "E-Sewa",
];

// for reviewwidgets.dart

// make List of reviews so that reviews like poor, good, very good, etc. can be displayed according to rating star.
// for example => 1 star means poor and so on.

const List<String> keyOfRating = [
  "Very Bad",
  "Poor",
  "Good",
  "Very Good",
  "Excellent"
];

List<Widget> testChildern = [
  SimpleProductWidget(
    productModel: ProductModel(
        "https://static-01.daraz.com.np/p/351b2acfb69381c3b7e3559251de9769.jpg",
        "Men's watch  ",
        3999,
        0,
        "001A",
        "King",
        "Z001",
        4,
        6),
  ),
  SimpleProductWidget(
    productModel: ProductModel(
        "https://static-01.daraz.com.np/p/351b2acfb69381c3b7e3559251de9769.jpg",
        "Men's watch ",
        3999,
        0,
        "001A",
        "King",
        "Z001",
        4,
        6),
  ),
  SimpleProductWidget(
    productModel: ProductModel(
        "https://static-01.daraz.com.np/p/351b2acfb69381c3b7e3559251de9769.jpg",
        "Men's watch ",
        3999,
        0,
        "001A",
        "King",
        "Z001",
        4,
        6),
  ),
  SimpleProductWidget(
    productModel: ProductModel(
        "https://static-01.daraz.com.np/p/351b2acfb69381c3b7e3559251de9769.jpg",
        "Men's watch ",
        3999,
        0,
        "001A",
        "King",
        "Z001",
        4,
        6),
  ),
];


  // List<Widget> testChildren = [
  //   SimpleProductWidget(
  //     url:
  //         "https://static-01.daraz.com.np/p/94c10ac31975edbf245219262ad9f946.jpg",
  //   ),
  //   SimpleProductWidget(
  //     url:
  //         "https://static-01.daraz.com.np/p/acbe5de23f18b3c6c3e339372385da4b.jpg",
  //   ),
  //   SimpleProductWidget(
  //     url:
  //         "https://static-01.daraz.com.np/p/94c10ac31975edbf245219262ad9f946.jpg",
  //   ),
  //   SimpleProductWidget(
  //     url:
  //         "https://static-01.daraz.com.np/p/d138447378bd6d2a5758304d754e533e.jpg",
  //   ),
  // ];