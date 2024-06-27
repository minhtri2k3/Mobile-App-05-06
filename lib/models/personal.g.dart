// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Personal _$PersonalFromJson(Map<String, dynamic> json) => Personal(
      id: (json['id'] as num?)?.toInt(),
      Address: json['Address'] as String?,
      Age: json['Age'] as String?,
      Gender: json['Gender'] as String?,
    );

Map<String, dynamic> _$PersonalToJson(Personal instance) => <String, dynamic>{
      'id': instance.id,
      'Address': instance.Address,
      'Age': instance.Age,
      'Gender': instance.Gender,
    };
