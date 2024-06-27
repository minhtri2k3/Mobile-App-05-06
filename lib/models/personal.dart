import 'package:json_annotation/json_annotation.dart';

part 'personal.g.dart';

@JsonSerializable()
class Personal {
  final int? id;
  final String? Address; // Change 'Address' to 'address'
  final String? Age;     // Change 'Age' to 'age'
  final String? Gender;  // Change 'Gender' to 'gender'

  Personal({
    required this.id,
    required this.Address,
    required this.Age,
    required this.Gender,
  });

  factory Personal.fromJson(Map<String, dynamic> json) => _$PersonalFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalToJson(this);
}
