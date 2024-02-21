import 'package:GDSC_SC_Project/ExercisesPage.dart';
import 'package:GDSC_SC_Project/InfoPage.dart';
import 'package:GDSC_SC_Project/User.dart';
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
    {'name': 'Apple', 'calorie': 52},
    {'name': 'Pear', 'calorie': 57},
    {'name': 'Chips', 'calorie': 536},
    {'name': 'Chocolate', 'calorie': 546},
    {'name': 'Bread', 'calorie': 264},
  ];

  double weight = User().Weight;

  int _selectedCalorie = 0;

  @override
  Widget build(BuildContext context) {
    String Name = User().Name;
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 220),
            Text(
              'Your current weight: $weight',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 280),
            ElevatedButton(
              onPressed: () {
                // Navigator ile yeni sayfaya geçiş yapma
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration:
                        Duration(milliseconds: 500), // Geçiş süresi
                    transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secAnimation,
                        Widget child) {
                      // Sayfanın aşağıdan yukarı kayması için AlignTransition kullanılır
                      return AlignTransition(
                        alignment: Tween<Alignment>(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                        ).animate(animation),
                        child: child,
                      );
                    },
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secAnimation) {
                      // Açılacak olan sayfa burada belirtilir
                      return ExercisePage();
                    },
                  ),
                );
              },
              child: Text('Exercises'),
            ),
          ]),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text('Welcome'),
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
                      'User Name:${Name}',
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
              title: Text('Which food has how many calories?'),
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
                  '${_selectedCalorie} Calorie',
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
          title: Text('How many'),
          content: TextField(
            controller: _kgController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'enter quantity'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                int quantity = int.tryParse(_kgController.text) ?? 0;
                Navigator.of(context).pop();
                _calculateCalorie(quantity, foodName);
              },
            ),
          ],
        );
      },
    );
  }

  void _calculateCalorie(int quantity, String foodName) {
    setState(() {
      if (quantity > 0) {
        _selectedCalorie = (quantity *
                _foods
                    .firstWhere((food) => food['name'] == foodName)['calorie'])
            .toInt();
      }
    });
  }
}
