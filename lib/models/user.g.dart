// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      password: json['password'] as String?,
      isActive: json['isActive'] as bool?,
      personal: json['personal'] == null
          ? null
          : Personal.fromJson(json['personal'] as Map<String, dynamic>),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'password': instance.password,
      'isActive': instance.isActive,
      'personal': instance.personal?.toJson(),
      'email': instance.email,
    };
