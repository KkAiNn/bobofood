import 'package:bobofood/common/widget/app_refresh_list_view.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/pages/product/widget/product_landscape.dart';
import 'package:bobofood/pages/tabbar/widget/empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class FavouritesPage extends GetView<FavouritesController> {
  const FavouritesPage({super.key});

  Widget _buildProductList() {
    return AppRefreshWrapper(
      padding: EdgeInsets.only(top: 16.w, left: 20.w, right: 20.w),
      controller: controller.listController,
      separator: SizedBox(height: 12.h),
      itemBuilder: (context, item, index) {
        return TapEffect(
            onTap: () {
              controller.onTapProduct(item);
            },
            child: ProductLandscape(
              product: item,
              showAddToCart: false,
              showStar: false,
            ));
      },
      emptyWidget: EmptyWidget(
        title: "Nothing found here!",
        description: "Explore and add items to the favourites to show here...",
        buttonText: "Explore",
        onButtonTap: EmptyWidget.toHome,
      ),
    );
  }

  // 主视图
  Widget _buildView() {
    return _buildProductList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouritesController>(
      init: FavouritesController(),
      id: "favourites",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar.navigationTab(
              title: 'Favourites', icon: 'assets/icons/Like tilted.svg'),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
