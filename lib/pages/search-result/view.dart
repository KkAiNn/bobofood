import 'package:bobofood/common/widget/app_refresh_list_view.dart';
import 'package:bobofood/common/widget/button/app_action_icon.dart';
import 'package:bobofood/common/widget/form/app_search.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/pages/search-result/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class SearchResultPage extends GetView<SearchResultController> {
  const SearchResultPage({super.key});

  Widget _buildProductList() {
    return AppRefreshWrapper(
      controller: controller.listController,
      separator: SizedBox(height: 12.h),
      itemBuilder: (context, item, index) {
        return TapEffect(
            onTap: () => controller.onTapProduct(item),
            child: ProductItem(
              product: item,
              onTap: () => controller.onTapAddToCart(item),
            ));
      },
    );
  }

  // 主视图
  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        spacing: 12.h,
        children: [
          SizedBox.shrink(),
          Row(
            spacing: 8.w,
            children: [
              Expanded(
                child: AppSearchDropdown(
                  hintText: 'search for food...',
                  selectedItem: controller.searchValue,
                  items: controller.items,
                  onChanged: (value) => controller.onSearch(value),
                  onSubmitted: (value) => controller.onSearch(value),
                ),
              ),
              AppActionIcon(
                icon: 'assets/icons/Filter.svg',
                onTap: () {},
                size: 48.w,
              )
            ],
          ),
          Expanded(child: _buildProductList())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchResultController>(
      init: SearchResultController(),
      id: "search_result",
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
