import 'package:flutter/material.dart';
import 'package:travel_advisor/screens/splash_screen.dart';
import 'package:travel_advisor/screens/login_screen.dart';
import 'package:travel_advisor/screens/signup_screen.dart';
import 'package:travel_advisor/screens/otp_screen.dart';
import 'package:travel_advisor/screens/home_screen.dart';
import 'package:travel_advisor/screens/search_screen.dart';
import 'package:travel_advisor/screens/favorites_screen.dart';
import 'package:travel_advisor/screens/profile_screen.dart';
import 'package:travel_advisor/screens/book_tour_screen.dart';
import 'package:travel_advisor/screens/ticketing_screen.dart';
import 'package:travel_advisor/screens/accommodation_screen.dart';
import 'package:travel_advisor/screens/transportation_screen.dart';
import 'package:travel_advisor/screens/embassy_appointment_screen.dart';
import 'package:travel_advisor/screens/file_creation_screen.dart';
import 'package:travel_advisor/screens/required_documents_screen.dart';
import 'package:travel_advisor/screens/application_tracking_screen.dart';
import 'package:travel_advisor/screens/itinerary_screen.dart';
import 'package:travel_advisor/screens/custom_tour_screen.dart';
import 'package:travel_advisor/screens/currency_converter_screen.dart';
import 'package:travel_advisor/screens/ai_assistant_screen.dart';
import 'package:travel_advisor/screens/packing_list_screen.dart';
import 'package:travel_advisor/data/destinations.dart';
import 'package:travel_advisor/theme/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'screens/insurance_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ali Baba',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/otp': (context) => const OtpScreen(),
        '/main': (context) => const MainScreen(),
        '/book-tour': (context) => BookTourScreen(
          destinationName: featuredDestinations[0].name,
          destinationImage: featuredDestinations[0].image,
          price: featuredDestinations[0].price,
        ),
        '/ticketing': (context) => const TicketingScreen(),
        '/accommodation': (context) => const AccommodationScreen(),
        '/transportation': (context) => const TransportationScreen(),
        '/embassy-appointment': (context) => const EmbassyAppointmentScreen(),
        '/file-creation': (context) => const FileCreationScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isMenuOpen = false;
  bool _hasShownPromo = false;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ItineraryScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Show promo dialog after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!_hasShownPromo) {
        _showPromoDialog();
      }
    });
  }

  void _showPromoDialog() {
    setState(() {
      _hasShownPromo = true;
    });
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red.shade50,
                Colors.white,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close Button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              // Promo Image
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1469854523086-cc02fe5d8800'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Promo Title
              const Text(
                'Special Summer Offers!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              // Promo Description
              const Text(
                'Get up to 50% off on selected tours and travel packages. Limited time offer!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              // Promo Items
              Column(
                children: [
                  _buildPromoItem('Bali Paradise', '40% OFF', Icons.beach_access),
                  _buildPromoItem('Mountain Trek', '35% OFF', Icons.landscape),
                  _buildPromoItem('City Explorer', '30% OFF', Icons.location_city),
                ],
              ),
              const SizedBox(height: 20),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                    child: const Text('View All Deals'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookTourScreen(
                            destinationName: featuredDestinations[0].name,
                            destinationImage: featuredDestinations[0].image,
                            price: featuredDestinations[0].price,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Book Now'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoItem(String title, String discount, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.red),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              discount,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[_selectedIndex],
          if (_isMenuOpen)
            Positioned(
              right: 16,
              bottom: 80,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMenuButton(
                    'Insurance',
                    FontAwesomeIcons.shield,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const InsuranceScreen()),
                      );
                      _toggleMenu();
                    },
                  ),
                  _buildMenuButton(
                    'AI Assistant',
                    Icons.smart_toy,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AIAssistantScreen(),
                        ),
                      );
                      _toggleMenu();
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildMenuButton(
                    'Currency Converter',
                    Icons.currency_exchange,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CurrencyConverterScreen(),
                        ),
                      );
                      _toggleMenu();
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildMenuButton(
                    'Custom Tour',
                    Icons.tour_outlined,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomTourScreen(),
                        ),
                      );
                      _toggleMenu();
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildMenuButton(
                    'Book Tour',
                    Icons.airplanemode_active_outlined,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookTourScreen(
                            destinationName: featuredDestinations[0].name,
                            destinationImage: featuredDestinations[0].image,
                            price: featuredDestinations[0].price,
                          ),
                        ),
                      );
                      _toggleMenu();
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildMenuButton(
                    'Ticketing',
                    Icons.airplane_ticket_outlined,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TicketingScreen(),
                        ),
                      );
                      _toggleMenu();
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildMenuButton(
                    'Accommodation',
                    Icons.hotel_outlined,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccommodationScreen(),
                        ),
                      );
                      _toggleMenu();
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildMenuButton(
                    'Transportation',
                    Icons.directions_bus_outlined,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TransportationScreen(),
                        ),
                      );
                      _toggleMenu();
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildMenuButton(
                    'Embassy Appointment',
                    Icons.assignment_outlined,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmbassyAppointmentScreen(),
                        ),
                      );
                      _toggleMenu();
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildMenuButton(
                    'File Creation',
                    Icons.create_new_folder_outlined,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FileCreationScreen(),
                        ),
                      );
                      _toggleMenu();
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildMenuButton(
                    'Packing List',
                    Icons.backpack_outlined,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PackingListScreen(),
                        ),
                      );
                      _toggleMenu();
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Itinerary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleMenu,
        backgroundColor: Colors.red,
        child: Icon(
          _isMenuOpen ? Icons.close : Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(28),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.red),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 