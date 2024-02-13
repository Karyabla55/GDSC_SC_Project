import 'package:flutter/material.dart';

class FotoDegisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fotoğraf Değiştir'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // TODO: Galeriden fotoğraf seçme işlemi
              },
              child: Text('Galeriden Seç'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Kameradan fotoğraf çekme işlemi
              },
              child: Text('Kameradan Çek'),
            ),
          ],
        ),
      ),
    );
  }
}
