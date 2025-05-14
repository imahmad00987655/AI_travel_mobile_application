import 'package:flutter/material.dart';

class EmbassyAppointmentScreen extends StatefulWidget {
  const EmbassyAppointmentScreen({super.key});

  @override
  State<EmbassyAppointmentScreen> createState() => _EmbassyAppointmentScreenState();
}

class _EmbassyAppointmentScreenState extends State<EmbassyAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _country = '';
  String _visaType = 'Tourist';
  DateTime? _preferredDate;
  TimeOfDay? _preferredTime;
  String _appointmentType = 'New Application';
  String _notes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Embassy Appointment'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCountrySelector(),
              const SizedBox(height: 16),
              _buildVisaTypeSelector(),
              const SizedBox(height: 16),
              _buildAppointmentTypeSelector(),
              const SizedBox(height: 16),
              _buildDateField(
                label: 'Preferred Date',
                date: _preferredDate,
                onDateSelected: (date) {
                  setState(() => _preferredDate = date);
                },
              ),
              const SizedBox(height: 16),
              _buildTimeField(
                label: 'Preferred Time',
                time: _preferredTime,
                onTimeSelected: (time) {
                  setState(() => _preferredTime = time);
                },
              ),
              const SizedBox(height: 16),
              _buildNotesField(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _scheduleAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Schedule Appointment',
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

  Widget _buildCountrySelector() {
    return DropdownButtonFormField<String>(
      value: _country.isEmpty ? null : _country,
      decoration: InputDecoration(
        labelText: 'Select Country',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: [
        'United States',
        'United Kingdom',
        'Canada',
        'Australia',
        'Germany',
        'France',
        'Italy',
        'Spain',
        'Japan',
        'South Korea'
      ].map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          )).toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a country';
        }
        return null;
      },
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() => _country = newValue);
        }
      },
    );
  }

  Widget _buildVisaTypeSelector() {
    return DropdownButtonFormField<String>(
      value: _visaType,
      decoration: InputDecoration(
        labelText: 'Visa Type',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: [
        'Tourist',
        'Business',
        'Student',
        'Work',
        'Transit',
        'Medical',
        'Family Visit'
      ].map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          )).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() => _visaType = newValue);
        }
      },
    );
  }

  Widget _buildAppointmentTypeSelector() {
    return DropdownButtonFormField<String>(
      value: _appointmentType,
      decoration: InputDecoration(
        labelText: 'Appointment Type',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: [
        'New Application',
        'Document Submission',
        'Biometrics',
        'Interview',
        'Passport Collection'
      ].map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          )).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() => _appointmentType = newValue);
        }
      },
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
          lastDate: DateTime.now().add(const Duration(days: 90)),
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

  Widget _buildNotesField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Additional Notes',
        hintText: 'Enter any special requirements or notes',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      maxLines: 3,
      onSaved: (value) => _notes = value ?? '',
    );
  }

  void _scheduleAppointment() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TODO: Implement appointment scheduling logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Scheduling embassy appointment...'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
} 