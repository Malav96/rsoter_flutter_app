import 'package:flutter/foundation.dart';


@immutable
class ApiErrorResponse {

  const ApiErrorResponse({
    required this.exception,
  });

  final String exception;

  factory ApiErrorResponse.fromJson(Map<String,dynamic> json) => ApiErrorResponse(
    exception: json['exception'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'exception': exception
  };

  ApiErrorResponse clone() => ApiErrorResponse(
    exception: exception
  );


  ApiErrorResponse copyWith({
    String? exception
  }) => ApiErrorResponse(
    exception: exception ?? this.exception,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is ApiErrorResponse && exception == other.exception;

  @override
  int get hashCode => exception.hashCode;
}
