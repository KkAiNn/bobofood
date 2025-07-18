// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

LocationModel locationModelFromJson(String str) =>
    LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  DateTime? callbackTime;
  DateTime? locationTime;
  int? locationType;
  double? latitude;
  double? longitude;
  double? accuracy;
  double? altitude;
  double? bearing;
  double? speed;
  String? country;
  String? province;
  String? city;
  String? district;
  String? street;
  String? streetNumber;
  String? cityCode;
  String? adCode;
  String? address;
  String? description;

  LocationModel({
    this.callbackTime,
    this.locationTime,
    this.locationType,
    this.latitude,
    this.longitude,
    this.accuracy,
    this.altitude,
    this.bearing,
    this.speed,
    this.country,
    this.province,
    this.city,
    this.district,
    this.street,
    this.streetNumber,
    this.cityCode,
    this.adCode,
    this.address,
    this.description,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    callbackTime:
        json["callbackTime"] == null
            ? null
            : DateTime.parse(json["callbackTime"]),
    locationTime:
        json["locationTime"] == null
            ? null
            : DateTime.parse(json["locationTime"]),
    locationType: json["locationType"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    accuracy: json["accuracy"]?.toDouble(),
    altitude: json["altitude"]?.toDouble(),
    bearing: json["bearing"]?.toDouble(),
    speed: json["speed"]?.toDouble(),
    country: json["country"],
    province: json["province"],
    city: json["city"],
    district: json["district"],
    street: json["street"],
    streetNumber: json["streetNumber"],
    cityCode: json["cityCode"],
    adCode: json["adCode"],
    address: json["address"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "callbackTime": callbackTime?.toIso8601String(),
    "locationTime": locationTime?.toIso8601String(),
    "locationType": locationType,
    "latitude": latitude,
    "longitude": longitude,
    "accuracy": accuracy,
    "altitude": altitude,
    "bearing": bearing,
    "speed": speed,
    "country": country,
    "province": province,
    "city": city,
    "district": district,
    "street": street,
    "streetNumber": streetNumber,
    "cityCode": cityCode,
    "adCode": adCode,
    "address": address,
    "description": description,
  };
}
