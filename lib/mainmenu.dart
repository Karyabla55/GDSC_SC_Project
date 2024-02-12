import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ana Sayfa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Sayfa'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Yan Menü',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Profil'),
              onTap: () {

                // Profil'e tıklandığında yapılacak işlemler
                print('Profil seçildi.');
                Navigator.pop(context);
              },
            ),

            ListTile(
              title: Text('Diyet'),
              onTap: () {
                // Diyet'e tıklandığında yapılacak işlemler
                print('Diyet seçildi.');
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiyetPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/resimler/pexels-photo-10742586.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            'Merhaba, Ana Sayfa!',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
class DiyetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diyet'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'Kilo Alma',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20), // Boyutu 20 olarak ayarla
            ),
            onTap: () {
              // Kilo Alma'ya tıklandığında yapılacak işlemler
              print('Kilo Alma seçildi.');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'Kilo Verme',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20), // Boyutu 20 olarak ayarla
            ),
            onTap: () {
              // Kilo Verme'ye tıklandığında yapılacak işlemler
              print('Kilo Verme seçildi.');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'Kilo Koruma',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20), // Boyutu 20 olarak ayarla
            ),
            onTap: () {
              // Kilo Koruma'ye tıklandığında yapılacak işlemler
              print('Kilo Koruma seçildi.');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
