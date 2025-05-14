import 'package:flutter/material.dart';
import 'package:travel_advisor/models/itinerary.dart';
import 'package:travel_advisor/screens/itinerary_detail_screen.dart';
import 'package:travel_advisor/screens/create_itinerary_screen.dart';

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({Key? key}) : super(key: key);

  @override
  _ItineraryScreenState createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  List<TravelItinerary> _itineraries = [];

  @override
  void initState() {
    super.initState();
    _loadItineraries();
  }

  Future<void> _loadItineraries() async {
    // TODO: Load itineraries from local storage or API
    setState(() {
      _itineraries = [
        TravelItinerary(
          id: '1',
          title: 'Summer Vacation 2023',
          destination: 'Bali, Indonesia',
          startDate: DateTime(2023, 7, 1),
          endDate: DateTime(2023, 7, 7),
          dayPlans: [],
          totalBudget: 2500.0,
          sharedWith: ['john@example.com'],
          notes: 'Family vacation',
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Itineraries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_download),
            onPressed: () {
              // TODO: Implement offline sync
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Syncing offline data...')),
              );
            },
          ),
        ],
      ),
      body: _itineraries.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.airplanemode_active,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No itineraries yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _navigateToCreateItinerary(),
                    child: const Text('Create New Itinerary'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _itineraries.length,
              itemBuilder: (context, index) {
                final itinerary = _itineraries[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      itinerary.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          '${itinerary.destination} • ${_formatDateRange(itinerary.startDate, itinerary.endDate)}',
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Budget: \$${itinerary.totalBudget.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (itinerary.isOfflineAvailable)
                          const Icon(
                            Icons.cloud_done,
                            color: Colors.green,
                          ),
                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    onTap: () => _navigateToItineraryDetail(itinerary),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreateItinerary(),
        child: const Icon(Icons.add),
      ),
    );
  }

  String _formatDateRange(DateTime start, DateTime end) {
    return '${start.day}/${start.month}/${start.year} - ${end.day}/${end.month}/${end.year}';
  }

  void _navigateToItineraryDetail(TravelItinerary itinerary) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItineraryDetailScreen(itinerary: itinerary),
      ),
    );
  }

  void _navigateToCreateItinerary() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateItineraryScreen(),
      ),
    ).then((_) => _loadItineraries());
  }
} 