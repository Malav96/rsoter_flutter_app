import 'package:flutter/foundation.dart';
import 'Staff.dart';

@immutable
class StaffResponse {
  const StaffResponse({
    required this.result,
  });

  final List<Staff> result;

  factory StaffResponse.fromJson(Map<String, dynamic> json) => StaffResponse(
      result: (json['result'] as List? ?? [])
          .map((e) => Staff.fromJson(e))
          .toList());

  Map<String, dynamic> toJson() =>
      {'result': result.map((e) => e.toJson()).toList()};

  StaffResponse clone() => StaffResponse(result: result.toList());

  StaffResponse copyWith({List<Staff>? result}) => StaffResponse(
        result: result ?? this.result,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StaffResponse && result == other.result;

  @override
  int get hashCode => result.hashCode;
}
