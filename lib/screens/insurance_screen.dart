import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InsuranceScreen extends StatefulWidget {
  const InsuranceScreen({Key? key}) : super(key: key);

  @override
  _InsuranceScreenState createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<InsuranceScreen> {
  final List<InsurancePlan> _plans = [
    InsurancePlan(
      name: 'Basic Coverage',
      price: 29.99,
      features: [
        'Medical expenses up to \$50,000',
        'Trip cancellation up to \$2,000',
        'Baggage loss up to \$1,000',
        '24/7 emergency assistance',
      ],
      icon: FontAwesomeIcons.shield,
      color: Colors.blue,
    ),
    InsurancePlan(
      name: 'Standard Coverage',
      price: 49.99,
      features: [
        'Medical expenses up to \$100,000',
        'Trip cancellation up to \$5,000',
        'Baggage loss up to \$2,000',
        'Flight delay coverage',
        '24/7 emergency assistance',
      ],
      icon: FontAwesomeIcons.shieldHalved,
      color: Colors.green,
    ),
    InsurancePlan(
      name: 'Premium Coverage',
      price: 79.99,
      features: [
        'Medical expenses up to \$250,000',
        'Trip cancellation up to \$10,000',
        'Baggage loss up to \$3,000',
        'Flight delay coverage',
        'Rental car coverage',
        '24/7 emergency assistance',
        'Adventure sports coverage',
      ],
      icon: FontAwesomeIcons.shieldHeart,
      color: Colors.purple,
    ),
  ];

  final List<InsuranceScenario> _scenarios = [
    InsuranceScenario(
      title: 'Medical Emergency',
      description: 'Coverage for unexpected medical expenses during your trip',
      icon: FontAwesomeIcons.hospital,
      color: Colors.red,
    ),
    InsuranceScenario(
      title: 'Trip Cancellation',
      description: 'Protection against non-refundable trip costs',
      icon: FontAwesomeIcons.planeSlash,
      color: Colors.orange,
    ),
    InsuranceScenario(
      title: 'Baggage Loss',
      description: 'Compensation for lost or delayed baggage',
      icon: FontAwesomeIcons.suitcase,
      color: Colors.blue,
    ),
    InsuranceScenario(
      title: 'Flight Delay',
      description: 'Coverage for additional expenses due to flight delays',
      icon: FontAwesomeIcons.clock,
      color: Colors.purple,
    ),
    InsuranceScenario(
      title: 'Rental Car Damage',
      description: 'Protection against rental car damages',
      icon: FontAwesomeIcons.car,
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Insurance'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Your Coverage',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select a plan that best fits your travel needs',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _plans.length,
                itemBuilder: (context, index) {
                  return InsurancePlanCard(plan: _plans[index]);
                },
              ),
              const SizedBox(height: 32),
              const Text(
                'Coverage Scenarios',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Understand what your insurance covers',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _scenarios.length,
                itemBuilder: (context, index) {
                  return InsuranceScenarioCard(scenario: _scenarios[index]);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showPurchaseDialog();
        },
        label: const Text('Purchase Insurance'),
        icon: const Icon(Icons.shopping_cart),
      ),
    );
  }

  void _showPurchaseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Purchase Insurance'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select your insurance plan:'),
            const SizedBox(height: 16),
            ..._plans.map((plan) => ListTile(
                  leading: Icon(plan.icon, color: plan.color),
                  title: Text(plan.name),
                  subtitle: Text('\$${plan.price.toStringAsFixed(2)}'),
                  onTap: () {
                    Navigator.pop(context);
                    _showConfirmationDialog(plan);
                  },
                )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(InsurancePlan plan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Purchase'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Plan: ${plan.name}'),
            Text('Price: \$${plan.price.toStringAsFixed(2)}'),
            const SizedBox(height: 16),
            const Text('Features:'),
            ...plan.features.map((feature) => Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: Text('• $feature'),
                )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${plan.name} purchased successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

class InsurancePlan {
  final String name;
  final double price;
  final List<String> features;
  final IconData icon;
  final Color color;

  InsurancePlan({
    required this.name,
    required this.price,
    required this.features,
    required this.icon,
    required this.color,
  });
}

class InsuranceScenario {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  InsuranceScenario({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class InsurancePlanCard extends StatelessWidget {
  final InsurancePlan plan;

  const InsurancePlanCard({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(plan.icon, color: plan.color, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${plan.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          color: plan.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            ...plan.features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: plan.color, size: 20),
                      const SizedBox(width: 8),
                      Expanded(child: Text(feature)),
                    ],
                  ),
                )),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle purchase
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: plan.color,
                ),
                child: const Text('Select Plan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InsuranceScenarioCard extends StatelessWidget {
  final InsuranceScenario scenario;

  const InsuranceScenarioCard({Key? key, required this.scenario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(scenario.icon, color: scenario.color, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scenario.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    scenario.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 