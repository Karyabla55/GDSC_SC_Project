import 'package:flutter/material.dart';
import 'fotodegis.dart';
import 'User.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  Map<String, dynamic> userData = {
    'isim': User().Name,
    'yas': User().Age,
    'kilo': User().Weight,
    'boy': User().Height,
    'cinsiyet': User().Gender,
  };

  void initState() {
    super.initState();
    nameController.text = userData['isim'] ?? '';
    ageController.text = userData['yas']?.toString() ?? '';
    weightController.text = userData['kilo']?.toString() ?? '';
    heightController.text = userData['boy']?.toString() ?? '';
  }

  double bmr = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bilgileriniz'),
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
                            MaterialPageRoute(
                                builder: (context) => FotoDegisScreen()),
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
                _buildInputField("isim", nameController),
                _buildInputField("yas", ageController),
                _buildInputField("kilo", weightController),
                _buildInputField("boy", heightController),
                _buildGenderField(),
                _buildInfoField("BMR", bmr.toString()),
                ElevatedButton(
                  onPressed: () {
                    saveAndCalculateBMR();
                  },
                  child: Text('Save'),
                ),
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

  Widget _buildGenderField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          _showGenderSelection();
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Gender: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                userData['cinsiyet'].isEmpty
                    ? 'Undefined'
                    : userData['cinsiyet'],
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calculateBMR() {
    int age = userData['yas'];
    double weight = userData['kilo'];
    int height = userData['boy'];
    String gender = userData['cinsiyet'];

    if (gender == 'Male') {
      bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else if (gender == 'Woman') {
      bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    } else {
      print("Error: Undefined.");
      bmr = 0.0;
    }

    setState(() {});
  }

  void saveAndCalculateBMR() {
    int age = int.tryParse(userData['yas'].toString()) ?? 0;
    double weight = double.tryParse(userData['kilo'].toString()) ?? 0.0;
    int height = int.tryParse(userData['boy'].toString()) ?? 0;

    userData['isim'] = nameController.text;
    User().Name = nameController.text;
    userData['yas'] = age;
    User().Age = age;
    userData['kilo'] = weight;
    User().Weight = weight;
    userData['boy'] = height;
    User().Height = height;

    calculateBMR();
  }

  Future<void> _showGenderSelection() async {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cinsiyet Seçimi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Male'); // 'Erkek' cinsiyeti seçildi
              },
              child: Text('Male'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Woman'); // 'Kadın' cinsiyeti seçildi
              },
              child: Text('Woman'),
            ),
          ],
        ),
      ),
    );

    if (result != null) {
      userData['cinsiyet'] = result;
      setState(() {});
    }
  }
}

void main() {
  runApp(InfoPage());
}
