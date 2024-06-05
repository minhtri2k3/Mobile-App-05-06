// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Personal _$PersonalFromJson(Map<String, dynamic> json) => Personal(
      id: (json['id'] as num?)?.toInt(),
      address: json['address'] as String?,
      age: json['age'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$PersonalToJson(Personal instance) => <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'age': instance.age,
      'gender': instance.gender,
    };
