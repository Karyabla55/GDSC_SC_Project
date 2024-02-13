import 'package:flutter/material.dart';
import 'fotodegis.dart';

class EmptyPage extends StatefulWidget {
  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  Map<String, dynamic> userData = {
    'name': '',
    'age': 0,
    'weight': 0.0,
    'height': 0.0,
  };

  double bmr = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('                Bilgileriniz'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("assets/erkek.jpg"),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FotoDegisScreen()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _buildInputField("İsim", nameController),
                _buildInputField("Yaş", ageController),
                _buildInputField("Kilo", weightController),
                _buildInputField("Boy", heightController),
                ElevatedButton(
                  onPressed: () {
                    saveAndCalculateBMR();
                  },
                  child: Text('Kaydet'),
                ),
                _buildInfoField("BMR", bmr.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextField(
            controller: controller,
            textAlign: TextAlign.center,
            onChanged: (value) {
              userData[label.toLowerCase()] = value;
            },
            decoration: InputDecoration(
              labelText: '',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  void calculateBMR() {
    int age = int.tryParse(userData['age'].toString()) ?? 0;
    double weight = double.tryParse(userData['weight'].toString()) ?? 0.0;
    double height = double.tryParse(userData['height'].toString()) ?? 0.0;

    if (age != null && weight != null && height != null) {
      bmr = 10 * weight + 6.25 * height - 5 * age + 5;
      setState(() {});
    }
  }



  void saveAndCalculateBMR() {
    int age = int.tryParse(userData['age'].toString()) ?? 0;
    double weight = double.tryParse(userData['weight'].toString()) ?? 0.0;
    double height = double.tryParse(userData['height'].toString()) ?? 0.0;

    print("Age: $age, Weight: $weight, Height: $height");
    userData['name'] = nameController.text;
    userData['age'] = age;
    userData['weight'] = weight;
    userData['height'] = height;

    calculateBMR();
  }
}
