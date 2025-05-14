import 'package:flutter/material.dart';
import 'package:travel_advisor/models/destination.dart';
import 'package:travel_advisor/widgets/destination_card.dart';
import 'package:travel_advisor/data/destinations.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Destination> _favoriteDestinations = [];
  List<Destination> _savedForLater = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Initialize with sample data
    _favoriteDestinations = List.from(featuredDestinations);
    _savedForLater = List.from(trendingDestinations);
  }

  void _removeFromFavorites(Destination destination) {
    setState(() {
      _favoriteDestinations.remove(destination);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${destination.name} removed from favorites'),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.red,
          onPressed: () {
            setState(() {
              _favoriteDestinations.add(destination);
            });
          },
        ),
      ),
    );
  }

  void _moveToFavorites(Destination destination) {
    setState(() {
      _savedForLater.remove(destination);
      _favoriteDestinations.add(destination);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Favorites',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manage your saved destinations',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),

            // Tab Bar
            TabBar(
              controller: _tabController,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.red,
              tabs: const [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite),
                      SizedBox(width: 8),
                      Text('Favorites'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bookmark),
                      SizedBox(width: 8),
                      Text('Saved for Later'),
                    ],
                  ),
                ),
              ],
            ),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Favorites Tab
                  _favoriteDestinations.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No favorite destinations yet',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Start adding destinations to your favorites',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _favoriteDestinations.length,
                          itemBuilder: (context, index) {
                            final destination = _favoriteDestinations[index];
                            return Dismissible(
                              key: Key(destination.name),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 16),
                                color: Colors.red.withOpacity(0.1),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              onDismissed: (_) => _removeFromFavorites(destination),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: DestinationCard(
                                  destination: destination,
                                  onTap: () {
                                    // Navigate to destination details
                                  },
                                ),
                              ),
                            );
                          },
                        ),

                  // Saved for Later Tab
                  _savedForLater.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bookmark_border,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No saved destinations',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Save destinations to view later',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _savedForLater.length,
                          itemBuilder: (context, index) {
                            final destination = _savedForLater[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Stack(
                                children: [
                                  DestinationCard(
                                    destination: destination,
                                    onTap: () {
                                      // Navigate to destination details
                                    },
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: IconButton(
                                      icon: const Icon(Icons.favorite_border),
                                      color: Colors.red,
                                      onPressed: () => _moveToFavorites(destination),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
} 