import 'package:flutter/material.dart';

class CustomTourScreen extends StatefulWidget {
  const CustomTourScreen({super.key});

  @override
  State<CustomTourScreen> createState() => _CustomTourScreenState();
}

class _CustomTourScreenState extends State<CustomTourScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> _selectedCities = [];
  String _selectedTransportation = 'Flight';
  String _selectedAccommodation = 'Hotel';
  DateTime? _startDate;
  DateTime? _endDate;
  int _numberOfTravelers = 1;
  double _budget = 1000.0;

  final List<String> _cities = [
    'New York',
    'London',
    'Paris',
    'Tokyo',
    'Dubai',
    'Rome',
    'Barcelona',
    'Amsterdam',
    'Singapore',
    'Sydney'
  ];

  final List<String> _transportationOptions = [
    'Flight',
    'Train',
    'Bus',
    'Car Rental',
    'Cruise'
  ];

  final List<String> _accommodationOptions = [
    'Hotel',
    'Hostel',
    'Apartment',
    'Resort',
    'Villa'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Tour Booking'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCitySelector(),
              const SizedBox(height: 16),
              _buildDateRangeSelector(),
              const SizedBox(height: 16),
              _buildTravelersSelector(),
              const SizedBox(height: 16),
              _buildTransportationSelector(),
              const SizedBox(height: 16),
              _buildAccommodationSelector(),
              const SizedBox(height: 16),
              _buildBudgetSlider(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Create Custom Tour',
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

  Widget _buildCitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Cities',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _cities.map((city) {
            final isSelected = _selectedCities.contains(city);
            return FilterChip(
              label: Text(city),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedCities.add(city);
                  } else {
                    _selectedCities.remove(city);
                  }
                });
              },
              selectedColor: Colors.red.withOpacity(0.2),
              checkmarkColor: Colors.red,
              labelStyle: TextStyle(
                color: isSelected ? Colors.red : Colors.black,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDateRangeSelector() {
    return Row(
      children: [
        Expanded(
          child: _buildDateField(
            label: 'Start Date',
            date: _startDate,
            onDateSelected: (date) {
              setState(() => _startDate = date);
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildDateField(
            label: 'End Date',
            date: _endDate,
            onDateSelected: (date) {
              setState(() => _endDate = date);
            },
          ),
        ),
      ],
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

  Widget _buildTravelersSelector() {
    return Row(
      children: [
        const Text(
          'Number of Travelers',
          style: TextStyle(fontSize: 16),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (_numberOfTravelers > 1) {
              setState(() => _numberOfTravelers--);
            }
          },
        ),
        Text(
          '$_numberOfTravelers',
          style: const TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() => _numberOfTravelers++);
          },
        ),
      ],
    );
  }

  Widget _buildTransportationSelector() {
    return DropdownButtonFormField<String>(
      value: _selectedTransportation,
      decoration: InputDecoration(
        labelText: 'Preferred Transportation',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: _transportationOptions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() => _selectedTransportation = newValue);
        }
      },
    );
  }

  Widget _buildAccommodationSelector() {
    return DropdownButtonFormField<String>(
      value: _selectedAccommodation,
      decoration: InputDecoration(
        labelText: 'Preferred Accommodation',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: _accommodationOptions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() => _selectedAccommodation = newValue);
        }
      },
    );
  }

  Widget _buildBudgetSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Budget',
          style: TextStyle(fontSize: 16),
        ),
        Slider(
          value: _budget,
          min: 500,
          max: 10000,
          divisions: 19,
          label: '\$${_budget.toStringAsFixed(0)}',
          onChanged: (value) {
            setState(() => _budget = value);
          },
        ),
        Text(
          '\$${_budget.toStringAsFixed(0)}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  void _submitBooking() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCities.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one city'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_startDate == null || _endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select start and end dates'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // TODO: Implement booking submission logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Creating custom tour...'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
} 