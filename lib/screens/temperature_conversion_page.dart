import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:math_expressions/math_expressions.dart';

class TemperatureConversionPage extends StatefulWidget {
  @override
  _TemperatureConversionPageState createState() =>
      _TemperatureConversionPageState();
}

class _TemperatureConversionPageState extends State<TemperatureConversionPage> {
  String selectedUnit = 'celsius';
  String inputValue = '';
  Map<String, String> conversionResults = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Conversion'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 24.0), // Tambahkan padding di sini
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade400,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  blurRadius: 12.0,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildUnitButton(
                      icon: FontAwesomeIcons.temperatureLow,
                      unit: 'celsius',
                    ),
                    SizedBox(width: 16.0),
                    _buildUnitButton(
                      icon: FontAwesomeIcons.temperatureHigh,
                      unit: 'fahrenheit',
                    ),
                    SizedBox(width: 16.0),
                    _buildUnitButton(
                      // ignore: deprecated_member_use
                      icon: FontAwesomeIcons.thermometerEmpty,
                      unit: 'kelvin',
                    ),
                  ],
                ),
                SizedBox(height: 24.0),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      inputValue = value;
                      _updateConversions();
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Temperature',
                    hintStyle: TextStyle(
                      decorationColor: Colors.grey.shade700,
                      // color: Colors.grey.shade500,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.blue.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.0),
                _buildConversionTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUnitButton({
    required IconData icon,
    required String unit,
  }) {
    bool isSelected = selectedUnit == unit;
    return GestureDetector(
      onTap: () => setState(() {
        selectedUnit = unit;
        _updateConversions();
      }),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32.0,
            color: isSelected ? Colors.black : Colors.white,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            unit.toUpperCase(),
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _updateConversions() {
    if (inputValue.isEmpty) {
      conversionResults.clear();
      return;
    }

    final inputTemperature = double.tryParse(inputValue);
    if (inputTemperature == null) {
      conversionResults.clear();
      return;
    }

    setState(() {
      switch (selectedUnit) {
        case 'celsius':
          conversionResults = {
            'Celsius to Fahrenheit':
                (inputTemperature * 9 / 5 + 32).toStringAsFixed(2),
            'Celsius to Kelvin': (inputTemperature + 273.15).toStringAsFixed(2),
          };
          break;
        case 'fahrenheit':
          conversionResults = {
            'Fahrenheit to Celsius':
                ((inputTemperature - 32) * 5 / 9).toStringAsFixed(2),
            'Fahrenheit to Kelvin':
                ((inputTemperature - 32) * 5 / 9 + 273.15).toStringAsFixed(2),
          };
          break;
        case 'kelvin':
          conversionResults = {
            'Kelvin to Celsius': (inputTemperature - 273.15).toStringAsFixed(2),
            'Kelvin to Fahrenheit':
                ((inputTemperature - 273.15) * 9 / 5 + 32).toStringAsFixed(2),
          };
          break;
      }
    });
  }

  String _convertTemperature(double value, String formula) {
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(formula);
      ContextModel context = ContextModel()
        ..bindVariable(Variable('x'), Number(value));
      return expression
          .evaluate(EvaluationType.REAL, context)
          .toStringAsFixed(2);
    } catch (e) {
      return '-';
    }
  }

  Widget _buildConversionTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Conversion Results',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.0),
        ...conversionResults.entries.map((entry) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.key,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey.shade200,
                  ),
                ),
                Text(
                  '${entry.value} °${entry.key.split(" to ").last[0]}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
