import 'dart:convert';
import 'package:latlong2/latlong.dart';

class DeliveryRouteModel {
  final String id;
  final String name;
  final String description;
  final List<LatLng> waypoints;
  final double distance; // 以公里为单位
  final int estimatedTime; // 以分钟为单位
  final bool isActive;

  DeliveryRouteModel({
    required this.id,
    required this.name,
    required this.description,
    required this.waypoints,
    required this.distance,
    required this.estimatedTime,
    this.isActive = true,
  });

  factory DeliveryRouteModel.fromJson(String str) =>
      DeliveryRouteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeliveryRouteModel.fromMap(Map<String, dynamic> json) =>
      DeliveryRouteModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        waypoints: List<LatLng>.from(json["waypoints"]
            .map((x) => LatLng(x["latitude"], x["longitude"]))),
        distance: json["distance"]?.toDouble(),
        estimatedTime: json["estimatedTime"],
        isActive: json["isActive"] ?? true,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "waypoints": waypoints
            .map((x) => {"latitude": x.latitude, "longitude": x.longitude})
            .toList(),
        "distance": distance,
        "estimatedTime": estimatedTime,
        "isActive": isActive,
      };

  DeliveryRouteModel copyWith({
    String? id,
    String? name,
    String? description,
    List<LatLng>? waypoints,
    double? distance,
    int? estimatedTime,
    bool? isActive,
  }) {
    return DeliveryRouteModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      waypoints: waypoints ?? this.waypoints,
      distance: distance ?? this.distance,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      isActive: isActive ?? this.isActive,
    );
  }
}
