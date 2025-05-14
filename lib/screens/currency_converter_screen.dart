import 'package:flutter/material.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _convertedAmount = 0.0;
  bool _isLoading = false;

  final List<String> _currencies = [
    'USD', 'EUR', 'GBP', 'JPY', 'AUD', 'CAD', 'CHF', 'CNY', 'INR', 'SGD',
    'NZD', 'MXN', 'BRL', 'RUB', 'ZAR', 'AED', 'SAR', 'KRW', 'THB', 'IDR'
  ];

  // Sample exchange rates (in a real app, these would come from an API)
  final Map<String, double> _exchangeRates = {
    'USD': 1.0,
    'EUR': 0.92,
    'GBP': 0.79,
    'JPY': 151.5,
    'AUD': 1.52,
    'CAD': 1.36,
    'CHF': 0.90,
    'CNY': 7.24,
    'INR': 83.3,
    'SGD': 1.35,
    'NZD': 1.66,
    'MXN': 16.7,
    'BRL': 5.05,
    'RUB': 92.5,
    'ZAR': 18.8,
    'AED': 3.67,
    'SAR': 3.75,
    'KRW': 1342.5,
    'THB': 36.4,
    'IDR': 15850.0,
  };

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAmountInput(),
              const SizedBox(height: 16),
              _buildCurrencySelectors(),
              const SizedBox(height: 24),
              _buildConvertButton(),
              const SizedBox(height: 24),
              _buildResultCard(),
              const SizedBox(height: 24),
              _buildExchangeRateInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountInput() {
    return TextFormField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Amount',
        hintText: 'Enter amount to convert',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: const Icon(Icons.attach_money),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an amount';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }

  Widget _buildCurrencySelectors() {
    return Row(
      children: [
        Expanded(
          child: _buildCurrencyDropdown(
            value: _fromCurrency,
            onChanged: (value) {
              if (value != null) {
                setState(() => _fromCurrency = value);
              }
            },
            label: 'From',
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.swap_horiz),
          onPressed: _swapCurrencies,
          color: Colors.red,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildCurrencyDropdown(
            value: _toCurrency,
            onChanged: (value) {
              if (value != null) {
                setState(() => _toCurrency = value);
              }
            },
            label: 'To',
          ),
        ),
      ],
    );
  }

  Widget _buildCurrencyDropdown({
    required String value,
    required Function(String?) onChanged,
    required String label,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: _currencies.map((String currency) {
        return DropdownMenuItem<String>(
          value: currency,
          child: Text(currency),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildConvertButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _convertCurrency,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: _isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text(
              'Convert',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }

  Widget _buildResultCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Converted Amount',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${_convertedAmount.toStringAsFixed(2)} $_toCurrency',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExchangeRateInfo() {
    final rate = _exchangeRates[_toCurrency]! / _exchangeRates[_fromCurrency]!;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Exchange Rate',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '1 $_fromCurrency = ${rate.toStringAsFixed(4)} $_toCurrency',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _swapCurrencies() {
    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
      _convertCurrency();
    });
  }

  void _convertCurrency() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulate API call delay
      Future.delayed(const Duration(seconds: 1), () {
        final amount = double.parse(_amountController.text);
        final fromRate = _exchangeRates[_fromCurrency]!;
        final toRate = _exchangeRates[_toCurrency]!;
        
        setState(() {
          _convertedAmount = (amount / fromRate) * toRate;
          _isLoading = false;
        });
      });
    }
  }
}