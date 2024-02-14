import 'package:GDSC_SC_Project/InfoPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainMenu());
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ana Menü',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> _foods = [
    {'name': 'Elma', 'calorie': 52},
    {'name': 'Armut', 'calorie': 57},
    {'name': 'Cips', 'calorie': 536},
    {'name': 'Çikolata', 'calorie': 546},
  ];

  int _selectedCalorie = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/resimler/anamenu2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            '',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text('Hoş Geldiniz'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: InkWell(
                onTap: () {
                  // "Ayşe/Ali" yazısına tıklandığında yapılacak işlemler
                  print('Ayşe/Ali yazısına tıklandı.');
                  Navigator.pop(context); // Yan menüyü kapat
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InfoPage()),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/erkek.jpg"),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Ayşe/Ali',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.fastfood),
              title: Text('Hangi yemek kaç kalori'),
              onTap: () {
                Navigator.pop(context);
                _showBottomSheet();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() {
    _scaffoldKey.currentState!
        .showBottomSheet((context) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${_selectedCalorie} kalori',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _foods.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _getKg(context, _foods[index]['name']);
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          _foods[index]['name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        })
        .closed
        .then((value) {
          setState(() {
            _selectedCalorie = 0;
          });
        });
  }

  void _getKg(BuildContext context, String foodName) {
    TextEditingController _kgController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yemek Miktarı (kg)'),
          content: TextField(
            controller: _kgController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Kilogram cinsinden giriniz'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Onayla'),
              onPressed: () {
                double kg = double.tryParse(_kgController.text) ?? 0;
                Navigator.of(context).pop();
                _calculateCalorie(kg, foodName);
              },
            ),
          ],
        );
      },
    );
  }

  void _calculateCalorie(double kg, String foodName) {
    setState(() {
      if (kg > 0) {
        _selectedCalorie = (kg *
                _foods
                    .firstWhere((food) => food['name'] == foodName)['calorie'])
            .toInt();
      }
    });
  }
}
