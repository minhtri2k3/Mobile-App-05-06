import 'package:json_annotation/json_annotation.dart';
import 'personal.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? password;
  final Personal? personal;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.personal
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
