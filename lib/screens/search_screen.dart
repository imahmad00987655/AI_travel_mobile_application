import 'package:flutter/material.dart';
import 'package:travel_advisor/data/destinations.dart';
import 'package:travel_advisor/models/destination.dart';
import 'package:travel_advisor/widgets/destination_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  double _priceRange = 2000;
  double _ratingFilter = 0;
  bool _showFilters = false;
  late TabController _tabController;

  final List<String> _categories = [
    'All',
    'Beach',
    'Mountain',
    'City',
    'Desert',
    'Historical',
    'Adventure',
  ];

  List<Destination> _filteredDestinations = [];
  List<Destination> _recentSearches = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _filteredDestinations = featuredDestinations + trendingDestinations;
  }

  void _filterDestinations() {
    setState(() {
      _filteredDestinations = (featuredDestinations + trendingDestinations)
          .where((destination) {
        final matchesSearch = destination.name
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            destination.description
                .toLowerCase()
                .contains(_searchController.text.toLowerCase());

        final matchesCategory = _selectedCategory == 'All' ||
            destination.name.toLowerCase().contains(_selectedCategory.toLowerCase()) ||
            destination.description.toLowerCase().contains(_selectedCategory.toLowerCase());

        final matchesPrice = destination.price <= _priceRange;
        final matchesRating = destination.rating >= _ratingFilter;

        return matchesSearch && matchesCategory && matchesPrice && matchesRating;
      }).toList();
    });
  }

  void _addToRecentSearches(Destination destination) {
    if (!_recentSearches.contains(destination)) {
      setState(() {
        _recentSearches.insert(0, destination);
        if (_recentSearches.length > 5) {
          _recentSearches.removeLast();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search Header
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
                children: [
                  // Search Bar
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search destinations...',
                      prefixIcon: const Icon(Icons.search, color: Colors.red),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.filter_list),
                            onPressed: () {
                              setState(() {
                                _showFilters = !_showFilters;
                              });
                            },
                            color: _showFilters ? Colors.red : Colors.grey,
                          ),
                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _filterDestinations();
                            },
                          ),
                        ],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    onChanged: (_) => _filterDestinations(),
                  ),
                  const SizedBox(height: 16),
                  // Categories
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = category == _selectedCategory;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedCategory = category;
                                _filterDestinations();
                              });
                            },
                            backgroundColor: Colors.grey[100],
                            selectedColor: Colors.red.withOpacity(0.2),
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.red : Colors.black,
                              fontWeight: isSelected ? FontWeight.bold : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Filters
            if (_showFilters)
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filters',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _priceRange = 2000;
                              _ratingFilter = 0;
                              _filterDestinations();
                            });
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Price Range
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Max Price'),
                            Text(
                              '\$${_priceRange.toInt()}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: _priceRange,
                          min: 0,
                          max: 5000,
                          divisions: 50,
                          label: '\$${_priceRange.toInt()}',
                          onChanged: (value) {
                            setState(() {
                              _priceRange = value;
                              _filterDestinations();
                            });
                          },
                          activeColor: Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Rating Filter
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Min Rating'),
                            Text(
                              '${_ratingFilter.toStringAsFixed(1)} ⭐',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: _ratingFilter,
                          min: 0,
                          max: 5,
                          divisions: 10,
                          label: _ratingFilter.toStringAsFixed(1),
                          onChanged: (value) {
                            setState(() {
                              _ratingFilter = value;
                              _filterDestinations();
                            });
                          },
                          activeColor: Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Results
            Expanded(
              child: _searchController.text.isEmpty
                  ? Column(
                      children: [
                        TabBar(
                          controller: _tabController,
                          labelColor: Colors.red,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.red,
                          tabs: const [
                            Tab(text: 'Popular'),
                            Tab(text: 'Recent'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              // Popular Destinations
                              ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: featuredDestinations.length,
                                itemBuilder: (context, index) {
                                  final destination = featuredDestinations[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: DestinationCard(
                                      destination: destination,
                                      onTap: () {
                                        // Navigate to destination details
                                      },
                                    ),
                                  );
                                },
                              ),
                              // Recent Searches
                              _recentSearches.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.history,
                                            size: 64,
                                            color: Colors.grey[400],
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            'No recent searches',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      padding: const EdgeInsets.all(16),
                                      itemCount: _recentSearches.length,
                                      itemBuilder: (context, index) {
                                        final destination = _recentSearches[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 16),
                                          child: DestinationCard(
                                            destination: destination,
                                            onTap: () {
                                              // Navigate to destination details
                                            },
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : _filteredDestinations.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No destinations found',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredDestinations.length,
                          itemBuilder: (context, index) {
                            final destination = _filteredDestinations[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: GestureDetector(
                                onTap: () => _addToRecentSearches(destination),
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
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }
} 