import 'package:GDSC_SC_Project/User.dart';
import 'package:flutter/material.dart';

class Exercise {
  final String name;
  final double caloriesBurned;

  Exercise({required this.name, required this.caloriesBurned});
}

class ExercisePage extends StatelessWidget {
  final List<Exercise> exercises = [
    Exercise(name: 'Koşu (8km/h)', caloriesBurned: User().Weight * 1 * 8.0),
    Exercise(
        name: 'Yürüyüş (Orta Tempo)', caloriesBurned: User().Weight * 1 * 3.5),
    Exercise(
        name: 'Bisiklet (Orta Tempo)', caloriesBurned: User().Weight * 1 * 6.0),
    Exercise(
        name: 'Yüzme (Orta Tempo)', caloriesBurned: User().Weight * 1 * 7.0),
    Exercise(
        name: "Ağırlık Antrenmanı (Orta Derece)",
        caloriesBurned: User().Weight * 1 * 6.0)
    // Diğer egzersizleri buraya ekleyin
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Egzersizler'),
      ),
      body: Container(
        color: Colors.grey[200], // Arka plan rengi
        padding: EdgeInsets.all(16.0), // Kenar boşluğu
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Egzersizler Listesi \n(Ortalama 1 Saat)',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0), // Boşluk ekleyin
            Expanded(
              child: ListView.separated(
                itemCount: exercises.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(), // Ayırıcı ekleyin
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  return ListTile(
                    title: Text(
                      exercise.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text('${exercise.caloriesBurned} kalori'),
                    onTap: () {
                      // Egzersize tıklandığında yapılacak işlemler
                      // Örneğin: Egzersiz detaylarını gösteren bir sayfaya yönlendirme
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ExercisePage(),
  ));
}
