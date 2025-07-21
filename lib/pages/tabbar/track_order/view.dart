import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/form/app_search.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class TrackOrderPage extends StatefulWidget {
  const TrackOrderPage({
    super.key,
  });

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _TrackOrderViewGetX();
  }
}

class _TrackOrderViewGetX extends GetView<TrackOrderController> {
  // 主视图
  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        spacing: 20.h,
        children: [
          SizedBox.shrink(),
          AppSearchDropdown(
            hintText: 'search for food...',
            items: controller.items,
            onSubmitted: (value) => controller.onSearch(value),
            onChanged: (value) => controller.onSearch(value),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              spacing: 12.h,
              children: [
                ...controller.options.map((e) => TapEffect(
                    onTap: () => controller.onSearch(e['title']),
                    child: Container(
                      height: 150.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(e['pic']),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Center(
                        child: AppText(e['title'],
                            style: AppTextStyle.poppinsHeading2(
                                color: AppColors.colors.typography.white)),
                      ),
                    ))),
                SizedBox.shrink(),
              ],
            ),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrackOrderController>(
      init: TrackOrderController(),
      id: "track_order",
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
