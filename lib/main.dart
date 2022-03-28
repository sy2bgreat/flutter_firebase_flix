import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_movies/screen/home_screen.dart';
import 'package:flutter_firebase_movies/screen/profile_screen.dart';
import 'package:flutter_firebase_movies/screen/search_screen.dart';
import 'package:flutter_firebase_movies/widget/bottom_bar.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TabController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Bet Flix",
        theme:
            ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: TabBarView(
              children: [const Home(), Search(), Container(), Profile()],
              physics: const NeverScrollableScrollPhysics(),
            ),
            bottomNavigationBar: const Bottom(),
          ),
        ));
  }
}
