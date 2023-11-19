import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  bool? success;
  dynamic errorMsg;
  String? jwtToken;
  bool? transVirtualLinkIsAuthorized;
  String? currentClientName;
  String? currentClientShortName;
  String? transVirtualNumber;
  String? currentUserFirstName;
  String? currentUserLastName;
  String? currentUserShortName;
  dynamic warehouseTitle;
  dynamic idWarehouse;
  bool? trackStockViaStockReceive;

  UserData({
    this.success,
    this.errorMsg,
    this.jwtToken,
    this.transVirtualLinkIsAuthorized,
    this.currentClientName,
    this.currentClientShortName,
    this.transVirtualNumber,
    this.currentUserFirstName,
    this.currentUserLastName,
    this.currentUserShortName,
    this.warehouseTitle,
    this.idWarehouse,
    this.trackStockViaStockReceive,
  });

  UserData copyWith({
    bool? success,
    dynamic errorMsg,
    String? jwtToken,
    bool? transVirtualLinkIsAuthorized,
    String? currentClientName,
    String? currentClientShortName,
    String? transVirtualNumber,
    String? currentUserFirstName,
    String? currentUserLastName,
    String? currentUserShortName,
    dynamic warehouseTitle,
    dynamic idWarehouse,
    bool? trackStockViaStockReceive,
  }) =>
      UserData(
        success: success ?? this.success,
        errorMsg: errorMsg ?? this.errorMsg,
        jwtToken: jwtToken ?? this.jwtToken,
        transVirtualLinkIsAuthorized: transVirtualLinkIsAuthorized ?? this.transVirtualLinkIsAuthorized,
        currentClientName: currentClientName ?? this.currentClientName,
        currentClientShortName: currentClientShortName ?? this.currentClientShortName,
        transVirtualNumber: transVirtualNumber ?? this.transVirtualNumber,
        currentUserFirstName: currentUserFirstName ?? this.currentUserFirstName,
        currentUserLastName: currentUserLastName ?? this.currentUserLastName,
        currentUserShortName: currentUserShortName ?? this.currentUserShortName,
        warehouseTitle: warehouseTitle ?? this.warehouseTitle,
        idWarehouse: idWarehouse ?? this.idWarehouse,
        trackStockViaStockReceive: trackStockViaStockReceive ?? this.trackStockViaStockReceive,
      );

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    success: json["success"],
    errorMsg: json["errorMsg"],
    jwtToken: json["jwtToken"],
    transVirtualLinkIsAuthorized: json["transVirtualLinkIsAuthorized"],
    currentClientName: json["currentClientName"],
    currentClientShortName: json["currentClientShortName"],
    transVirtualNumber: json["transVirtualNumber"],
    currentUserFirstName: json["currentUserFirstName"],
    currentUserLastName: json["currentUserLastName"],
    currentUserShortName: json["currentUserShortName"],
    warehouseTitle: json["warehouseTitle"],
    idWarehouse: json["idWarehouse"],
    trackStockViaStockReceive: json["trackStockViaStockReceive"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "errorMsg": errorMsg,
    "jwtToken": jwtToken,
    "transVirtualLinkIsAuthorized": transVirtualLinkIsAuthorized,
    "currentClientName": currentClientName,
    "currentClientShortName": currentClientShortName,
    "transVirtualNumber": transVirtualNumber,
    "currentUserFirstName": currentUserFirstName,
    "currentUserLastName": currentUserLastName,
    "currentUserShortName": currentUserShortName,
    "warehouseTitle": warehouseTitle,
    "idWarehouse": idWarehouse,
    "trackStockViaStockReceive": trackStockViaStockReceive,
  };
}
