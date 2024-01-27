import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

part 'user_model.g.dart';

@RestApi(baseUrl: "https://qutb.uz/api/auth")
abstract class RestUser {
  factory RestUser(Dio dio) = _RestUser;

  @POST("/login")
  Future<Response<dynamic>> signIn(String firstName, String password);

  @POST("/register")
  Future<Response<dynamic>> signUp(
    String firstName,
    String lastName,
    String phone,
    String password,
  );
}

@JsonSerializable()
class UserModel {
  String firstName;
  String lastName;
  String phone;
  Object? emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : emailVerifiedAt = null,
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  UserModel copyWith(
    String? firstName,
    String? lastName,
    String? phone,
    Object? emailVerifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  ) =>
      UserModel(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);

  Map<String, Object?> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel{firstName: $firstName, lastName: $lastName, phone: $phone, emailVerifiedAt: $emailVerifiedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          phone == other.phone &&
          emailVerifiedAt == other.emailVerifiedAt &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      firstName.hashCode ^
      lastName.hashCode ^
      phone.hashCode ^
      emailVerifiedAt.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
