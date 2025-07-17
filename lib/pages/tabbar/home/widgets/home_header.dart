import 'package:bobofood/common/widget/app_avatar.dart';
import 'package:bobofood/common/widget/app_carousel_slider.dart';
import 'package:bobofood/common/widget/app_tabs.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/form/app_search.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  final String userEmail;
  final List<String> images;
  final String currentTab;
  final List<String> tabs;
  final Function(String) onTabChanged;
  final Function(String) onSearch;

  const HomeHeader({
    Key? key,
    required this.userEmail,
    required this.images,
    required this.currentTab,
    required this.tabs,
    required this.onTabChanged,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        // 用户信息和搜索
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 用户信息
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Hello, $userEmail',
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
                  AppAvatar(avatarUrl: 'assets/avatar.png'),
                ],
              ),
              SizedBox(height: 16.h),
              // 搜索框
              AppSearchDropdown<String>(
                hintText: '搜索城市',
                items: [
                  'Chocolate boba',
                  'grilled beef burger',
                  'honey bee cake',
                  'classic momos',
                ],
                itemToString: (item) => item,
                onChanged: onSearch,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // 轮播图
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: AppCarouselSlider<String>(
            items: images,
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
              print('当前页: $index');
            },
          ),
        ),
        SizedBox(height: 16.h),
        // 分类标签
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: AppTabs<String>(
            currentTab: currentTab,
            tabs: tabs,
            onTap: onTabChanged,
            itemToString: (item) => item.toString(),
          ),
        ),
      ],
    );
  }
}
