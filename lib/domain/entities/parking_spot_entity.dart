// lib/domain/entities/parking_spot_entity.dart
import 'dart:math' as math;

class ParkingSpotEntity {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final int capacity;
  final int availableSpots;
  final String rate;
  final String openHours;
  final double rating;
  final List<String> features;

  const ParkingSpotEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.capacity,
    required this.availableSpots,
    required this.rate,
    required this.openHours,
    required this.rating,
    required this.features,
  });

  // Calculate distance from current position
  double distanceFrom(double lat, double lng) {
    // Simple Euclidean distance for demo purposes
    // In a real app, use the Haversine formula or a Maps API
    return _calculateDistance(latitude, longitude, lat, lng);
  }

  // Helper method to calculate distance using Haversine formula
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // in kilometers

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    // Haversine formula
    // a = sin²(Δφ/2) + cos φ1 ⋅ cos φ2 ⋅ sin²(Δλ/2)
    // c = 2 ⋅ atan2( √a, √(1−a) )
    // d = R ⋅ c
    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) * math.cos(_toRadians(lat2)) *
            math.sin(dLon / 2) * math.sin(dLon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c; // Distance in km
  }

  double _toRadians(double degree) {
    return degree * (math.pi / 180);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ParkingSpotEntity &&
        other.id == id &&
        other.name == name &&
        other.address == address &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    name.hashCode ^
    address.hashCode ^
    latitude.hashCode ^
    longitude.hashCode;
  }
}