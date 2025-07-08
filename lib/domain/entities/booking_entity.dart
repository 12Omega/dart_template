// lib/domain/entities/booking_entity.dart
enum BookingStatus {
  pending,
  confirmed,
  cancelled,
  completed
}

class BookingEntity {
  final String id;
  final String parkingSpotId;
  final String parkingSpotName;
  final DateTime startTime;
  final DateTime endTime;
  final String vehicleType;
  final String vehiclePlate;
  final double amount;
  final BookingStatus status;

  const BookingEntity({
    required this.id,
    required this.parkingSpotId,
    required this.parkingSpotName,
    required this.startTime,
    required this.endTime,
    required this.vehicleType,
    required this.vehiclePlate,
    required this.amount,
    required this.status,
  });
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BookingEntity &&
      other.id == id &&
      other.parkingSpotId == parkingSpotId &&
      other.startTime == startTime &&
      other.endTime == endTime &&
      other.vehicleType == vehicleType &&
      other.vehiclePlate == vehiclePlate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      parkingSpotId.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      vehicleType.hashCode ^
      vehiclePlate.hashCode;
  }
}