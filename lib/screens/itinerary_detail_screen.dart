import 'package:flutter/material.dart';
import 'package:travel_advisor/models/itinerary.dart';
import 'package:travel_advisor/screens/create_itinerary_screen.dart';

class ItineraryDetailScreen extends StatefulWidget {
  final TravelItinerary itinerary;

  const ItineraryDetailScreen({
    Key? key,
    required this.itinerary,
  }) : super(key: key);

  @override
  _ItineraryDetailScreenState createState() => _ItineraryDetailScreenState();
}

class _ItineraryDetailScreenState extends State<ItineraryDetailScreen> {
  late TravelItinerary _itinerary;

  @override
  void initState() {
    super.initState();
    _itinerary = widget.itinerary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_itinerary.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _navigateToEditItinerary(),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareItinerary(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildDayPlans(),
            if (_itinerary.notes != null && _itinerary.notes!.isNotEmpty)
              _buildNotes(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _itinerary.destination,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_formatDate(_itinerary.startDate)} - ${_formatDate(_itinerary.endDate)}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoChip(
                icon: Icons.people,
                label: '${_itinerary.sharedWith.length + 1} travelers',
              ),
              _buildInfoChip(
                icon: Icons.attach_money,
                label: '\$${_itinerary.totalBudget.toStringAsFixed(2)}',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
    );
  }

  Widget _buildDayPlans() {
    if (_itinerary.dayPlans.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(
            'No activities planned yet',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _itinerary.dayPlans.length,
      itemBuilder: (context, index) {
        final dayPlan = _itinerary.dayPlans[index];
        return Card(
          margin: const EdgeInsets.all(16),
          child: ExpansionTile(
            title: Text(
              'Day ${index + 1} - ${_formatDate(dayPlan.date)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${dayPlan.activities.length} activities',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            children: [
              ...dayPlan.activities.map((activity) => _buildActivityTile(activity)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActivityTile(Activity activity) {
    return ListTile(
      title: Text(activity.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_formatTime(activity.startTime)} - ${_formatTime(activity.endTime)}',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          if (activity.location.isNotEmpty)
            Text(
              activity.location,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
        ],
      ),
      trailing: Text(
        activity.cost > 0 ? '\$${activity.cost.toStringAsFixed(2)}' : 'Free',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildNotes() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(_itinerary.notes!),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void _navigateToEditItinerary() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateItineraryScreen(
          itinerary: _itinerary,
        ),
      ),
    ).then((updatedItinerary) {
      if (updatedItinerary != null) {
        setState(() {
          _itinerary = updatedItinerary;
        });
      }
    });
  }

  void _shareItinerary() {
    // TODO: Implement sharing functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sharing itinerary...')),
    );
  }
} 