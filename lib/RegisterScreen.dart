import 'package:GDSC_SC_Project/User.dart';
import 'package:GDSC_SC_Project/MainMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(RegisterScreen());
}

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Status bar rengini ayarla
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.blue, // Sistem çubuğunun arkaplan rengi
      statusBarIconBrightness:
          Brightness.light, // Ikon rengi (siyah veya beyaz)
    ));

    return MaterialApp(
      home: RegistrationScreen(),
    );
  }
}

// ignore: must_be_immutable
class RegistrationScreen extends StatelessWidget {
  var mm = MainMenu();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Register'),
        backgroundColor: Colors.white60,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/kayitolmenu.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white70),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  CrateUser();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => mm),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white30),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void CrateUser() {
    User().UserName = _usernameController.text;
    User().Password = _passwordController.text;
    User().Email = _emailController.text;
    User().Age = 0;
    User().Name = " ";
    User().Gender = " ";
    User().Weight = 0;
    User().Height = 0;
  }
}
