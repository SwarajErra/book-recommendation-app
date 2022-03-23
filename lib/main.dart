import 'package:book_recommendation_app/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:book_recommendation_app/screens/screens.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Reccomendation Demo',
      home: Scaffold(
        body: searchBar(),
      ),
      // home: const MyHomePage(title: 'Book Reccomendation Demo Home Page'),
    );
  }
}
