// lib/domain/entities/user_entity.dart
class UserEntity {
  final String id;
  final String fullName;
  final String email;
  final String? phoneNumber;
  final List<String> favoriteSpots;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.favoriteSpots = const [],
  });
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserEntity &&
      other.id == id &&
      other.fullName == fullName &&
      other.email == email &&
      other.phoneNumber == phoneNumber &&
      other.favoriteSpots.toString() == favoriteSpots.toString();
  }

  @override
  int get hashCode {
    return id.hashCode ^
      fullName.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      favoriteSpots.hashCode;
  }
}