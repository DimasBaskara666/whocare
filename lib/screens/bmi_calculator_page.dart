import 'package:flutter/material.dart';
import 'bmi_result_page.dart';

class BMICalculatorPage extends StatefulWidget {
  @override
  _BMICalculatorPageState createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  double _bmi = 0;
  String _category = '';

  void calculateBMI() {
    double height = double.parse(heightController.text) / 100;
    double weight = double.parse(weightController.text);
    setState(() {
      _bmi = weight / (height * height);
      if (_bmi < 18.5) {
        _category = 'Underweight';
      } else if (_bmi < 24.9) {
        _category = 'Normal weight';
      } else {
        _category = 'Overweight';
      }
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BMIResultPage(bmi: _bmi, category: _category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Input Data BMI')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: 'Tinggi (cm)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: 'Berat (kg)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text('Hitung BMI'),
            ),
          ],
        ),
      ),
    );
  }
}
