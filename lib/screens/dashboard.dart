import 'package:flutter/material.dart';
// import 'bmi_calculator_page.dart';
// import 'temperature_conversion_page.dart';
// import 'profile_page.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => BMICalculatorPage()),
                // );
              },
              child: Text('Kalkulator BMI'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => TemperatureConversionPage()),
                // );
              },
              child: Text('Konversi Suhu'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ProfilePage()),
                // );
              },
              child: Text('Profil'),
            ),
          ],
        ),
      ),
    );
  }
}
