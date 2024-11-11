import 'package:flutter/material.dart';

class CalorieCalculatorPage extends StatefulWidget {
  const CalorieCalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalorieCalculatorPage> createState() => _CalorieCalculatorPageState();
}

class _CalorieCalculatorPageState extends State<CalorieCalculatorPage> {
  final _formKey = GlobalKey<FormState>();

  // Input controllers
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  // Form values
  String _selectedGender = 'Male';
  String _selectedActivityLevel = 'Moderate';
  double _calories = 0.0;

  // Activity levels with multipliers
  final Map<String, double> _activityLevels = {
    'Sedentary (little or no exercise)': 1.2,
    'Light (light exercise/sports 1-3 days/week)': 1.375,
    'Moderate (moderate exercise/sports 3-5 days/week)': 1.55,
    'Very Active (hard exercise/sports 6-7 days a week)': 1.725,
    'Super Active (very hard exercise/physical job)': 1.9,
  };

  // Calculate daily caloric needs based on the Harris-Benedict Equation
  void _calculateCalories() {
    if (_formKey.currentState!.validate()) {
      int age = int.parse(_ageController.text);
      double height = double.parse(_heightController.text);
      double weight = double.parse(_weightController.text);
      double bmr;

      if (_selectedGender == 'Male') {
        // BMR calculation for men
        bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
      } else {
        // BMR calculation for women
        bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
      }

      // Adjust BMR by activity level
      double activityMultiplier = _activityLevels[_selectedActivityLevel]!;
      setState(() {
        _calories = bmr * activityMultiplier;
      });
    }
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie Calculator'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Age input
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Height input
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(
                  labelText: 'Height (cm)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Weight input
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(
                  labelText: 'Weight (kg)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Gender selection
              const Text('Gender'),
              Row(
                children: [
                  Radio<String>(
                    value: 'Male',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  const Text('Male'),
                  Radio<String>(
                    value: 'Female',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  const Text('Female'),
                ],
              ),
              const SizedBox(height: 16),

              // Activity level selection
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Activity Level',
                  border: OutlineInputBorder(),
                ),
                value: _selectedActivityLevel,
                items: _activityLevels.keys.map((String level) {
                  return DropdownMenuItem(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedActivityLevel = newValue!;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Calculate button
              ElevatedButton(
                onPressed: _calculateCalories,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Calculate Calories',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 24),

              // Display the calculated calories
              if (_calories > 0)
                Text(
                  'Your daily caloric needs: ${_calories.toStringAsFixed(2)} kcal',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
