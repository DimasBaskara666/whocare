import 'package:flutter/material.dart';
import 'dart:async';
import 'package:whocare/root_navigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Menunda splash screen selama 5 detik, lalu navigasi ke RootNavigator
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RootNavigator()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor:
          Color.fromRGBO(0, 0, 0, 1), // Warna background sesuai dengan tema
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Judul aplikasi
            Text(
              'WhoCare',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            // Foto Placeholder (ganti dengan foto Anda sendiri jika diperlukan)
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(
                  'assets/dimas.jpg'), // ganti dengan foto Anda di folder assets
            ),
            SizedBox(height: 10),
            // NIM dan Nama
            Text(
              'NIM: 152022044', // Ganti dengan NIM Anda
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            Text(
              'Nama: Dimas Bratakusumah', // Ganti dengan Nama Anda
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
