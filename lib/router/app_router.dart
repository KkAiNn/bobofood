import 'package:bobofood/pages/address/change-address/view.dart';
import 'package:bobofood/pages/address/view.dart';
import 'package:bobofood/pages/card/add_card/view.dart';
import 'package:bobofood/pages/card/payment_methods/view.dart';
import 'package:bobofood/pages/delivery_route/delivery_route_detail/view.dart';
import 'package:bobofood/pages/delivery_route/delivery_routes/view.dart';
import 'package:bobofood/pages/delete_account/view.dart';
import 'package:bobofood/pages/login/create-new-password/view.dart';
import 'package:bobofood/pages/login/verify-code/view.dart';
import 'package:bobofood/pages/login/login_form/view.dart';
import 'package:bobofood/pages/login/register/view.dart';
import 'package:bobofood/pages/login/view.dart';
import 'package:bobofood/pages/main/splash.dart';
import 'package:bobofood/pages/main/view.dart';
import 'package:bobofood/pages/map/view.dart';
import 'package:bobofood/pages/order/add_coupon/view.dart';
import 'package:bobofood/pages/card/change_card/view.dart';
import 'package:bobofood/pages/order/my_order/view.dart';
import 'package:bobofood/pages/order/pay_checkout/view.dart';
import 'package:bobofood/pages/order/pay_checkout/widgets/order_placed.dart';
import 'package:bobofood/pages/order/place_order/view.dart';
import 'package:bobofood/pages/product/product_detail/view.dart';
import 'package:bobofood/pages/address/add-address/view.dart';
import 'package:bobofood/pages/setting/language/view.dart';
import 'package:bobofood/pages/setting/view.dart';
import 'package:bobofood/pages/search-result/view.dart';
import 'package:bobofood/pages/user/create-profile/view.dart';
import 'package:bobofood/pages/user/my_account/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoute {
  static const String home = '/';
  static const String login = '/login';
  static const String splash = '/splash';
  static const String loginForm = '/loginForm';
  static const String register = '/register';
  static const String verifyCode = '/verifyCode';
  static const String createNewPassword = '/createNewPassword';
  static const String createProfile = '/createProfile';
  static const String addAddress = '/addAddress';
  static const String productDetail = '/productDetail';
  static const String placeOrder = '/placeOrder';
  static const String addCoupon = '/addCoupon';
  static const String checkout = '/checkout';
  static const String changeAddress = '/changeAddress';
  static const String addCard = '/addCard';
  static const String changeCard = '/changeCard';
  static const String orderPlaced = '/orderPlaced';
  static const String myOrder = '/myOrder';
  static const String myAccount = '/myAccount';
  static const String paymentMethods = '/paymentMethods';
  static const String address = '/address';

  static const String settings = '/settings';
  static const String language = '/language';

  static const String searchResult = '/searchResult';

  static const String deleteAccount = '/deleteAccount';

  static const String map = '/map';

  // 配送路径相关路由
  static const String deliveryRoutes = '/deliveryRoutes';
  static const String deliveryRouteDetail = '/deliveryRouteDetail';
}

class Routes {
  static final List<GetPage<dynamic>> getPages = [
    GetPage(
      name: AppRoute.home,
      page: () => const MainApp(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoute.splash,
      page: () => const SplashPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoute.login,
      page: () => const LoginPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoute.loginForm,
      page: () => const LoginFormPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.register,
      page: () => const RegisterPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.verifyCode,
      page: () => const VerifyCodePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoute.createNewPassword,
      page: () => const CreateNewPasswordPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoute.createProfile,
      page: () => const CreateProfilePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoute.addAddress,
      page: () => const AddAddressPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.productDetail,
      page: () => const ProductDetailPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.placeOrder,
      page: () => const PlaceOrderPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.addCoupon,
      page: () => const AddCouponPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.checkout,
      page: () => const PayCheckoutPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.changeAddress,
      page: () => const ChangeAddressPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.addCard,
      page: () => const AddCardPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.changeCard,
      page: () => const ChangeCardPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.orderPlaced,
      page: () => const OrderPlacedPage(),
      transition: Transition.cupertinoDialog,
    ),
    GetPage(
      name: AppRoute.myOrder,
      page: () => const MyOrderPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.myAccount,
      page: () => const MyAccountPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.paymentMethods,
      page: () => const PaymentMethodsPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.address,
      page: () => const AddressPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.settings,
      page: () => const SettingPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.language,
      page: () => const LanguagePage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.searchResult,
      page: () => const SearchResultPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.deleteAccount,
      page: () => const DeleteAccountPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.map,
      page: () => const MapPage(),
      transition: Transition.fadeIn,
    ),
    // 配送路径相关路由
    GetPage(
      name: AppRoute.deliveryRoutes,
      page: () => const DeliveryRoutesPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoute.deliveryRouteDetail,
      page: () => const DeliveryRouteDetailPage(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}

class CustomGetPage extends GetPage<dynamic> {
  CustomGetPage({
    required super.name,
    required super.page,
    bool? fullscreen,
    transition,
    super.transitionDuration,
  }) : super(
          curve: Curves.linear,
          transition: transition ?? Transition.native,
          showCupertinoParallax: false,
          popGesture: false,
          fullscreenDialog: fullscreen != null && fullscreen,
        );
}
