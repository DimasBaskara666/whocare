import 'package:flutter/material.dart';
import 'temperature_conversion_page.dart';
import 'basic_calculator_page.dart';
// import 'currency_conversion_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TemperatureConversionPage()),
              );
            },
            child: Text('Konversi Suhu'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BasicCalculatorPage()),
              );
            },
            child: Text('Kalkulator Dasar'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => CurrencyConversionPage()),
              // );
            },
            child: Text('Konversi Mata Uang'),
          ),
        ],
      ),
    );
  }
}
