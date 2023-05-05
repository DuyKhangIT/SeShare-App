import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:instagram_app/page/main/another_profile_screen/another_profile_binding.dart';
import 'package:instagram_app/page/main/another_profile_screen/another_profile_screen.dart';
import 'package:instagram_app/page/main/chat_sreen/chat_list/chat_list_view.dart';
import 'package:instagram_app/page/main/chat_sreen/chat_view/chat_binding.dart';
import 'package:instagram_app/page/main/chat_sreen/chat_view/chat_view.dart';
import 'package:instagram_app/page/main/home_screen/comments_screen/comments_screen_binding.dart';
import 'package:instagram_app/page/main/home_screen/comments_screen/comments_view.dart';
import 'package:instagram_app/page/main/home_screen/create_story/create_story_binding.dart';
import 'package:instagram_app/page/main/home_screen/create_story/create_story_view.dart';
import 'package:instagram_app/page/main/home_screen/story_page/story_page_binding.dart';
import 'package:instagram_app/page/main/home_screen/story_page/story_page_view.dart';
import 'package:instagram_app/page/main/post_screen/changed_address/changed_address_binding.dart';
import 'package:instagram_app/page/main/post_screen/changed_address/changed_address_view.dart';
import 'package:instagram_app/page/main/post_screen/post_binding.dart';
import 'package:instagram_app/page/main/post_screen/post_view.dart';
import 'package:instagram_app/page/main/profile_screen/setting_screen/change_password/change_password_binding.dart';
import 'package:instagram_app/page/main/profile_screen/setting_screen/setting_binding.dart';
import 'package:instagram_app/page/main/profile_screen/setting_screen/setting_screen.dart';
import 'package:instagram_app/page/main/profile_screen/update_profile_screen/update_profile_binding.dart';
import 'package:instagram_app/page/main/profile_screen/update_profile_screen/update_profile_screen_view.dart';

import '../page/main/chat_sreen/chat_list/chat_list_binding.dart';
import '../page/main/home_screen/home_view.dart';
import '../page/main/home_screen/home_binding.dart';
import '../page/main/notification_screen/notification_binding.dart';
import '../page/main/notification_screen/notification_view.dart';
import '../page/main/profile_screen/profile_binding.dart';
import '../page/main/profile_screen/profile_screen.dart';
import '../page/main/profile_screen/setting_screen/change_password/change_password_screen.dart';
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
  /// profile
  static const String profileScreen = "/seShare_profile_screen";
  static const String updateProfileScreen = "/seShare_updateProfile_screen";

  static const String searchScreen = "/seShare_search_screen";
  static const String postScreen = "/seShare_post_screen";
  static const String storyScreen = "/seShare_story_screen";
  static const String commentsScreen = "/seShare_comments_screen";
  static const String createStoryScreen = "/seShare_createStory_screen";
  /// another profile
  static const String anOtherProfileScreen = "/seShare_anOtherProfile_screen";

  /// setting screen
  static const String settingScreen = "/seShare_setting_screen";
  /// change password
  static const String changePasswordScreen = "/seShare_changePassword_screen";

  /// Chat
  static const String chatListScreen = "/seShare_chat_list_screen";
  static const String chatScreen = "/seShare_chat_screen";

  static const String changedAddressScreen = "/seShare_changedAddress_screen";

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
      page: () => NavigationBarView(currentIndex: 0,),
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
    /// story
    GetPage(
      name: storyScreen,
      page: () => StoryPage(),
      binding: StoryBinding(),
    ),
    /// chat list
    GetPage(
      name: chatListScreen,
      page: () => ChatListScreen(),
      binding: ChatListBinding(),
    ),

    GetPage(
      name: chatScreen,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),

    GetPage(
      name: changedAddressScreen,
      page: () => const ChangedAddressView(),
      binding: ChangedAddressBinding(),
    ),

    GetPage(
      name: commentsScreen,
      page: () => const CommentScreen(),
      binding: CommentsBinding(),
    ),

    GetPage(
      name: createStoryScreen,
      page: () => const CreateStoryScreen(),
      binding: CreateStoryBinding(),
    ),

    GetPage(
      name: updateProfileScreen,
      page: () => const UpdateProfileScreen(),
      binding: UpdateProfileBinding(),
    ),

    GetPage(
      name: anOtherProfileScreen,
      page: () => const AnOtherProfileScreen(),
      binding: AnOtherProfileBinding(),
    ),

    GetPage(
      name: settingScreen,
      page: () => const SettingScreen(),
      binding: SettingBinding(),
    ),

    GetPage(
      name: changePasswordScreen,
      page: () => const ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    ),
  ];
}
