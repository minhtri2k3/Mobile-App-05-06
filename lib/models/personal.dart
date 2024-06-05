import 'package:json_annotation/json_annotation.dart';

part 'personal.g.dart';

@JsonSerializable()
class Personal {
  final int? id;

  final String? address; // Change 'Address' to 'address'
  final String? age;     // Change 'Age' to 'age'
  final String? gender;  // Change 'Gender' to 'gender'

  Personal({
    required this.id,
    required this.address,
    required this.age,
    required this.gender,
  });

  factory Personal.fromJson(Map<String, dynamic> json) => _$PersonalFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalToJson(this);
}
