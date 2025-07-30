import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AppMap extends StatelessWidget {
  const AppMap({
    super.key,
    required this.mapController,
    required this.center,
    this.onPositionChanged,
    this.markers,
    this.polylines,
  });

  final LatLng center;
  final MapController mapController;
  final Function(LatLng)? onPositionChanged;
  final List<Marker>? markers;
  final List<Polyline>? polylines;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: center,
        initialZoom: 15.0,
        maxZoom: 18.0,
        minZoom: 12.0,
        onPositionChanged: (camera, hasGesture) {
          onPositionChanged?.call(camera.center);
        },
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://webrd04.is.autonavi.com/appmaptile?lang=zh_cn&size=1&scale=1&style=8&x={x}&y={y}&z={z}',
          userAgentPackageName: 'com.example.bobofood',
          tileProvider: NetworkTileProvider(),
        ),
        // 添加自定义路线
        if (polylines != null && polylines!.isNotEmpty)
          PolylineLayer(
            polylines: polylines!,
          ),
        // 添加自定义标记或默认标记
        MarkerLayer(
          markers: markers ??
              [
                Marker(
                  point: center,
                  width: 40,
                  height: 40,
                  child: Icon(Icons.location_on_outlined,
                      color: Colors.deepOrangeAccent, size: 28),
                ),
              ],
        ),
      ],
    );
  }
}
