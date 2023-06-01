import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopme/screens/signin.dart';
import 'package:shopme/state/provider/userdetailsprovider.dart';
import 'package:shopme/utils/colors.dart';
import 'layout/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // web setup (firebase)
    // from firebase add a web app.
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAhVWEK9qUHecReSENysMKyvzRmXMv2HFs",
            authDomain: "deal-mart-69481.firebaseapp.com",
            projectId: "deal-mart-69481",
            storageBucket: "deal-mart-69481.appspot.com",
            messagingSenderId: "329329969096",
            appId: "1:329329969096:web:6ff91cfcfe12c8baad22fd",
            measurementId: "G-BE1XTK0HXY"));
  } else {
    // for android
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // is used to use provider in app.
      providers: [ChangeNotifierProvider(create: (_) => UserDetailsProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Deal Mart",
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        // home: const SigninScreen(),
        // here we use streambuilder for persistent login. which means if user is logged in then it will show the home screen.(no need to login again).
        // home: StreamBuilder(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, AsyncSnapshot<User?> user) {
        //     // if (user.connectionState == ConnectionState.waiting) {
        //     //   return const Center(
        //     //     child: CircularProgressIndicator(
        //     //       color: Colors.orange,
        //     //     ),
        //     //   );
        //     // }
        //     if (user.hasData) {
        //       //  FirebaseAuth.instance.signOut();
        //       // print("uid: ${FirebaseAuth.instance.currentUser!.uid}");
        //       // return const ScreenLayout(); // before.package nav bar

        //       // before results_screen
        //       // very first
        //       // return const BottomNavBar();

        //       // just to check results_screen

        //       // return const ResultsScreen(query: "Dell Laptop");

        //       // Completed this above resultsscreen.

        //       // return const BottomNavBar();

        //       // just to check product screen
        //       // return ProductScreen(
        //       //   productModel: ProductModel(
        //       //       "https://static-01.daraz.com.np/p/351b2acfb69381c3b7e3559251de9769.jpg",
        //       //       "Men's watch ",
        //       //       3999,
        //       //       0,
        //       //       "001A",
        //       //       "King",
        //       //       "Z001",
        //       //       4,
        //       //       6),
        //       // );
        //       // done above product screen.

        //       //again bottomnavbar
        //       // return const BottomNavBar();

        //       // check for sellscreen.
        //       // return const SellScreen();
        //       // sellscreen done.
        //       // Again bottomnavbar
        //       return const BottomNavBar();
        //     } else {
        //       return const SigninScreen();
        //     }
        //   },
        // ),
        home: BottomNavBar(),
      ),
    );
  }
}
