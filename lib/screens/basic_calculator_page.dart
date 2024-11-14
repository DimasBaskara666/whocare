import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _currentNumber = '0';
  String _operation = '';
  String _firstNumber = '';
  bool _isNewNumber = true;

  void _onNumberPressed(String number) {
    setState(() {
      if (_isNewNumber) {
        _currentNumber = number;
        _isNewNumber = false;
      } else {
        _currentNumber = _currentNumber + number;
      }
    });
  }

  void _onOperationPressed(String operation) {
    setState(() {
      if (_operation.isEmpty) {
        _firstNumber = _currentNumber;
        _operation = operation;
        _isNewNumber = true;
      } else {
        // Jika sudah ada operasi sebelumnya, hitung dulu
        _calculateResult();
        _firstNumber = _currentNumber;
        _operation = operation;
        _isNewNumber = true;
      }
    });
  }

  void _calculateResult() {
    if (_firstNumber.isEmpty || _operation.isEmpty) return;

    double num1 = double.parse(_firstNumber);
    double num2 = double.parse(_currentNumber);
    double result = 0;

    switch (_operation) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '×':
        result = num1 * num2;
        break;
      case '÷':
        result = num1 / num2;
        break;
    }

    setState(() {
      _currentNumber = result.toString();
      if (_currentNumber.endsWith('.0')) {
        _currentNumber = _currentNumber.substring(0, _currentNumber.length - 2);
      }
      _operation = '';
      _firstNumber = '';
      _isNewNumber = true;
    });
  }

  void _onClear() {
    setState(() {
      _currentNumber = '0';
      _operation = '';
      _firstNumber = '';
      _isNewNumber = true;
    });
  }

  void _onDecimalPoint() {
    if (!_currentNumber.contains('.')) {
      setState(() {
        _currentNumber = '$_currentNumber.';
      });
    }
  }

  Widget _buildButton(String text, {Color? backgroundColor, Color? textColor}) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.blue.shade400,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (text == 'C') {
              _onClear();
            } else if (text == '.') {
              _onDecimalPoint();
            } else if (text == '=') {
              _calculateResult();
            } else if (['+', '-', '×', '÷'].contains(text)) {
              _onOperationPressed(text);
            } else {
              _onNumberPressed(text);
            }
          },
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Display
              Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _operation.isNotEmpty ? _firstNumber : '',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            _operation,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _currentNumber,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Keypad
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _buildButton('C', textColor: Colors.black),
                  _buildButton('()', textColor: Colors.black),
                  _buildButton('%', textColor: Colors.black),
                  _buildButton('÷', textColor: Colors.black),
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('×', textColor: Colors.black),
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('-', textColor: Colors.black),
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('+', textColor: Colors.black),
                  _buildButton('00'),
                  _buildButton('0'),
                  _buildButton('.'),
                  _buildButton('=', backgroundColor: Colors.blue.shade600),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
