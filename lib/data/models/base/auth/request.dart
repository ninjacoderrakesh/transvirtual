// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'dart:convert';

LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  String? username;
  String? password;
  DeviceDetails? deviceDetails;

  LoginRequest({
    this.username,
    this.password,
    this.deviceDetails,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
    username: json["username"],
    password: json["password"],
    deviceDetails: json["deviceDetails"] == null ? null : DeviceDetails.fromJson(json["deviceDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "deviceDetails": deviceDetails?.toJson(),
  };
}

class DeviceDetails {
  String? deviceManufacturer;
  String? deviceName;
  String? versionSource;
  String? deviceSerial;
  int? currentVersion;
  String? fcmToken;

  DeviceDetails({
    this.deviceManufacturer,
    this.deviceName,
    this.versionSource,
    this.deviceSerial,
    this.currentVersion,
    this.fcmToken,
  });

  factory DeviceDetails.fromJson(Map<String, dynamic> json) => DeviceDetails(
    deviceManufacturer: json["deviceManufacturer"],
    deviceName: json["deviceName"],
    versionSource: json["versionSource"],
    deviceSerial: json["deviceSerial"],
    currentVersion: json["currentVersion"],
    fcmToken: json["fcmToken"],
  );

  Map<String, dynamic> toJson() => {
    "deviceManufacturer": deviceManufacturer,
    "deviceName": deviceName,
    "versionSource": versionSource,
    "deviceSerial": deviceSerial,
    "currentVersion": currentVersion,
    "fcmToken": fcmToken,
  };
}
