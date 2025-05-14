import 'package:flutter/material.dart';
import 'package:travel_advisor/models/itinerary.dart';
import 'package:uuid/uuid.dart';

class CreateItineraryScreen extends StatefulWidget {
  final TravelItinerary? itinerary;

  const CreateItineraryScreen({
    Key? key,
    this.itinerary,
  }) : super(key: key);

  @override
  _CreateItineraryScreenState createState() => _CreateItineraryScreenState();
}

class _CreateItineraryScreenState extends State<CreateItineraryScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _destinationController;
  late TextEditingController _notesController;
  late DateTime _startDate;
  late DateTime _endDate;
  late double _totalBudget;
  final List<String> _sharedWith = [];
  final List<DayPlan> _dayPlans = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.itinerary?.title ?? '');
    _destinationController = TextEditingController(text: widget.itinerary?.destination ?? '');
    _notesController = TextEditingController(text: widget.itinerary?.notes ?? '');
    _startDate = widget.itinerary?.startDate ?? DateTime.now();
    _endDate = widget.itinerary?.endDate ?? DateTime.now().add(const Duration(days: 7));
    _totalBudget = widget.itinerary?.totalBudget ?? 0.0;
    if (widget.itinerary != null) {
      _sharedWith.addAll(widget.itinerary!.sharedWith);
      _dayPlans.addAll(widget.itinerary!.dayPlans);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _destinationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _saveItinerary() {
    if (_formKey.currentState!.validate()) {
      final itinerary = TravelItinerary(
        id: widget.itinerary?.id ?? const Uuid().v4(),
        title: _titleController.text,
        destination: _destinationController.text,
        startDate: _startDate,
        endDate: _endDate,
        dayPlans: _dayPlans,
        totalBudget: _totalBudget,
        sharedWith: _sharedWith,
        notes: _notesController.text,
      );

      Navigator.pop(context, itinerary);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itinerary == null ? 'Create Itinerary' : 'Edit Itinerary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveItinerary,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter itinerary title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _destinationController,
                decoration: const InputDecoration(
                  labelText: 'Destination',
                  hintText: 'Enter destination',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a destination';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Start Date'),
                      subtitle: Text(_formatDate(_startDate)),
                      onTap: () => _selectDate(context, true),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('End Date'),
                      subtitle: Text(_formatDate(_endDate)),
                      onTap: () => _selectDate(context, false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  hintText: 'Enter any additional notes',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement day plan creation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Day plan creation coming soon!')),
                  );
                },
                child: const Text('Add Day Plan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
} 