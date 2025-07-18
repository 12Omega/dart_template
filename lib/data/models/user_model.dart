// lib/data/models/user_model.dart
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    super.phoneNumber,
    super.favoriteSpots = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      favoriteSpots: (json['favoriteSpots'] as List<dynamic>?)
          ?.map((spot) => spot.toString())
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'favoriteSpots': favoriteSpots,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      fullName: entity.fullName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      favoriteSpots: entity.favoriteSpots,
    );
  }
}