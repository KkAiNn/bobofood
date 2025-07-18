import 'package:bobofood/common/model/notification.dart';
import 'package:bobofood/common/widget/app_refresh_list_view.dart';
import 'package:bobofood/common/widget/app_segmented.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/pages/tabbar/notification/widgets/notification_itme.dart';
import 'package:bobofood/pages/tabbar/widget/empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({
    super.key,
  });

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _NotificationViewGetX();
  }
}

class _NotificationViewGetX extends GetView<NotificationController> {
  // 主视图
  Widget _buildEmpty() {
    return EmptyWidget(
      title: "Nothing found\nhere!",
      onButtonTap: EmptyWidget.toHome,
    );
  }

  Widget _buildList(ListController<NotificationModel> listController) {
    return AppRefreshWrapper(
      controller: listController,
      separator: SizedBox(height: 20.h),
      itemBuilder: (context, item, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: NotificationItme(notification: item),
        );
      },
      emptyWidget: _buildEmpty(),
    );
  }

  // 主视图
  Widget _buildView() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.w, 20.w, 0),
          child: AppSegmentedControl(
              items: controller.items,
              selectedValue: controller.selectedValue,
              onValueChanged: controller.onValueChanged),
        ),
        SizedBox(height: 24.h),
        Expanded(
            child: PageView(
          controller: controller.pageController,
          onPageChanged: controller.onPageChanged,
          children: [
            _buildList(controller.listController),
            _buildList(controller.oldListController),
          ],
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
      id: "notification",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar.navigationTab(
              title: 'Notification', icon: 'assets/icons/Notification-1.svg'),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
