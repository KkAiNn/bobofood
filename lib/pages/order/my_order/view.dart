import 'package:bobofood/common/model/order.dart';
import 'package:bobofood/common/widget/app_refresh_list_view.dart';
import 'package:bobofood/common/widget/app_segmented.dart';
import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/pages/order/my_order/widgets/order_item.dart';
import 'package:bobofood/pages/tabbar/widget/empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _MyOrderViewGetX();
  }
}

class _MyOrderViewGetX extends GetView<MyOrderController> {
  const _MyOrderViewGetX();

  Widget _buildOrderPageItem(ListController<OrderModel> listController) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: AppRefreshWrapper(
          controller: listController,
          separator: SizedBox(height: 16.h),
          itemBuilder: (context, item, index) {
            return OrderItem(
              order: item,
              onTap: () {},
              onMoreTap: () {
                controller.onMoreTap(item);
              },
            );
          },
          emptyWidget: EmptyWidget(
            title: 'There are no orders!',
            description:
                'Place order to show here. Previous orderswill be shown here as well.',
            buttonText: 'My Cart',
            onButtonTap: () {
              EmptyWidget.toHome(index: 2);
            },
          ),
        ));
  }

  // 主视图
  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        spacing: 24.h,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: AppSegmentedControl(
                items: controller.orderStatus,
                selectedValue: controller.selectedOrderStatus,
                onValueChanged: controller.onOrderStatusChanged,
              )),
          Expanded(
              child: PageView(
            controller: controller.pageController,
            onPageChanged: (index) {
              controller.onPageChanged(index);
            },
            children: [
              _buildOrderPageItem(controller.orderListController),
              _buildOrderPageItem(controller.previousListController),
            ],
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyOrderController>(
      init: MyOrderController(),
      id: "my_order",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar(
            titleText: 'My Order',
            trailingWidgets: [
              TapEffect(
                  child: AppSvg(
                path: 'assets/icons/More.svg',
                width: 24.w,
                height: 24.h,
              ))
            ],
          ),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
