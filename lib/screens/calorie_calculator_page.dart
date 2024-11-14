import 'package:flutter/material.dart';

class CalorieCalculatorPage extends StatefulWidget {
  const CalorieCalculatorPage({super.key});

  @override
  State<CalorieCalculatorPage> createState() => _CalorieCalculatorPageState();
}

class _CalorieCalculatorPageState extends State<CalorieCalculatorPage> {
  bool isMetric = false;
  String gender = 'Male';
  int age = 25;
  // Update height variables
  int feet = 5;
  int inches = 5;
  int heightCm = 165;
  // Update weight variables
  int weightLbs = 125;
  int weightKg = 57;
  String activityLevel = 'Sedentary';
  double? result;

  final List<String> activityLevels = [
    'Sedentary',
    'Light Activity',
    'Moderate Activity',
    'Very Active',
    'Extra Active'
  ];

  // Add this method to handle height display
  String getHeightDisplay() {
    if (isMetric) {
      return '$heightCm cm';
    } else {
      return "$feet'$inches\"";
    }
  }

  // Add this method to handle weight display
  String getWeightDisplay() {
    if (isMetric) {
      return '$weightKg kg';
    } else {
      return '$weightLbs lbs';
    }
  }

  double _getActivityMultiplier() {
    switch (activityLevel) {
      case 'Sedentary':
        return 1.2;
      case 'Light Activity':
        return 1.375;
      case 'Moderate Activity':
        return 1.55;
      case 'Very Active':
        return 1.725;
      case 'Extra Active':
        return 1.9;
      default:
        return 1.2;
    }
  }

  double _getHeightInCm() {
    if (isMetric) {
      return heightCm.toDouble();
    } else {
      return (feet * 30.48) + (inches * 2.54);
    }
  }

  void calculateCalories() {
    double bmr;
    final weightInKg = isMetric ? weightKg : (weightLbs * 0.453592);

    if (gender == 'Male') {
      bmr = 88.362 +
          (13.397 * weightInKg) +
          (4.799 * _getHeightInCm()) -
          (5.677 * age);
    } else {
      bmr = 447.593 +
          (9.247 * weightInKg) +
          (3.098 * _getHeightInCm()) -
          (4.330 * age);
    }

    double activityMultiplier = _getActivityMultiplier();
    setState(() {
      result = bmr * activityMultiplier;
    });
  }

  void decreaseHeight() {
    setState(() {
      if (isMetric) {
        if (heightCm > 50) heightCm--;
      } else {
        if (inches > 0) {
          inches--;
        } else if (feet > 0) {
          feet--;
          inches = 11;
        }
      }
    });
  }

  void increaseHeight() {
    setState(() {
      if (isMetric) {
        if (heightCm < 250) heightCm++;
      } else {
        if (inches < 11) {
          inches++;
        } else {
          feet++;
          inches = 0;
        }
      }
    });
  }

  // Update weight controls
  void decreaseWeight() {
    setState(() {
      if (isMetric) {
        if (weightKg > 20) weightKg--;
      } else {
        if (weightLbs > 44) weightLbs--;
      }
    });
  }

  void increaseWeight() {
    setState(() {
      if (isMetric) {
        if (weightKg < 200) weightKg++;
      } else {
        if (weightLbs < 440) weightLbs++;
      }
    });
  }

  // Update unit toggle
  void toggleUnits() {
    setState(() {
      isMetric = !isMetric;
      if (isMetric) {
        // Convert US to metric
        heightCm = ((feet * 30.48) + (inches * 2.54)).round();
        weightKg = (weightLbs * 0.453592).round();
      } else {
        // Convert metric to US
        final totalInches = (heightCm / 2.54).round();
        feet = totalInches ~/ 12;
        inches = totalInches % 12;
        weightLbs = (weightKg * 2.20462).round();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie Calculator'),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Units Toggle
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            !isMetric ? Colors.blue : Colors.grey[300],
                        foregroundColor:
                            !isMetric ? Colors.white : Colors.black,
                      ),
                      onPressed: () => toggleUnits(),
                      child: const Text('U.S. units'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isMetric ? Colors.blue : Colors.grey[300],
                        foregroundColor: isMetric ? Colors.white : Colors.black,
                      ),
                      onPressed: () => toggleUnits(),
                      child: const Text('Metric units'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Gender Selection
              Row(
                children: [
                  const Text('Gender', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          gender == 'Male' ? Colors.blue : Colors.grey[300],
                      foregroundColor:
                          gender == 'Male' ? Colors.white : Colors.black,
                    ),
                    onPressed: () => setState(() => gender = 'Male'),
                    child: const Text('Male'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          gender == 'Female' ? Colors.blue : Colors.grey[300],
                      foregroundColor:
                          gender == 'Female' ? Colors.white : Colors.black,
                    ),
                    onPressed: () => setState(() => gender = 'Female'),
                    child: const Text('Female'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Age Input
              _buildNumberInput(
                label: 'Age',
                value: age.toString(),
                onDecrease: () => setState(() {
                  if (age > 1) age--;
                }),
                onIncrease: () => setState(() {
                  if (age < 120) age++;
                }),
              ),

              // Height Input
              _buildNumberInput(
                label: 'Height',
                value: getHeightDisplay(),
                onDecrease: decreaseHeight,
                onIncrease: increaseHeight,
              ),

              // Weight Input
              _buildNumberInput(
                label: 'Weight',
                value: getWeightDisplay(),
                onDecrease: decreaseWeight,
                onIncrease: increaseWeight,
              ),

              // Activity Level Dropdown
              Row(
                children: [
                  const Text('Activity\nLevel', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        value: activityLevel,
                        isExpanded: true,
                        dropdownColor: Colors.blue,
                        style: const TextStyle(color: Colors.white),
                        underline: Container(),
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.white),
                        onChanged: (String? newValue) {
                          setState(() => activityLevel = newValue!);
                        },
                        items: activityLevels
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Calculate Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    calculateCalories();
                  },
                  child: const Text('Calculate'),
                ),
              ),
              if (result != null) ...[
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Estimated Daily Calories:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${result!.toStringAsFixed(0)} calories',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberInput({
    required String label,
    required String value,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(label, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: onDecrease,
            color: Colors.blue,
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: onIncrease,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
