import 'package:flutter/material.dart';

class CurrencyConversionPage extends StatefulWidget {
  @override
  _CurrencyConversionPageState createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
  final TextEditingController usdController = TextEditingController();
  double idr = 0;

  void convertCurrency() {
    double usd = double.parse(usdController.text);
    setState(() {
      idr = usd * 15000; // Contoh konversi USD ke IDR
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Mata Uang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usdController,
              decoration:
                  InputDecoration(labelText: 'Masukkan jumlah dalam USD'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: convertCurrency,
              child: Text('Konversi ke IDR'),
            ),
            SizedBox(height: 20),
            Text(
              'Hasil: Rp ${idr.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
