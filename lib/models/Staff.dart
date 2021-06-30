import 'package:flutter/foundation.dart';


@immutable
class Staff {

  const Staff({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.yourNumber,
    required this.avatar,
  });

  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String yourNumber;
  final String avatar;

  factory Staff.fromJson(Map<String,dynamic> json) => Staff(
    id: json['id'] as int,
    email: json['email'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    yourNumber: json['yourNumber'] as String,
    avatar: json['avatar'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'yourNumber': yourNumber,
    'avatar': avatar
  };

  Staff clone() => Staff(
    id: id,
    email: email,
    firstName: firstName,
    lastName: lastName,
    yourNumber: yourNumber,
    avatar: avatar
  );


  Staff copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? yourNumber,
    String? avatar
  }) => Staff(
    id: id ?? this.id,
    email: email ?? this.email,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    yourNumber: yourNumber ?? this.yourNumber,
    avatar: avatar ?? this.avatar,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Staff && id == other.id && email == other.email && firstName == other.firstName && lastName == other.lastName && yourNumber == other.yourNumber && avatar == other.avatar;

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ firstName.hashCode ^ lastName.hashCode ^ yourNumber.hashCode ^ avatar.hashCode;
}
