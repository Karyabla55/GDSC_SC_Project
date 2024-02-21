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

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  var rs = RegistrationScreen();
  var ls = LoginScreen();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('                 To a healthy life'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/anamenü.png'), // ana.jpg dosyanızın yolunu ekleyin
            fit: BoxFit.cover,
          ),
        ),
        /*
        width: 410, // Özel genişlik
        height: 600, // Özel yükseklik
        */
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
                child: Text(' Register '),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ls),
                  );
                },
                child: Text(' Log In '),
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
        title: Text('Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Giriş ekranına geri dön
              },
              child: Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}
