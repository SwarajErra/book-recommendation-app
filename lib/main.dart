import 'package:book_recommendation_app/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  void onTap(menuItem) {
    switch (menuItem) {
      case 'item1':
        print('item1 clicked');
        break;
      case 'item2':
        print('item2 clicked');
        break;
      case 'item3':
        print('item3 clicked');
        break;
    }
  }



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var menuItems = <String>['item1', 'item2', 'item3'];
    return MaterialApp(
      title: 'Book Reccomendation Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            PopupMenuButton<String>(
                onSelected: onTap,
                itemBuilder: (BuildContext context) {
                  return menuItems.map((String choice) {
                    return PopupMenuItem<String>(
                      child: Text(choice),
                      value: choice,
                    );
                  }).toList();
                })
          ],
        ),
        body: searchBar(),
      ),
      // home: const MyHomePage(title: 'Book Reccomendation Demo Home Page'),
    );
  }
}
