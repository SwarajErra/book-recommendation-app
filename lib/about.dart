import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  var menuItems = <String>['item1', 'item2', 'item3'];

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('About us'),
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
      body: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          Image(
            image: AssetImage('Assets/images/blurb.png'),
            height: 60,
          ),
          SizedBox(
            height: 60,
          ),
          Text(
            'The Blurb is largest platform which suggests the best books to users based on their interests. Taking advantage of vast collection across the internet, we suggest the best and fine books to users. We offer descriptions and reviews. We also offer editor recommendations and customer reviews on hundreds of thousands of titles.',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Contact us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Email:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'blurbadministration@gmail.com',
                  style: TextStyle(
                      fontSize: 20, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Address:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  '358,geller,Montreal,H1A3W2,CA',
                  style: TextStyle(
                      fontSize: 20, decoration: TextDecoration.underline),
                ),
              ),
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
