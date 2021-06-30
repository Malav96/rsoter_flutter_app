import 'package:flutter/foundation.dart';


@immutable
class LoginResponse {

  const LoginResponse({
    required this.sid,
    required this.accountType,
    required this.userInfo,
  });

  final String sid;
  final String accountType;
  final UserInfo userInfo;

  factory LoginResponse.fromJson(Map<String,dynamic> json) => LoginResponse(
    sid: json['sid'] as String,
    accountType: json['accountType'] as String,
    userInfo: UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>)
  );
  
  Map<String, dynamic> toJson() => {
    'sid': sid,
    'accountType': accountType,
    'userInfo': userInfo.toJson()
  };

  LoginResponse clone() => LoginResponse(
    sid: sid,
    accountType: accountType,
    userInfo: userInfo.clone()
  );


  LoginResponse copyWith({
    String? sid,
    String? accountType,
    UserInfo? userInfo
  }) => LoginResponse(
    sid: sid ?? this.sid,
    accountType: accountType ?? this.accountType,
    userInfo: userInfo ?? this.userInfo,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is LoginResponse && sid == other.sid && accountType == other.accountType && userInfo == other.userInfo;

  @override
  int get hashCode => sid.hashCode ^ accountType.hashCode ^ userInfo.hashCode;
}

@immutable
class UserInfo {

  const UserInfo({
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.email,
    required this.dateOfBirth,
    required this.avatar,
    required this.pushNotificationSettings,
  });

  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String email;
  final String dateOfBirth;
  final String avatar;
  final PushNotificationSettings pushNotificationSettings;

  factory UserInfo.fromJson(Map<String,dynamic> json) => UserInfo(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    mobileNumber: json['mobileNumber'] as String,
    email: json['email'] as String,
    dateOfBirth: json['dateOfBirth'] as String,
    avatar: json['avatar'] as String,
    pushNotificationSettings: PushNotificationSettings.fromJson(json['pushNotificationSettings'] as Map<String, dynamic>)
  );
  
  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'mobileNumber': mobileNumber,
    'email': email,
    'dateOfBirth': dateOfBirth,
    'avatar': avatar,
    'pushNotificationSettings': pushNotificationSettings.toJson()
  };

  UserInfo clone() => UserInfo(
    firstName: firstName,
    lastName: lastName,
    mobileNumber: mobileNumber,
    email: email,
    dateOfBirth: dateOfBirth,
    avatar: avatar,
    pushNotificationSettings: pushNotificationSettings.clone()
  );


  UserInfo copyWith({
    String? firstName,
    String? lastName,
    String? mobileNumber,
    String? email,
    String? dateOfBirth,
    String? avatar,
    PushNotificationSettings? pushNotificationSettings
  }) => UserInfo(
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    mobileNumber: mobileNumber ?? this.mobileNumber,
    email: email ?? this.email,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    avatar: avatar ?? this.avatar,
    pushNotificationSettings: pushNotificationSettings ?? this.pushNotificationSettings,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is UserInfo && firstName == other.firstName && lastName == other.lastName && mobileNumber == other.mobileNumber && email == other.email && dateOfBirth == other.dateOfBirth && avatar == other.avatar && pushNotificationSettings == other.pushNotificationSettings;

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode ^ mobileNumber.hashCode ^ email.hashCode ^ dateOfBirth.hashCode ^ avatar.hashCode ^ pushNotificationSettings.hashCode;
}

@immutable
class PushNotificationSettings {

  const PushNotificationSettings({
    required this.isRosterNotificationsOn,
    required this.isShiftNotificationsOn,
    required this.isLeaveNotificationsOn,
    required this.isShiftSwapNotificationsOn,
  });

  final bool isRosterNotificationsOn;
  final bool isShiftNotificationsOn;
  final bool isLeaveNotificationsOn;
  final bool isShiftSwapNotificationsOn;

  factory PushNotificationSettings.fromJson(Map<String,dynamic> json) => PushNotificationSettings(
    isRosterNotificationsOn: json['isRosterNotificationsOn'] as bool,
    isShiftNotificationsOn: json['isShiftNotificationsOn'] as bool,
    isLeaveNotificationsOn: json['isLeaveNotificationsOn'] as bool,
    isShiftSwapNotificationsOn: json['isShiftSwapNotificationsOn'] as bool
  );
  
  Map<String, dynamic> toJson() => {
    'isRosterNotificationsOn': isRosterNotificationsOn,
    'isShiftNotificationsOn': isShiftNotificationsOn,
    'isLeaveNotificationsOn': isLeaveNotificationsOn,
    'isShiftSwapNotificationsOn': isShiftSwapNotificationsOn
  };

  PushNotificationSettings clone() => PushNotificationSettings(
    isRosterNotificationsOn: isRosterNotificationsOn,
    isShiftNotificationsOn: isShiftNotificationsOn,
    isLeaveNotificationsOn: isLeaveNotificationsOn,
    isShiftSwapNotificationsOn: isShiftSwapNotificationsOn
  );


  PushNotificationSettings copyWith({
    bool? isRosterNotificationsOn,
    bool? isShiftNotificationsOn,
    bool? isLeaveNotificationsOn,
    bool? isShiftSwapNotificationsOn
  }) => PushNotificationSettings(
    isRosterNotificationsOn: isRosterNotificationsOn ?? this.isRosterNotificationsOn,
    isShiftNotificationsOn: isShiftNotificationsOn ?? this.isShiftNotificationsOn,
    isLeaveNotificationsOn: isLeaveNotificationsOn ?? this.isLeaveNotificationsOn,
    isShiftSwapNotificationsOn: isShiftSwapNotificationsOn ?? this.isShiftSwapNotificationsOn,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is PushNotificationSettings && isRosterNotificationsOn == other.isRosterNotificationsOn && isShiftNotificationsOn == other.isShiftNotificationsOn && isLeaveNotificationsOn == other.isLeaveNotificationsOn && isShiftSwapNotificationsOn == other.isShiftSwapNotificationsOn;

  @override
  int get hashCode => isRosterNotificationsOn.hashCode ^ isShiftNotificationsOn.hashCode ^ isLeaveNotificationsOn.hashCode ^ isShiftSwapNotificationsOn.hashCode;
}
