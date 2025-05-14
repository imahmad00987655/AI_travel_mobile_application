import 'package:flutter/material.dart';

class TicketingScreen extends StatefulWidget {
  const TicketingScreen({super.key});

  @override
  State<TicketingScreen> createState() => _TicketingScreenState();
}

class _TicketingScreenState extends State<TicketingScreen> {
  final _formKey = GlobalKey<FormState>();
  String _from = '';
  String _to = '';
  DateTime? _departureDate;
  DateTime? _returnDate;
  int _passengers = 1;
  String _class = 'Economy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight Booking'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                label: 'From',
                hint: 'Enter departure city',
                onSaved: (value) => _from = value!,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'To',
                hint: 'Enter destination city',
                onSaved: (value) => _to = value!,
              ),
              const SizedBox(height: 16),
              _buildDateField(
                label: 'Departure Date',
                date: _departureDate,
                onDateSelected: (date) {
                  setState(() => _departureDate = date);
                },
              ),
              const SizedBox(height: 16),
              _buildDateField(
                label: 'Return Date',
                date: _returnDate,
                onDateSelected: (date) {
                  setState(() => _returnDate = date);
                },
              ),
              const SizedBox(height: 16),
              _buildPassengerSelector(),
              const SizedBox(height: 16),
              _buildClassSelector(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _searchFlights,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Search Flights',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required Function(String?) onSaved,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required Function(DateTime) onDateSelected,
  }) {
    return InkWell(
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (selectedDate != null) {
          onDateSelected(selectedDate);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          date != null
              ? '${date.day}/${date.month}/${date.year}'
              : 'Select date',
        ),
      ),
    );
  }

  Widget _buildPassengerSelector() {
    return Row(
      children: [
        const Text(
          'Passengers:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {
            if (_passengers > 1) {
              setState(() => _passengers--);
            }
          },
          icon: const Icon(Icons.remove),
        ),
        Text(
          '$_passengers',
          style: const TextStyle(fontSize: 16),
        ),
        IconButton(
          onPressed: () {
            if (_passengers < 9) {
              setState(() => _passengers++);
            }
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildClassSelector() {
    return DropdownButtonFormField<String>(
      value: _class,
      decoration: InputDecoration(
        labelText: 'Class',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: ['Economy', 'Business', 'First Class']
          .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() => _class = newValue);
        }
      },
    );
  }

  void _searchFlights() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TODO: Implement flight search logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Searching for flights...'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
} 