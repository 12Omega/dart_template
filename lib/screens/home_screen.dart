import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_parking_app/screens/history_screen.dart';
import 'package:smart_parking_app/screens/login_screen.dart';
import 'package:smart_parking_app/screens/map_screen.dart';
import 'package:smart_parking_app/services/auth_service.dart';
import 'package:smart_parking_app/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      if (!mounted) return;
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.logout();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<AuthService>(context).currentUserData; // Example if needed here

    return Scaffold(
      appBar: _selectedIndex == 2
          ? AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _logout,
          ),
        ],
      )
          : AppBar(
        title: Text(_selectedIndex == 0 ? 'Find Parking' : 'My Bookings'),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          MapScreen(),
          HistoryScreen(),
          _ProfileScreen(),
        ],
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Find Parking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  @override
  Widget build(BuildContext context) {
    // Use watch or select for more fine-grained rebuilds if AuthService were a ChangeNotifier
    final authService = Provider.of<AuthService>(context, listen: false);
    final userData = authService.currentUserData;

    if (userData == null) {
      // This case should ideally be handled by FutureBuilder or StreamBuilder if user loading is async
      // Or if authService.currentUserData can truly be null after initial load.
      // For placeholder, we might see this briefly or if logout occurs.
      return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('User data not available.'),
              SizedBox(height: 10),
              Text('You might be logged out.'),
              // Optionally, add a button to go to login
              // ElevatedButton(onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen())), child: Text("Login"))
            ],
          )
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: kPrimaryColor, // Make sure kPrimaryColor is imported/defined
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  userData['fullName'] ?? 'N/A', // Access data using keys
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userData['email'] ?? 'N/A', // Access data using keys
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Account Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _ProfileMenuItem(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () {
              // TODO: Navigate to edit profile screen
            },
          ),
          _ProfileMenuItem(
            icon: Icons.credit_card,
            title: 'Payment Methods',
            onTap: () {
              // TODO: Navigate to payment methods screen
            },
          ),
          _ProfileMenuItem(
            icon: Icons.car_rental,
            title: 'My Vehicles',
            onTap: () {
              // TODO: Navigate to vehicles screen
            },
          ),
          _ProfileMenuItem(
            icon: Icons.settings_outlined,
            title: 'App Settings',
            onTap: () {
              // TODO: Navigate to app settings screen
            },
          ),
          _ProfileMenuItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              // TODO: Navigate to help screen
            },
          ),
          _ProfileMenuItem(
            icon: Icons.exit_to_app,
            title: 'Logout',
            onTap: () async {
              await Provider.of<AuthService>(context, listen: false).logout();
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kPrimaryColor),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}