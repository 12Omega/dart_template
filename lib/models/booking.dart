// lib/models/booking.dart
import 'dart:convert';

enum BookingStatus {
  pending,
  confirmed,
  cancelled,
  completed
}

class Booking {
  final String id;
  final String parkingSpotId;
  final String parkingSpotName;
  final DateTime startTime;
  final DateTime endTime;
  final String vehicleType;
  final String vehiclePlate;
  final double amount;
  final BookingStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Booking({
    required this.id,
    required this.parkingSpotId,
    required this.parkingSpotName,
    required this.startTime,
    required this.endTime,
    required this.vehicleType,
    required this.vehiclePlate,
    required this.amount,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
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
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] ?? map['_id']?.toString() ?? '',
      parkingSpotId: map['parkingSpotId'] ?? '',
      parkingSpotName: map['parkingSpotName'] ?? '',
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      vehicleType: map['vehicleType'] ?? '',
      vehiclePlate: map['vehiclePlate'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      status: _parseStatus(map['status']),
      createdAt: map['createdAt'] != null 
        ? DateTime.parse(map['createdAt']) 
        : DateTime.now(),
      updatedAt: map['updatedAt'] != null 
        ? DateTime.parse(map['updatedAt']) 
        : null,
    );
  }

  static BookingStatus _parseStatus(String? status) {
    if (status == null) return BookingStatus.pending;
    
    switch (status.toLowerCase()) {
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'cancelled':
        return BookingStatus.cancelled;
      case 'completed':
        return BookingStatus.completed;
      case 'pending':
      default:
        return BookingStatus.pending;
    }
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) => Booking.fromMap(json.decode(source));

  Booking copyWith({
    String? id,
    String? parkingSpotId,
    String? parkingSpotName,
    DateTime? startTime,
    DateTime? endTime,
    String? vehicleType,
    String? vehiclePlate,
    double? amount,
    BookingStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Booking(
      id: id ?? this.id,
      parkingSpotId: parkingSpotId ?? this.parkingSpotId,
      parkingSpotName: parkingSpotName ?? this.parkingSpotName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      vehicleType: vehicleType ?? this.vehicleType,
      vehiclePlate: vehiclePlate ?? this.vehiclePlate,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Booking(id: $id, parkingSpotId: $parkingSpotId, parkingSpotName: $parkingSpotName, startTime: $startTime, endTime: $endTime, vehicleType: $vehicleType, vehiclePlate: $vehiclePlate, amount: $amount, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}