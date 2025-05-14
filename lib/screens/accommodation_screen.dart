import 'package:flutter/material.dart';

class AccommodationScreen extends StatefulWidget {
  const AccommodationScreen({super.key});

  @override
  State<AccommodationScreen> createState() => _AccommodationScreenState();
}

class _AccommodationScreenState extends State<AccommodationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _location = '';
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _guests = 1;
  int _rooms = 1;
  String _roomType = 'Standard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Booking'),
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
                label: 'Location',
                hint: 'Enter city or hotel name',
                onSaved: (value) => _location = value!,
              ),
              const SizedBox(height: 16),
              _buildDateField(
                label: 'Check-in Date',
                date: _checkInDate,
                onDateSelected: (date) {
                  setState(() => _checkInDate = date);
                },
              ),
              const SizedBox(height: 16),
              _buildDateField(
                label: 'Check-out Date',
                date: _checkOutDate,
                onDateSelected: (date) {
                  setState(() => _checkOutDate = date);
                },
              ),
              const SizedBox(height: 16),
              _buildGuestSelector(),
              const SizedBox(height: 16),
              _buildRoomSelector(),
              const SizedBox(height: 16),
              _buildRoomTypeSelector(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _searchHotels,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Search Hotels',
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

  Widget _buildGuestSelector() {
    return Row(
      children: [
        const Text(
          'Guests:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {
            if (_guests > 1) {
              setState(() => _guests--);
            }
          },
          icon: const Icon(Icons.remove),
        ),
        Text(
          '$_guests',
          style: const TextStyle(fontSize: 16),
        ),
        IconButton(
          onPressed: () {
            if (_guests < 10) {
              setState(() => _guests++);
            }
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildRoomSelector() {
    return Row(
      children: [
        const Text(
          'Rooms:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {
            if (_rooms > 1) {
              setState(() => _rooms--);
            }
          },
          icon: const Icon(Icons.remove),
        ),
        Text(
          '$_rooms',
          style: const TextStyle(fontSize: 16),
        ),
        IconButton(
          onPressed: () {
            if (_rooms < 5) {
              setState(() => _rooms++);
            }
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildRoomTypeSelector() {
    return DropdownButtonFormField<String>(
      value: _roomType,
      decoration: InputDecoration(
        labelText: 'Room Type',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: ['Standard', 'Deluxe', 'Suite', 'Executive']
          .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() => _roomType = newValue);
        }
      },
    );
  }

  void _searchHotels() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TODO: Implement hotel search logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Searching for hotels...'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
} 