// import 'package:book_recommendation_app/home.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// import 'package:book_recommendation_app/screens/screens.dart';
//
// Future<void> main() async {
//
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//
//
//   void onTap(menuItem) {
//     switch (menuItem) {
//       case 'item1':
//         print('item1 clicked');
//         break;
//       case 'item2':
//         print('item2 clicked');
//         break;
//       case 'item3':
//         print('item3 clicked');
//         break;
//     }
//   }
//
//
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     var menuItems = <String>['item1', 'item2', 'item3'];
//     return MaterialApp(
//       title: 'Book Reccomendation Demo',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Home'),
//           actions: <Widget>[
//             PopupMenuButton<String>(
//                 onSelected: onTap,
//                 itemBuilder: (BuildContext context) {
//                   return menuItems.map((String choice) {
//                     return PopupMenuItem<String>(
//                       child: Text(choice),
//                       value: choice,
//                     );
//                   }).toList();
//                 })
//           ],
//         ),
//         body: searchBar(),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               const DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                 ),
//                 child: Text('Drawer Header'),
//               ),
//               ListTile(
//                 title: const Text('Item 1'),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: const Text('Item 2'),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       // home: const MyHomePage(title: 'Book Reccomendation Demo Home Page'),
//     );
//   }
// }
import 'package:book_recommendation_app/Views/Home.dart';
import 'package:book_recommendation_app/Views/Profile.dart';
import 'package:book_recommendation_app/Views/register.dart';
import 'package:book_recommendation_app/Views/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}

