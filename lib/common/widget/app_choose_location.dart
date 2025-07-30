import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:bobofood/common/widget/app_map.dart';
import 'package:bobofood/common/widget/app_refresh_list_view.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:bobofood/common/widget/form/app_search.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/services/AMapPoiSearchService.dart';
import 'package:bobofood/utils/location.dart';
import 'package:bobofood/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AppChooseLocation extends StatefulWidget {
  const AppChooseLocation({super.key});

  @override
  State<AppChooseLocation> createState() => _AppChooseLocationState();
}

class _AppChooseLocationState extends State<AppChooseLocation> {
  MapController mapController = MapController();
  AppInputController poiSearchController = AppInputController();

  late ListController poiListController;
  LatLng center = LatLng(0, 0);
  @override
  void initState() {
    super.initState();
    final position = LocationUtils.instance.currentLocation;
    if (position != null) {
      center = LatLng(position.latitude!, position.longitude!);
    } else {
      LocationUtils.instance.getCurrentPosition().then((res) {
        center = LatLng(res?.latitude ?? 0, res?.longitude ?? 0);
      });
    }
    poiListController = ListController(
      onUpdate: () => setState(() {}),
      onFetch: onPoiSearch,
      autoInit: true,
      enablePullDown: false,
    );
  }

  String formatDistance(String distance) {
    if (double.parse(distance) < 1000) {
      return "${distance}m";
    } else {
      return "${(double.parse(distance) / 1000).toStringAsFixed(1)}km";
    }
  }

  void onPoiTap(Map<String, dynamic> poi) {
    final locations = poi['location'].split(',');
    center = LatLng(double.parse(locations[1]), double.parse(locations[0]));
    mapController.move(center, 15);
  }

  void moveToCurrentLocation() async {
    final position = await LocationUtils.instance.getCurrentPosition(
      mode: AMapLocationMode.Device_Sensors,
    );
    if (position != null) {
      center = LatLng(position.latitude!, position.longitude!);
      mapController.move(center, 15);
    }
  }

  void onPositionChanged(LatLng position) {
    center = position;
    Utils.throttle(() {
      poiListController.reload();
    }, Duration(milliseconds: 500));
  }

  Future<List<Map<String, dynamic>>> onPoiSearch(
    int page,
    int pageSize,
  ) async {
    final pois = await AMapPoiSearch.aroundSearch(
      keywords: poiSearchController.text,
      latitude: center.latitude,
      longitude: center.longitude,
      page: page,
      offset: pageSize,
    );
    return pois;
    // update(["amap"]);
  }

  @override
  Widget build(BuildContext context) {
    final Widget map = AppMap(
      mapController: mapController,
      center: center,
      onPositionChanged: onPositionChanged,
    );

    Widget buildPoiSearch() {
      return Padding(
        padding: EdgeInsets.all(12),
        child: AppSearchInput(
          controller: poiSearchController,
          hintText: '请输入地点',
          onChanged: (value) {
            poiSearchController.text = value;
            Utils.throttle(() {
              poiListController.reload();
            }, Duration(milliseconds: 500));
          },
          borderRadius: BorderRadius.circular(48),
        ),
      );
    }

    Widget buildPoiList() {
      return AppRefreshWrapper(
        controller: poiListController,
        itemBuilder: (context, item, index) {
          final item = poiListController.items[index];
          return ListTile(
            title: Text(item['name'] ?? ''),
            subtitle: Text(
              '${formatDistance(item['distance'])} | ${item['address'] ?? ''}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => onPoiTap(item),
          );
        },
      );
    }

    Widget buildCenterPoint() {
      return Positioned(
        right: 30,
        bottom: 30,
        child: TapEffect(
          onTap: moveToCurrentLocation,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
            ),
            child: Icon(Icons.location_on, color: Colors.grey),
          ),
        ),
      );
    }

    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                  child: Stack(children: [map, buildCenterPoint()]),
                ),
                Expanded(
                  child: SafeArea(
                    top: false,
                    bottom: true,
                    child: Column(
                      children: [
                        buildPoiSearch(),
                        Expanded(child: buildPoiList()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
