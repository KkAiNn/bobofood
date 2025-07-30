import 'package:bobofood/utils/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapsController extends GetxController {
  MapsController();

  MapController mapController = MapController();

  late LatLng center;

  _initData() {
    update(["map"]);
  }

  void onTap() {}

  @override
  void onInit() {
    super.onInit();
    final position = LocationUtils.instance.currentLocation;
    center = LatLng(position?.latitude ?? 0, position?.longitude ?? 0);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  void onPositionChanged(LatLng position) {
    center = position;
  }

  void moveToCurrentLocation() {
    final position = LocationUtils.instance.currentLocation;
    if (position != null) {
      mapController.move(LatLng(position.latitude!, position.longitude!), 15);
    }
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
