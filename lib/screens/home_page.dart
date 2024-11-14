import 'package:flutter/material.dart';
import 'temperature_conversion_page.dart';
import 'basic_calculator_page.dart';
import 'currency_conversion_page.dart';
import 'calorie_calculator_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'An ounce of prevention is worth a pound of cure.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  BoxedServiceTile(
                    icon: Icons.thermostat,
                    label: 'Temp Conversion',
                    color: Colors.blue.shade200,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TemperatureConversionPage(),
                        ),
                      );
                    },
                  ),
                  BoxedServiceTile(
                    icon: Icons.calculate,
                    label: 'Calculator',
                    color: Colors.blue.shade200,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalculatorPage()),
                      ); // Navigate to Calculator page
                    },
                  ),
                  BoxedServiceTile(
                    icon: Icons.currency_exchange,
                    label: 'Currency\nConversion',
                    color: Colors.blue.shade200,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CurrencyConversionPage()),
                      ); // Navigate to Currency Conversion page
                    },
                  ),
                  BoxedServiceTile(
                    icon: Icons.calculate_outlined,
                    label: 'Calorie\nCalculator',
                    color: Colors.blue.shade200,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CalorieCalculatorPage()), // Add Calorie Calculator Button
                      ); // Navigate to Calorie Calculator page
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BoxedServiceTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color; // Add a color property

  const BoxedServiceTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = Colors.white, // Default color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color, // Use the color property
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32),
            SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
