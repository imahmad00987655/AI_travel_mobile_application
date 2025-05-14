import 'package:flutter/material.dart';
import 'package:travel_advisor/models/packing_list.dart';

class PackingListScreen extends StatefulWidget {
  const PackingListScreen({super.key});

  @override
  State<PackingListScreen> createState() => _PackingListScreenState();
}

class _PackingListScreenState extends State<PackingListScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedDestination = '';
  String _selectedWeather = '';
  int _tripDuration = 1;
  List<String> _selectedActivities = [];
  List<PackingItem> _generatedItems = [];
  bool _isLoading = false;

  final List<String> _destinations = [
    'Beach',
    'Mountain',
    'City',
    'Desert',
    'Tropical',
    'Arctic',
  ];

  final List<String> _weatherOptions = [
    'Hot',
    'Warm',
    'Mild',
    'Cool',
    'Cold',
    'Freezing',
  ];

  final List<String> _activities = [
    'Hiking',
    'Swimming',
    'Sightseeing',
    'Business',
    'Camping',
    'Skiing',
    'Beach',
    'Shopping',
  ];

  void _showAddItemDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    IconData selectedIcon = Icons.backpack;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add New Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Item Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an item name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<IconData>(
                value: selectedIcon,
                decoration: const InputDecoration(
                  labelText: 'Icon',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: Icons.backpack,
                    child: Text('Backpack'),
                  ),
                  DropdownMenuItem(
                    value: Icons.checkroom,
                    child: Text('Clothing'),
                  ),
                  DropdownMenuItem(
                    value: Icons.medical_services,
                    child: Text('Medical'),
                  ),
                  DropdownMenuItem(
                    value: Icons.electric_bolt,
                    child: Text('Electronics'),
                  ),
                  DropdownMenuItem(
                    value: Icons.water_drop,
                    child: Text('Toiletries'),
                  ),
                  DropdownMenuItem(
                    value: Icons.sports_tennis,
                    child: Text('Sports'),
                  ),
                ],
                onChanged: (IconData? value) {
                  if (value != null) {
                    setState(() {
                      selectedIcon = value;
                    });
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && categoryController.text.isNotEmpty) {
                  setState(() {
                    _generatedItems.add(
                      PackingItem(
                        nameController.text,
                        categoryController.text,
                        selectedIcon,
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Packing List'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Trip Details Form
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Trip Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Destination Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedDestination.isEmpty ? null : _selectedDestination,
                        decoration: const InputDecoration(
                          labelText: 'Destination',
                          border: OutlineInputBorder(),
                        ),
                        items: _destinations.map((String destination) {
                          return DropdownMenuItem<String>(
                            value: destination,
                            child: Text(destination),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedDestination = newValue ?? '';
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a destination';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Weather Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedWeather.isEmpty ? null : _selectedWeather,
                        decoration: const InputDecoration(
                          labelText: 'Weather',
                          border: OutlineInputBorder(),
                        ),
                        items: _weatherOptions.map((String weather) {
                          return DropdownMenuItem<String>(
                            value: weather,
                            child: Text(weather),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedWeather = newValue ?? '';
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select weather';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Trip Duration
                      TextFormField(
                        initialValue: _tripDuration.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Trip Duration (days)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter trip duration';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _tripDuration = int.tryParse(value) ?? 1;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      // Activities
                      const Text(
                        'Activities',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _activities.map((String activity) {
                          return FilterChip(
                            label: Text(activity),
                            selected: _selectedActivities.contains(activity),
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  _selectedActivities.add(activity);
                                } else {
                                  _selectedActivities.remove(activity);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      // Generate Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _generatePackingList,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('Generate Packing List'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Packing List Section
            if (_generatedItems.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Packing List',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _showAddItemDialog,
                    icon: const Icon(Icons.add, color: Colors.red),
                    label: const Text(
                      'Add Item',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _generatedItems.length,
                itemBuilder: (context, index) {
                  final item = _generatedItems[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: CheckboxListTile(
                      title: Text(item.name),
                      subtitle: Text(item.category),
                      value: item.isPacked,
                      onChanged: (bool? value) {
                        setState(() {
                          _generatedItems[index] = item.copyWith(isPacked: value ?? false);
                        });
                      },
                      secondary: Icon(
                        item.icon,
                        color: Colors.red,
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _savePackingList,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Save Packing List'),
                ),
              ),
            ] else ...[
              // Empty State
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.backpack_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No items in your packing list',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Generate a list or add items manually',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _showAddItemDialog,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Item Manually'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        backgroundColor: Colors.red,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _generatePackingList() {
    if (_formKey.currentState!.validate() && _selectedActivities.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call delay
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isLoading = false;
          _generatedItems = _generateItems();
        });
      });
    } else if (_selectedActivities.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one activity')),
      );
    }
  }

  List<PackingItem> _generateItems() {
    // This is a simplified example. In a real app, you would have a more sophisticated
    // algorithm based on the selected parameters.
    List<PackingItem> items = [];

    // Add destination-specific items
    switch (_selectedDestination) {
      case 'Beach':
        items.addAll([
          PackingItem('Swimsuit', 'Clothing', Icons.pool),
          PackingItem('Sunscreen', 'Toiletries', Icons.sunny),
          PackingItem('Beach Towel', 'Accessories', Icons.beach_access),
        ]);
        break;
      case 'Mountain':
        items.addAll([
          PackingItem('Hiking Boots', 'Footwear', Icons.hiking),
          PackingItem('Warm Jacket', 'Clothing', Icons.ac_unit),
          PackingItem('Water Bottle', 'Accessories', Icons.water_drop),
        ]);
        break;
      // Add more cases for other destinations
    }

    // Add weather-specific items
    if (_selectedWeather == 'Cold' || _selectedWeather == 'Freezing') {
      items.addAll([
        PackingItem('Winter Coat', 'Clothing', Icons.ac_unit),
        PackingItem('Gloves', 'Accessories', Icons.back_hand),
        PackingItem('Thermal Underwear', 'Clothing', Icons.thermostat),
      ]);
    }

    // Add activity-specific items
    if (_selectedActivities.contains('Hiking')) {
      items.addAll([
        PackingItem('Hiking Boots', 'Footwear', Icons.hiking),
        PackingItem('Backpack', 'Accessories', Icons.backpack),
        PackingItem('First Aid Kit', 'Medical', Icons.medical_services),
      ]);
    }

    // Add duration-specific items
    if (_tripDuration > 3) {
      items.add(PackingItem('Extra Clothes', 'Clothing', Icons.checkroom));
    }

    return items;
  }

  void _savePackingList() {
    // TODO: Implement saving to local storage or backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Packing list saved successfully')),
    );
  }
} 