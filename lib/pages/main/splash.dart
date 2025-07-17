import 'package:bobofood/common/widget/app_indicator.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:bobofood/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late List<Map<String, dynamic>> _guideList;
  late String backgroundImage;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initGuide();
  }

  void _initGuide() {
    AppStorage.conifg.put(ConifgBoxKey.splash, true);
  }

  void _onSkip() {
    Get.offAllNamed(AppRoute.login);
  }

  void _onNext() {
    setState(() {
      if (_currentIndex < _guideList.length - 1) {
        _currentIndex++;
      } else {
        _onSkip();
      }
    });
  }

  void _initGuideList(BuildContext context) {
    final isDarkMode =
        AppStorage.conifg.get(ConifgBoxKey.themeMode, defaultValue: false);

    backgroundImage =
        'assets/Illustrations/background ${isDarkMode ? 'dark' : 'light'}.png';
    _guideList = [
      {
        'image':
            'assets/Illustrations/Chef cooking - ${isDarkMode ? 'dark' : 'light'} mode.png',
        'title': 'Welcome to the most tastiest app',
        'description': 'You know, this app is edible meaning you can eat it!',
      },
      {
        'image':
            'assets/Illustrations/Delivery guy - ${isDarkMode ? 'dark' : 'light'} mode.png',
        'title': 'We use nitro on bicycles for delivery!',
        'description':
            'For very fast delivery we use nitro on bicycles, kidding, but we’re very fast.',
      },
      {
        'image':
            'assets/Illustrations/Birthday girl - ${isDarkMode ? 'dark' : 'light'} mode.png',
        'title': 'We’re the besties of birthday peoples',
        'description':
            'We send cakes to our plus members, (only one cake per person)',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    _initGuideList(context);
    return Scaffold(
      appBar: AppNavBar.logo(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 12.h),
          Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Image.asset(backgroundImage,
                              width: 374.w, height: 374.h),
                        ),
                        Image.asset(_guideList[_currentIndex]['image'],
                            width: 285.w, height: 285.h),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                      ),
                      child: Column(
                        children: [
                          AppText(_guideList[_currentIndex]['title'],
                              textAlign: TextAlign.center,
                              style: AppTextStyle.poppinsHeading1(
                                  color: AppColors.colors.typography.heading)),
                          SizedBox(height: 16.h),
                          AppText(_guideList[_currentIndex]['description'],
                              textAlign: TextAlign.center,
                              style: AppTextStyle.poppinMedium400(
                                  color:
                                      AppColors.colors.typography.paragraph)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                SizedBox(height: 40.h),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppIndicator(
                            count: _guideList.length,
                            currentIndex: _currentIndex)
                      ],
                    )),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButton(
                        width: 98.w,
                        text: 'Skip',
                        type: AppButtonType.secondary,
                        onTap: _onSkip,
                      ),
                      AppButton(
                        width: 229.w,
                        text: 'Next',
                        onTap: _onNext,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}
