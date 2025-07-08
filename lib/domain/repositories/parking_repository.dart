// lib/domain/repositories/parking_repository.dart
import 'dart:async';
import '../entities/parking_spot_entity.dart';

abstract class ParkingRepository {
  // Parking spot retrieval methods
  Future<List<ParkingSpotEntity>> getNearbyParkingSpots(double latitude, double longitude, {double radius = 5.0});
  Future<ParkingSpotEntity> getParkingSpotById(String id);
  Future<List<ParkingSpotEntity>> searchParkingSpots(String query);
  
  // Real-time availability
  Stream<ParkingSpotEntity> getParkingSpotUpdates(String spotId);
  Future<int> getAvailableSpotsCount(String spotId);
  
  // Filtering and sorting methods
  Future<List<ParkingSpotEntity>> getParkingSpotsByFilter({
    double? minRating,
    List<String>? requiredFeatures,
    String? sortBy, // 'distance', 'price', 'rating'
    bool? ascending,
  });
}