// lib/services/parking_service.dart
import 'package:smart_parking_app/models/parking_spot.dart'; // Assuming ParkingSpot model exists

class ParkingService {
  // Placeholder for fetching all parking spots
  Future<List<ParkingSpot>> getAllParkingSpots() async {
    // In a real app, you'd call your backend API
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // TODO: Replace with actual API call and data parsing
    // Return mock data for now
    return [
      ParkingSpot(
        id: 'ps1',
        name: 'City Center Parking',
        address: '123 Main St, Anytown',
        latitude: 37.7749, // Example coordinates (San Francisco)
        longitude: -122.4194,
        capacity: 100,
        availableSpots: 75,
        rate: 'Rs. 50/hr',
        openHours: '24 hours',
        rating: 4.5,
        features: ['CCTV', 'Covered', 'Security'],
        updatedAt: DateTime.now(),
      ),
      ParkingSpot(
        id: 'ps2',
        name: 'Uptown Garage',
        address: '456 Oak Ave, Anytown',
        latitude: 37.7850, // Example coordinates
        longitude: -122.4295,
        capacity: 200,
        availableSpots: 150,
        rate: 'Rs. 60/hr',
        openHours: '6 AM - 10 PM',
        rating: 4.2,
        features: ['EV Charging', 'Covered'],
        updatedAt: DateTime.now(),
      ),
      ParkingSpot(
        id: 'ps3',
        name: 'Downtown Lot C',
        address: '789 Pine St, Anytown',
        latitude: 37.7700, // Example coordinates
        longitude: -122.4100,
        capacity: 50,
        availableSpots: 10,
        rate: 'Rs. 40/hr',
        openHours: 'Mon-Fri 8 AM - 6 PM',
        rating: 3.8,
        features: ['Outdoor'],
        updatedAt: DateTime.now(),
      ),
    ];
  }

  // Placeholder for fetching parking spots near a location
  Future<List<ParkingSpot>> getNearbyParkingSpots(double latitude, double longitude, double radius) async {
    await Future.delayed(const Duration(seconds: 1));
    // In a real app, the backend would handle this query.
    // For now, filter the mock data (very simplified).
    final allSpots = await getAllParkingSpots();
    return allSpots.where((spot) {
      // Extremely naive distance calculation for placeholder
      final latDiff = (spot.latitude - latitude).abs();
      final lonDiff = (spot.longitude - longitude).abs();
      // This is NOT a real distance calculation, just for placeholder filtering
      return latDiff < (radius * 0.01) && lonDiff < (radius * 0.01);
    }).toList();
  }

  // Placeholder for fetching details of a specific parking spot
  Future<ParkingSpot?> getParkingSpotDetails(String spotId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final allSpots = await getAllParkingSpots();
    try {
      return allSpots.firstWhere((spot) => spot.id == spotId);
    } catch (e) {
      return null; // Not found
    }
  }
}
