import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/pages/main/widgets/custom_nav_bottom.dart';
import 'package:bobofood/pages/user/view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:bobofood/common/widget/pop_scope.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _MainAppViewGetX();
  }
}

class _MainAppViewGetX extends GetView<MainController> {
  const _MainAppViewGetX();

  Widget _buildView() {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: Container(
        padding: EdgeInsets.only(right: 12.w),
        child: UserPage(
          onThemeChange: controller.onThemeChange,
        ),
      ),
      drawerEdgeDragWidth: 80,
      drawerEnableOpenDragGesture: true,
      drawerDragStartBehavior: DragStartBehavior.down,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        children: controller.items.map<Widget>((item) => item.page).toList(),
      ),
      bottomNavigationBar: CustomNavBottom(
        items: controller.items,
        currentIndex: controller.selectedIndex,
        onTap: controller.jumpToPage,
        backgroundColor: AppColors.colors.background.elementBackground,
        selectedItemColor: AppColors.colors.icon.primary,
        unselectedItemColor: AppColors.colors.icon.defaultColor,
        showLabels: false,
        iconSize: 32.0,
        enableShadow: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      id: "MainApp",
      builder: (_) {
        return AppPopScope(child: _buildView());
      },
    );
  }
}
