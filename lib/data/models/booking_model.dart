// lib/data/models/booking_model.dart
import '../../domain/entities/booking_entity.dart';

class BookingModel extends BookingEntity {
  const BookingModel({
    required super.id,
    required super.parkingSpotId,
    required super.parkingSpotName,
    required super.startTime,
    required super.endTime,
    required super.vehicleType,
    required super.vehiclePlate,
    required super.amount,
    required super.status,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      parkingSpotId: json['parkingSpotId'],
      parkingSpotName: json['parkingSpotName'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      vehicleType: json['vehicleType'],
      vehiclePlate: json['vehiclePlate'],
      amount: json['amount'].toDouble(),
      status: _parseBookingStatus(json['status']),
    );
  }

  static BookingStatus _parseBookingStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return BookingStatus.pending;
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'cancelled':
        return BookingStatus.cancelled;
      case 'completed':
        return BookingStatus.completed;
      default:
        return BookingStatus.pending;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parkingSpotId': parkingSpotId,
      'parkingSpotName': parkingSpotName,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'vehicleType': vehicleType,
      'vehiclePlate': vehiclePlate,
      'amount': amount,
      'status': status.toString().split('.').last,
    };
  }

  factory BookingModel.fromEntity(BookingEntity entity) {
    return BookingModel(
      id: entity.id,
      parkingSpotId: entity.parkingSpotId,
      parkingSpotName: entity.parkingSpotName,
      startTime: entity.startTime,
      endTime: entity.endTime,
      vehicleType: entity.vehicleType,
      vehiclePlate: entity.vehiclePlate,
      amount: entity.amount,
      status: entity.status,
    );
  }
}