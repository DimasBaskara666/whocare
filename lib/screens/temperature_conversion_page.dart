import 'package:flutter/material.dart';

class TemperatureConversionPage extends StatefulWidget {
  @override
  _TemperatureConversionPageState createState() =>
      _TemperatureConversionPageState();
}

class _TemperatureConversionPageState extends State<TemperatureConversionPage> {
  final TextEditingController celsiusController = TextEditingController();
  double fahrenheit = 0;

  void convertTemperature() {
    double celsius = double.parse(celsiusController.text);
    setState(() {
      fahrenheit = (celsius * 9 / 5) + 32;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Suhu'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: celsiusController,
              decoration:
                  InputDecoration(labelText: 'Masukkan Suhu dalam Celsius'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: convertTemperature,
              child: Text('Konversi ke Fahrenheit'),
            ),
            SizedBox(height: 20),
            Text(
              'Hasil: ${fahrenheit.toStringAsFixed(2)} °F',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
