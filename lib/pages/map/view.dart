import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/common/widget/app_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class MapPage extends GetView<MapsController> {
  const MapPage({super.key});

  // 主视图
  Widget _buildView() {
    return Stack(
      children: [
        AppMap(
          center: controller.center,
          mapController: controller.mapController,
        ),
        Positioned(
          bottom: 80,
          right: 20,
          child: TapEffect(
            onTap: () {
              controller.moveToCurrentLocation();
            },
            child: Container(
              height: 42,
              width: 42,
              color: Colors.white,
              child: Icon(Icons.location_on_outlined),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapsController>(
      init: MapsController(),
      id: "map",
      builder: (_) {
        return Scaffold(
          body: _buildView(),
        );
      },
    );
  }
}
