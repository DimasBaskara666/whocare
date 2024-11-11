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
                    icon: Icons.add_circle_outline,
                    label: 'Temp Conversion',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TemperatureConversionPage()),
                      ); // Navigate to Additions & Remodels page
                    },
                  ),
                  BoxedServiceTile(
                    icon: Icons.cleaning_services,
                    label: 'Cleaning',
                    onTap: () {
                      // Navigate to Cleaning page
                    },
                  ),
                  BoxedServiceTile(
                    icon: Icons.color_lens,
                    label: 'Painting',
                    onTap: () {
                      // Navigate to Painting page
                    },
                  ),
                  BoxedServiceTile(
                    icon: Icons.ac_unit,
                    label: 'Heating',
                    onTap: () {
                      // Navigate to Heating page
                    },
                  ),
                  BoxedServiceTile(
                    icon: Icons.plumbing,
                    label: 'Plumbing',
                    onTap: () {
                      // Navigate to Plumbing page
                    },
                  ),
                  BoxedServiceTile(
                    icon: Icons.electrical_services,
                    label: 'Electrical',
                    onTap: () {
                      // Navigate to Electrical page
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to Home Care Scheduler page
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time),
                  SizedBox(width: 8),
                  Text('Home Care Scheduler'),
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

  const BoxedServiceTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
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
