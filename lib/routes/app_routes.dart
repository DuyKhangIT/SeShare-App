import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:instagram_app/page/main/post_screen/post_binding.dart';
import 'package:instagram_app/page/main/post_screen/post_view.dart';

import '../page/main/home_screen/home_view.dart';
import '../page/main/home_screen/home_binding.dart';
import '../page/main/notification_screen/notification_binding.dart';
import '../page/main/notification_screen/notification_view.dart';
import '../page/main/profile_screen/profile_binding.dart';
import '../page/main/profile_screen/profile_screen_view.dart';
import '../page/main/search_screen/search_binding.dart';
import '../page/main/search_screen/search_screen_view.dart';
import '../page/navigation_bar/navigation_bar_view.dart';
import '../page/navigation_bar/navigation_bar_binding.dart';
import '../page/onboarding/forgot_password/input_otp_forgot_password/input_otp_forgot_password_binding.dart';
import '../page/onboarding/forgot_password/input_otp_forgot_password/input_otp_forgot_password_view.dart';
import '../page/onboarding/forgot_password/input_password_forgot_password/input_password_forgot_password_binding.dart';
import '../page/onboarding/forgot_password/input_password_forgot_password/input_password_forgot_password_view.dart';
import '../page/onboarding/forgot_password/input_phone_number_forgot_password/input_phone_number_forgot_password_binding.dart';
import '../page/onboarding/forgot_password/input_phone_number_forgot_password/input_phone_number_forgot_password_view.dart';
import '../page/onboarding/login/login_binding.dart';
import '../page/onboarding/login/login_view.dart';
import '../page/onboarding/register/confirm_register/confirm_register_binding.dart';
import '../page/onboarding/register/confirm_register/confirm_register_view.dart';
import '../page/onboarding/register/input_full_name_register/input_full_name_binding.dart';
import '../page/onboarding/register/input_full_name_register/input_full_name_view.dart';
import '../page/onboarding/register/input_otp_register/input_otp_binding.dart';
import '../page/onboarding/register/input_otp_register/input_otp_view.dart';
import '../page/onboarding/register/input_password_register/input_password_binding.dart';
import '../page/onboarding/register/input_password_register/input_password_view.dart';
import '../page/onboarding/register/input_phone_number_register/input_phone_number_binding.dart';
import '../page/onboarding/register/input_phone_number_register/input_phone_number_view.dart';
import '../page/onboarding/register/upload_avatar_register/upload_avatar_binding.dart';
import '../page/onboarding/register/upload_avatar_register/upload_avatar_view.dart';
import '../page/onboarding/start_up/star_up_binding.dart';
import '../page/onboarding/start_up/start_up_view.dart';


class AppRoutes {
  static const String startUpScreen = "/seShare_startUp_screen";
  static const String loginScreen = "/seShare_login_screen";

  /// forgot password
  static const String inputPhoneNumberForgotPasswordScreen =
      "/seShare_inputPhoneNumberForgotPassword_screen";
  static const String inputOtpForgotPasswordScreen =
      "/seShare_inputOtpForgotPassword_screen";
  static const String inputNewPasswordForgotPasswordScreen =
      "/seShare_inputNewPasswordForgotPassword_screen";

  /// register
  static const String inputPhoneNumberRegisterScreen =
      "/seShare_inputPhoneNumberRegister_screen";
  static const String inputOtpRegisterScreen =
      "/seShare_inputOtpRegister_screen";
  static const String inputPasswordRegisterScreen =
      "/seShare_inputPasswordRegister_screen";
  static const String inputFullNameRegisterScreen =
      "/seShare_inputFullNameRegister_screen";
  static const String uploadAvatarRegisterScreen =
      "/seShare_uploadAvatarRegister_screen";
  static const String confirmRegisterScreen = "/seShare_confirmRegister_screen";

  /// home
  static const String homeScreen = "/seShare_home_screen";
  static const String notificationScreen = "/seShare_Notification_screen";
  static const String profileScreen = "/seShare_profile_screen";
  static const String searchScreen = "/seShare_search_screen";
  static const String postScreen = "/seShare_post_screen";

  static const String appNavigationScreen = '/seShare_navigation_screen';

  static List<GetPage> pages = [
    GetPage(
        name: startUpScreen,
        page: () => const StartUpScreen(),
        binding: StartUpBinding()),
    GetPage(name: loginScreen, page: () => Login(), binding: LoginBinding()),

    /// forgot password
    GetPage(
        name: inputPhoneNumberForgotPasswordScreen,
        page: () => InputPhoneNumberForgotPassword(),
        binding: InputPhoneNumberForgotPasswordBinding()),
    GetPage(
      name: inputOtpForgotPasswordScreen,
      page: () => InputOTPForgotPassword(),
      binding: InputOTPForgotPasswordBinding(),
    ),
    GetPage(
      name: inputNewPasswordForgotPasswordScreen,
      page: () => InputPasswordForgotPassword(),
      binding: InputPasswordForgotPasswordBinding(),
    ),

    /// register
    GetPage(
        name: inputPhoneNumberRegisterScreen,
        page: () => InputPhoneNumber(),
        binding: InputPhoneNumberBinding()),
    GetPage(
        name: inputOtpRegisterScreen,
        page: () => InputOTP(),
        binding: InputOTPBinding()),
    GetPage(
        name: inputPasswordRegisterScreen,
        page: () => InputPassword(),
        binding: InputPasswordBinding()),
    GetPage(
        name: inputFullNameRegisterScreen,
        page: () => InputFullName(),
        binding: InputFullNameBinding()),
    GetPage(
        name: uploadAvatarRegisterScreen,
        page: () => UploadAvatarForRegister(),
        binding: UploadAvatarBinding()),
    GetPage(
        name: confirmRegisterScreen,
        page: () => ConfirmRegister(),
        binding: ConfirmRegisterBinding()),
    /// navigation bar
    GetPage(
      name: appNavigationScreen,
      page: () => NavigationBarView(),
      binding: NavigationBarBinding(),
    ),
    /// home
    GetPage(
      name: homeScreen,
      page: () => Home(),
      binding: HomeBinding(),
    ),
    /// notification
    GetPage(
      name: notificationScreen,
      page: () => NotificationScreen(),
      binding: NotificationBinding(),
    ),
    /// profile
    GetPage(
      name: profileScreen,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    /// search
    GetPage(
      name: searchScreen,
      page: () => SearchScreen(),
      binding: SearchBinding(),
    ),
    /// post
    GetPage(
      name: postScreen,
      page: () => PostScreen(),
      binding: PostBinding(),
    ),
  ];
}
