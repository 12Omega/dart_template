// lib/data/models/parking_spot_model.dart
import '../../domain/entities/parking_spot_entity.dart';

class ParkingSpotModel extends ParkingSpotEntity {
  const ParkingSpotModel({
    required super.id,
    required super.name,
    required super.address,
    required super.latitude,
    required super.longitude,
    required super.capacity,
    required super.availableSpots,
    required super.rate,
    required super.openHours,
    required super.rating,
    required super.features,
  });

  factory ParkingSpotModel.fromJson(Map<String, dynamic> json) {
    return ParkingSpotModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      capacity: json['capacity'],
      availableSpots: json['availableSpots'],
      rate: json['rate'],
      openHours: json['openHours'],
      rating: json['rating'].toDouble(),
      features: (json['features'] as List<dynamic>?)
          ?.map((feature) => feature.toString())
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'capacity': capacity,
      'availableSpots': availableSpots,
      'rate': rate,
      'openHours': openHours,
      'rating': rating,
      'features': features,
    };
  }

  factory ParkingSpotModel.fromEntity(ParkingSpotEntity entity) {
    return ParkingSpotModel(
      id: entity.id,
      name: entity.name,
      address: entity.address,
      latitude: entity.latitude,
      longitude: entity.longitude,
      capacity: entity.capacity,
      availableSpots: entity.availableSpots,
      rate: entity.rate,
      openHours: entity.openHours,
      rating: entity.rating,
      features: entity.features,
    );
  }
}