import 'package:flutter/material.dart';
import 'fotodegis.dart';

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
    'name': '',
    'age': 0,
    'weight': 0.0,
    'height': 0.0,
    'gender': '', // Cinsiyet bilgisini ekledik
  };

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
                _buildInputField("İsim", nameController),
                _buildInputField("Yaş", ageController),
                _buildInputField("Kilo", weightController),
                _buildInputField("Boy", heightController),
                _buildGenderField(), // Cinsiyet gösterilecek alan
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

  Widget _buildGenderField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          _showGenderSelection(); // Cinsiyet seçimi popup'ını göster
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
                "Cinsiyet: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                userData['gender'].isEmpty
                    ? 'Belirtilmemiş'
                    : userData['gender'],
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calculateBMR() {
    int age = userData['age'];
    double weight = userData['weight'];
    double height = userData['height'];
    String gender = userData['gender'];

    // Cinsiyete göre BMR formülünü uygula
    if (gender == 'Erkek') {
      bmr = 10 * weight + 6.25 * height - 5 * age + 5;
    } else if (gender == 'Kadın') {
      bmr = 10 * weight + 6.25 * height - 5 * age - 161;
    } else {
      // Cinsiyet belirtilmemişse bir hata durumu olabilir
      print("Hata: Cinsiyet belirtilmemiş.");
      bmr = 0.0;
    }

    setState(() {});
  }

  void saveAndCalculateBMR() {
    int age = int.tryParse(userData['age'].toString()) ?? 0;
    double weight = double.tryParse(userData['weight'].toString()) ?? 0.0;
    double height = double.tryParse(userData['height'].toString()) ?? 0.0;

    userData['name'] = nameController.text;
    userData['age'] = age;
    userData['weight'] = weight;
    userData['height'] = height;

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
                Navigator.pop(context, 'Erkek'); // 'Erkek' cinsiyeti seçildi
              },
              child: Text('Erkek'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Kadın'); // 'Kadın' cinsiyeti seçildi
              },
              child: Text('Kadın'),
            ),
          ],
        ),
      ),
    );

    if (result != null) {
      userData['gender'] = result;
      setState(() {});
    }
  }
}
