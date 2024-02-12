import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';

void Start() {
  runApp(StartScreen());
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  var rs = RegistrationScreen();
  var ls = LoginScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('                         Giriş Ekranı'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/anamenü.png'), // ana.jpg dosyanızın yolunu ekleyin
            fit: BoxFit.cover,
          ),
        ),
        width: 410, // Özel genişlik
        height: 600, // Özel yükseklik
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => rs),
                  );
                },
                child: Text(' Kayıt Ol '),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ls),
                  );
                },
                child: Text(' Giriş Yap '),
              ),
              SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt Ekranı'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Giriş ekranına geri dön
              },
              child: Text('Geri Dön'),
            ),
          ],
        ),
      ),
    );
  }
}
