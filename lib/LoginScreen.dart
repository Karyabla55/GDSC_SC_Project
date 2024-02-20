import 'package:GDSC_SC_Project/MainMenu.dart';
import 'package:GDSC_SC_Project/User.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var mm = MainMenu();
  TextEditingController _UserNameController = TextEditingController();
  TextEditingController _UserPasswordController = TextEditingController();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Giriş'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/kayitolmenu.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              TextField(
                controller: _UserNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kullanıcı Adı',
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _UserPasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Şifre',
                  labelStyle: TextStyle(color: Colors.white70),
                ),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {
                  print(User().UserName);
                  print(User().Password);
                  print(_UserNameController);
                  print(_UserPasswordController);
                  if (_UserNameController.text == User().UserName &&
                      _UserPasswordController.text == User().Password) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => mm),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Hata'),
                          content: Text('Girdiğiniz bilgiler hatalıdır.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Uyarıyı kapat
                              },
                              child: Text('Tamam'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Giriş Yap',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
