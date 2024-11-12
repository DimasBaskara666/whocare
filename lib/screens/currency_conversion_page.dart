import 'package:flutter/material.dart';

class CurrencyConversionPage extends StatefulWidget {
  const CurrencyConversionPage({super.key});

  @override
  State<CurrencyConversionPage> createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
  bool _showCurrencyPicker = false;
  bool _selectingFromCurrency = true;
  String _amount = "0";
  String _fromCurrency = "€";
  String _toCurrency = "\$";

  final List<String> _currencies = [
    "€",
    "\$",
    "£",
    "¥",
    "₪",
    "₩",
    "₦",
    "₫",
    "₭",
    "₮",
    "₱",
    "¢",
    "₹",
    "৳",
    "Rp"
  ];

  final Map<String, double> _exchangeRatesToUSD = {
    "€": 1.1,
    "\$": 1.0,
    "£": 1.3,
    "¥": 0.007,
    "₪": 0.3,
    "₩": 0.00085,
    "₦": 0.0024,
    "₫": 0.000043,
    "₭": 0.000096,
    "₮": 0.00035,
    "₱": 0.02,
    "¢": 0.01,
    "₹": 0.012,
    "৳": 0.012,
    "Rp": 0.00007 // Added IDR (Indonesian Rupiah)
  };

  void _updateAmount(String input) {
    setState(() {
      if (input == 'C') {
        _amount = "0";
      } else if (input == '→') {
        final temp = _fromCurrency;
        _fromCurrency = _toCurrency;
        _toCurrency = temp;
      } else {
        if (_amount == "0") {
          _amount = input;
        } else {
          _amount += input;
        }
      }
    });
  }

  Widget _buildNumberPad() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 16,
      itemBuilder: (context, index) {
        if (_showCurrencyPicker) {
          if (index < _currencies.length) {
            return _buildCurrencyButton(_currencies[index]);
          }
          return const SizedBox();
        } else {
          final symbols = [
            '1',
            '2',
            '3',
            'C',
            '4',
            '5',
            '6',
            '-',
            '7',
            '8',
            '9',
            '+',
            '0',
            '.',
            '→'
          ];
          if (index < symbols.length) {
            final number = symbols[index];
            return _buildCalculatorButton(number);
          }
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildCalculatorButton(String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade400,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: () => _updateAmount(label),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyButton(String currency) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade400,
        borderRadius: BorderRadius.circular(12),
        border: (_selectingFromCurrency && _fromCurrency == currency) ||
                (!_selectingFromCurrency && _toCurrency == currency)
            ? Border.all(color: Colors.blue.shade900, width: 2)
            : null,
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            if (_selectingFromCurrency) {
              _fromCurrency = currency;
            } else {
              _toCurrency = currency;
            }
            _showCurrencyPicker = false;
          });
        },
        child: Text(
          currency,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showCurrencyPicker = true;
                              _selectingFromCurrency = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  _fromCurrency,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "$_fromCurrency $_amount",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showCurrencyPicker = true;
                              _selectingFromCurrency = false;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  _toCurrency,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "${_toCurrency} ${_convertCurrency(_amount)}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _buildNumberPad(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _convertCurrency(String amount) {
    if (amount.isEmpty || amount == "0") return "0.00";
    final double fromRate = _exchangeRatesToUSD[_fromCurrency] ?? 1.0;
    final double toRate = _exchangeRatesToUSD[_toCurrency] ?? 1.0;
    final double amountValue = double.parse(amount);
    final double converted = (amountValue * fromRate) / toRate;
    return converted.toStringAsFixed(2);
  }
}
