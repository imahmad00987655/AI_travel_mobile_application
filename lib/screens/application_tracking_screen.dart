import 'package:flutter/material.dart';

class ApplicationTrackingScreen extends StatefulWidget {
  const ApplicationTrackingScreen({super.key});

  @override
  State<ApplicationTrackingScreen> createState() => _ApplicationTrackingScreenState();
}

class _ApplicationTrackingScreenState extends State<ApplicationTrackingScreen> {
  final List<ApplicationStep> _steps = [
    ApplicationStep(
      title: 'Booking Confirmed',
      description: 'Your booking has been confirmed',
      status: StepStatus.completed,
      date: '2024-03-01',
    ),
    ApplicationStep(
      title: 'Documents Uploaded',
      description: 'All required documents have been uploaded',
      status: StepStatus.completed,
      date: '2024-03-02',
    ),
    ApplicationStep(
      title: 'Visa Processing',
      description: 'Your visa application is being processed',
      status: StepStatus.inProgress,
      date: '2024-03-03',
    ),
    ApplicationStep(
      title: 'Flight Booking',
      description: 'Flight tickets will be issued',
      status: StepStatus.pending,
      date: '2024-03-10',
    ),
    ApplicationStep(
      title: 'Hotel Booking',
      description: 'Hotel reservation will be confirmed',
      status: StepStatus.pending,
      date: '2024-03-15',
    ),
    ApplicationStep(
      title: 'Travel Ready',
      description: 'All set for your journey',
      status: StepStatus.pending,
      date: '2024-03-20',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Tracking'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Overview
            Card(
              color: Colors.red.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Application Status',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'In Progress',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your application is being processed',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: 0.4,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Timeline
            const Text(
              'Application Timeline',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _steps.length,
              itemBuilder: (context, index) {
                final step = _steps[index];
                return TimelineStep(
                  step: step,
                  isFirst: index == 0,
                  isLast: index == _steps.length - 1,
                );
              },
            ),
            const SizedBox(height: 24),

            // Support Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Need Help?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.phone, color: Colors.red),
                      title: const Text('Call Support'),
                      subtitle: const Text('+1 234 567 8900'),
                      onTap: () {
                        // TODO: Implement call functionality
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.email, color: Colors.red),
                      title: const Text('Email Support'),
                      subtitle: const Text('support@alibaba-travel.com'),
                      onTap: () {
                        // TODO: Implement email functionality
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.chat, color: Colors.red),
                      title: const Text('Live Chat'),
                      subtitle: const Text('Available 24/7'),
                      onTap: () {
                        // TODO: Implement chat functionality
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimelineStep extends StatelessWidget {
  final ApplicationStep step;
  final bool isFirst;
  final bool isLast;

  const TimelineStep({
    super.key,
    required this.step,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline Line
        Column(
          children: [
            if (!isFirst)
              Container(
                width: 2,
                height: 20,
                color: _getStatusColor(step.status),
              ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getStatusColor(step.status),
              ),
              child: Icon(
                _getStatusIcon(step.status),
                size: 12,
                color: Colors.white,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                color: _getStatusColor(step.status),
              ),
          ],
        ),
        const SizedBox(width: 16),

        // Step Content
        Expanded(
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(step.description),
                  const SizedBox(height: 8),
                  Text(
                    step.date,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(StepStatus status) {
    switch (status) {
      case StepStatus.completed:
        return Colors.green;
      case StepStatus.inProgress:
        return Colors.orange;
      case StepStatus.pending:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(StepStatus status) {
    switch (status) {
      case StepStatus.completed:
        return Icons.check;
      case StepStatus.inProgress:
        return Icons.hourglass_empty;
      case StepStatus.pending:
        return Icons.schedule;
    }
  }
}

class ApplicationStep {
  String title;
  String description;
  StepStatus status;
  String date;

  ApplicationStep({
    required this.title,
    required this.description,
    required this.status,
    required this.date,
  });
}

enum StepStatus {
  completed,
  inProgress,
  pending,
} 