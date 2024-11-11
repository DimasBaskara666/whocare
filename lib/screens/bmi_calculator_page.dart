import 'package:flutter/material.dart';
import 'bmi_result_page.dart';

class BMICalculatorPage extends StatefulWidget {
  const BMICalculatorPage({Key? key}) : super(key: key);

  @override
  State<BMICalculatorPage> createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  String selectedGender = 'female';
  int feet = 5;
  int inches = 3;
  int weight = 110;
  int age = 26;
  String weightUnit = 'lbs';

  void convertWeight() {
    if (weightUnit == 'lbs') {
      weight = (weight * 2.205).round();
    } else {
      weight = (weight / 2.205).round();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Gender Selection
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedGender = 'male'),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: selectedGender == 'male'
                            ? Colors.blue.withOpacity(0.1)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selectedGender == 'male'
                              ? Colors.blue
                              : Colors.transparent,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.male, size: 40),
                          Text('Male'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedGender = 'female'),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: selectedGender == 'female'
                            ? Colors.blue.withOpacity(0.1)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selectedGender == 'female'
                              ? Colors.blue
                              : Colors.transparent,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.female, size: 40),
                          Text('Female'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Height Input
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Height (inch)',
                      style: TextStyle(color: Colors.grey[600])),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_drop_up),
                              onPressed: () {
                                if (feet < 8) {
                                  setState(() => feet++);
                                }
                              },
                            ),
                            Text('$feet', style: TextStyle(fontSize: 24)),
                            IconButton(
                              icon: Icon(Icons.arrow_drop_down),
                              onPressed: () {
                                if (feet > 4) {
                                  setState(() => feet--);
                                }
                              },
                            ),
                            Text('ft'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_drop_up),
                              onPressed: () {
                                if (inches < 11) {
                                  setState(() => inches++);
                                }
                              },
                            ),
                            Text('$inches', style: TextStyle(fontSize: 24)),
                            IconButton(
                              icon: Icon(Icons.arrow_drop_down),
                              onPressed: () {
                                if (inches > 0) {
                                  setState(() => inches--);
                                }
                              },
                            ),
                            Text('in'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      '${feet} feet ${inches} inches (${(feet * 30.48 + inches * 2.54).round()} cm)',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Weight and Age
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Weight',
                                style: TextStyle(color: Colors.grey[600])),
                            const SizedBox(width: 8),
                            DropdownButton<String>(
                              value: weightUnit,
                              items: [
                                DropdownMenuItem(
                                  value: 'lbs',
                                  child: Text('lbs'),
                                ),
                                DropdownMenuItem(
                                  value: 'kg',
                                  child: Text('kg'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value != weightUnit) {
                                  setState(() {
                                    weightUnit = value!;
                                    convertWeight();
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        Text('$weight $weightUnit',
                            style: TextStyle(fontSize: 24)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                if (weight > 0) {
                                  setState(() => weight--);
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                setState(() => weight++);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text('Age', style: TextStyle(color: Colors.grey[600])),
                        Text('$age', style: TextStyle(fontSize: 24)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                if (age > 0) {
                                  setState(() => age--);
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                setState(() => age++);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Calculate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  double heightInMeters = (feet * 30.48 + inches * 2.54) / 100;
                  double weightInKg = weight * 0.453592;
                  double bmi = weightInKg / (heightInMeters * heightInMeters);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BMIResultPage(bmi: bmi),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Calculate BMI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
