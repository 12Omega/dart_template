// lib/domain/repositories/booking_repository.dart
import 'dart:async';
import '../entities/booking_entity.dart';

abstract class BookingRepository {
  // Booking management methods
  Future<BookingEntity> createBooking({
    required String parkingSpotId,
    required String parkingSpotName,
    required DateTime startTime,
    required DateTime endTime,
    required String vehicleType,
    required String vehiclePlate,
    required double amount,
  });
  
  Future<List<BookingEntity>> getUserBookings();
  Future<BookingEntity> getBookingById(String id);
  Future<void> updateBookingStatus(String id, BookingStatus status);
  Future<void> cancelBooking(String id);
  
  // Payment related methods
  Future<bool> processPayment(String bookingId, String paymentMethod, {Map<String, dynamic>? paymentDetails});
  Future<double> calculateBookingAmount(String spotId, DateTime startTime, DateTime endTime);
  
  // Analytics methods
  Future<Map<String, dynamic>> getBookingStatistics(DateTime startDate, DateTime endDate);
}