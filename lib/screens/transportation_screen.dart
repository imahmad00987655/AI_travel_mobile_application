import 'package:flutter/material.dart';

class TransportationScreen extends StatefulWidget {
  const TransportationScreen({super.key});

  @override
  State<TransportationScreen> createState() => _TransportationScreenState();
}

class _TransportationScreenState extends State<TransportationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _pickupLocation = '';
  String _dropoffLocation = '';
  DateTime? _pickupDate;
  TimeOfDay? _pickupTime;
  String _vehicleType = 'Sedan';
  int _passengers = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transportation'),
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
                label: 'Pickup Location',
                hint: 'Enter pickup address',
                onSaved: (value) => _pickupLocation = value!,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Drop-off Location',
                hint: 'Enter destination address',
                onSaved: (value) => _dropoffLocation = value!,
              ),
              const SizedBox(height: 16),
              _buildDateField(
                label: 'Pickup Date',
                date: _pickupDate,
                onDateSelected: (date) {
                  setState(() => _pickupDate = date);
                },
              ),
              const SizedBox(height: 16),
              _buildTimeField(
                label: 'Pickup Time',
                time: _pickupTime,
                onTimeSelected: (time) {
                  setState(() => _pickupTime = time);
                },
              ),
              const SizedBox(height: 16),
              _buildVehicleTypeSelector(),
              const SizedBox(height: 16),
              _buildPassengerSelector(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _searchTransportation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Search Transportation',
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

  Widget _buildTimeField({
    required String label,
    required TimeOfDay? time,
    required Function(TimeOfDay) onTimeSelected,
  }) {
    return InkWell(
      onTap: () async {
        final selectedTime = await showTimePicker(
          context: context,
          initialTime: time ?? TimeOfDay.now(),
        );
        if (selectedTime != null) {
          onTimeSelected(selectedTime);
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
          time != null
              ? '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}'
              : 'Select time',
        ),
      ),
    );
  }

  Widget _buildVehicleTypeSelector() {
    return DropdownButtonFormField<String>(
      value: _vehicleType,
      decoration: InputDecoration(
        labelText: 'Vehicle Type',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: ['Sedan', 'SUV', 'Van', 'Luxury', 'Minibus']
          .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() => _vehicleType = newValue);
        }
      },
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
            if (_passengers < 10) {
              setState(() => _passengers++);
            }
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  void _searchTransportation() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TODO: Implement transportation search logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Searching for transportation options...'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
} 