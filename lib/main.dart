import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_parking_app/screens/login_screen.dart';
import 'package:smart_parking_app/screens/home_screen.dart';
import 'package:smart_parking_app/services/auth_service.dart';
import 'package:smart_parking_app/services/booking_service.dart';
import 'package:smart_parking_app/services/parking_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: '.env'); // .env file is not present, commented out

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => AuthService()), // Changed to Provider
        Provider(create: (_) => BookingService()),
        Provider(create: (_) => ParkingService()),
      ],
      child: const SmartParkingApp(),
    ),
  );
}

class SmartParkingApp extends StatelessWidget {
  const SmartParkingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Parking App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, // Consider using kPrimaryColor from constants
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0077B6), // Consider using kPrimaryColor
          primary: const Color(0xFF0077B6),   // Consider using kPrimaryColor
          secondary: const Color(0xFF00B4D8), // Consider using kSecondaryColor
        ),
        fontFamily: 'Roboto', // Ensure this font is in pubspec.yaml and assets
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0077B6), // Consider using kPrimaryColor
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Consider kDefaultBorderRadius
            ),
          ),
        ),
      ),
      home: Consumer<AuthService>(
        builder: (context, authService, _) {
          // authService is guaranteed to be non-null here by the Consumer
          // when used with Provider(create: ...), unless the create function itself throws.
          return FutureBuilder<bool>(
            future: authService.isLoggedIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              // Handle potential error in snapshot
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text("Error checking login state: ${snapshot.error}")),
                );
              }

              final isLoggedIn = snapshot.data ?? false;
              return isLoggedIn ? const HomeScreen() : const LoginScreen();
            },
          );
        },
      ),
    );
  }
}