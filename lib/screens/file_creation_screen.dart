import 'package:flutter/material.dart';

class FileCreationScreen extends StatefulWidget {
  const FileCreationScreen({super.key});

  @override
  State<FileCreationScreen> createState() => _FileCreationScreenState();
}

class _FileCreationScreenState extends State<FileCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _fileName = '';
  String _fileType = 'Passport';
  String _description = '';
  DateTime? _expiryDate;
  bool _isRequired = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create File'),
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
                label: 'File Name',
                hint: 'Enter file name',
                onSaved: (value) => _fileName = value!,
              ),
              const SizedBox(height: 16),
              _buildFileTypeSelector(),
              const SizedBox(height: 16),
              _buildDateField(
                label: 'Expiry Date',
                date: _expiryDate,
                onDateSelected: (date) {
                  setState(() => _expiryDate = date);
                },
              ),
              const SizedBox(height: 16),
              _buildDescriptionField(),
              const SizedBox(height: 16),
              _buildRequiredToggle(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _createFile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Create File',
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

  Widget _buildFileTypeSelector() {
    return DropdownButtonFormField<String>(
      value: _fileType,
      decoration: InputDecoration(
        labelText: 'File Type',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: [
        'Passport',
        'Visa',
        'ID Card',
        'Driving License',
        'Travel Insurance',
        'Flight Ticket',
        'Hotel Booking',
        'Tour Itinerary',
        'Medical Certificate',
        'Bank Statement'
      ].map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          )).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() => _fileType = newValue);
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
          lastDate: DateTime.now().add(const Duration(days: 3650)),
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

  Widget _buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Description',
        hintText: 'Enter file description',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      maxLines: 3,
      onSaved: (value) => _description = value ?? '',
    );
  }

  Widget _buildRequiredToggle() {
    return Row(
      children: [
        const Text(
          'Required Document',
          style: TextStyle(fontSize: 16),
        ),
        const Spacer(),
        Switch(
          value: _isRequired,
          activeColor: Colors.red,
          onChanged: (bool value) {
            setState(() => _isRequired = value);
          },
        ),
      ],
    );
  }

  void _createFile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TODO: Implement file creation logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Creating file...'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
} 