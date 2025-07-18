import 'package:bobofood/common/model/product.dart';
import 'package:bobofood/common/widget/app_avatar.dart';
import 'package:bobofood/common/widget/app_carousel_slider.dart';
import 'package:bobofood/common/widget/app_refresh_list_view.dart';
import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/app_tabs.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_action_icon.dart';
import 'package:bobofood/common/widget/form/app_search.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/common/widget/unfoucs_box.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:bobofood/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.onOpenUser});

  final Function()? onOpenUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _HomeViewGetX(onOpenUser: widget.onOpenUser);
  }
}

class _HomeViewGetX extends GetView<HomeController> {
  const _HomeViewGetX({this.onOpenUser});

  final Function()? onOpenUser;

  // 头部内容
  Widget _buildHeader() {
    return Container(
        color: AppColors.theme.white,
        padding: EdgeInsets.only(bottom: 16.h),
        child: SafeArea(
          child: Column(
            spacing: 16.h,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  spacing: 16.h,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 16.w,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              'Hello, ${controller.authController.userInfo.value?.email}',
                              style: AppTextStyle.poppinMedium400(
                                color: AppColors.colors.typography.heading,
                              ),
                            ),
                            AppText(
                              'What are you carving?',
                              style: AppTextStyle.poppinLarge400(
                                color: AppColors.colors.typography.heading,
                              ),
                            ),
                          ],
                        ),
                        Obx(() => AppAvatar(
                            onTap: () {
                              onOpenUser?.call();
                            },
                            avatarUrl: controller.authController.avatarUrl)),
                      ],
                    ),
                    AppSearchDropdown<String>(
                      hintText: '搜索城市',
                      items: [
                        'Chocolate boba',
                        'grilled beef burger',
                        'honey bee cake',
                        'classic momos',
                      ],
                      itemToString: (item) => item,
                      onChanged: (value) => logger.d('选中：$value'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildCarouselSlider() {
    return Container(
      padding: EdgeInsets.only(left: 20.w),
      margin: EdgeInsets.only(bottom: 16.h),
      child: AppCarouselSlider<String>(
        items: controller.images,
        itemBuilder: (context, url, index) {
          return Image.asset(
            url,
            height: 140.h,
          );
        },
        height: 140.h,
        viewportFraction: 0.95,
        itemSpacing: 8,
        enableInfiniteScroll: true,
        autoPlay: false,
        onPageChanged: (index) {
          logger.d('当前页: $index');
        },
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      color: AppColors.theme.white,
      padding: EdgeInsets.only(left: 20.w, bottom: 16.h),
      child: AppTabs<String>(
        currentTab: controller.currentTab,
        tabs: controller.tabs,
        onTap: (tab) {
          logger.d('选中：$tab');
          controller.changeTab(tab);
        },
        itemToString: (item) => item.toString(),
      ),
    );
  }

  Widget _buildGridItemContent(BuildContext context, ProductModel item) {
    return Container(
      padding: EdgeInsets.fromLTRB(4.w, 4.w, 4.w, 16.w),
      decoration: BoxDecoration(
        color: AppColors.colors.background.elementBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.colors.bordersAndSeparators.defaultColor,
          width: 1.w,
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                  child: Image.asset(
                    item.image ?? '',
                    width: double.infinity,
                    height: 132.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 4.w,
                  left: 4.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
                    decoration: BoxDecoration(
                      color: AppColors.colors.background.transparentNav,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 4.w,
                      children: [
                        AppSvg(
                          path: 'assets/icons/Star filled.svg',
                          width: 16.w,
                          height: 16.w,
                          color: AppColors.colors.icon.yellow,
                        ),
                        AppText(
                          '4.5',
                          style: AppTextStyle.poppinSmall(
                            color: AppColors.colors.typography.paragraph,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.h,
                children: [
                  AppText(
                    item.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.poppinMedium(
                      color: AppColors.colors.typography.heading,
                    ),
                  ),
                  AppText(
                    '\$${item.price}',
                    style: AppTextStyle.robotoMedium(
                      color: AppColors.colors.typography.heading,
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }

  // 构建网格项
  Widget _buildGridItem(BuildContext context, ProductModel item, int index) {
    return Stack(
      children: [
        TapEffect(
          onTap: () {
            controller.onTapProduct(item);
          },
          child: _buildGridItemContent(context, item),
        ),
        Positioned(
          bottom: 8.w,
          right: 8.w,
          child: AppActionIcon(
            type: AppActionIconType.light,
            size: 32,
            rounded: true,
            onTap: () {
              controller.onTapAddToCart(item);
            },
          ),
        )
      ],
    );
  }

  // 主视图
  Widget _buildView() {
    // 创建一个列表控制器
    // final listController = controller.listController;

    return AppCustomRefreshWrapper(
      controller: controller.listController,
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: StickyHeaderDelegate(child: _buildHeader(), height: 154.h),
        ),
        SliverToBoxAdapter(child: _buildCarouselSlider()),
        SliverPersistentHeader(
          pinned: true,
          delegate: StickyHeaderDelegate(child: _buildTabs(), height: 58.h),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          sliver: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.75, // 宽高比：宽 / 高
            ),
            itemCount: controller.foodItems.length,
            itemBuilder: (context, index) {
              return _buildGridItem(
                  context, controller.foodItems[index], index);
            },
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 12.h)),
      ],
    );

    // return NestedScrollView(
    //   key: const Key('home_page'),
    //   physics: const ClampingScrollPhysics(),
    //   headerSliverBuilder: (context, innerBoxScrolled) {
    //     return [
    //       SliverPersistentHeader(
    //         pinned: true,
    //         delegate:
    //             StickyHeaderDelegate(child: _buildHeader(), height: 154.h),
    //       ),
    //       SliverToBoxAdapter(child: _buildCarouselSlider()),
    //       SliverPersistentHeader(
    //         pinned: true,
    //         delegate: StickyHeaderDelegate(child: _buildTabs(), height: 58.h),
    //       ),
    //     ];
    //   },
    //   body: Padding(
    //     padding: EdgeInsets.symmetric(horizontal: 20.w),
    //     child: AppGridRefreshWrapper(
    //       controller: controller.listController,
    //       crossAxisCount: 2,
    //       mainAxisSpacing: 16.h,
    //       crossAxisSpacing: 16.w,
    //       childAspectRatio: 0.75,
    //       itemBuilder: (context, item, index) {
    //         return _buildGridItem(context, item, index);
    //       },
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      id: "home",
      builder: (_) {
        return Scaffold(
          body: UnfoucsBox(child: _buildView()),
        );
      },
    );
  }
}

// 自定义吸顶头部代理
class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  StickyHeaderDelegate({
    required this.child,
    this.height = 48.0,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: height,
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant StickyHeaderDelegate oldDelegate) {
    // 如果 child 或高度变化，才重新构建
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}
