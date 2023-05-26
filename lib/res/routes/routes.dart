import 'package:festum_evento/res/routes/routes_name.dart';
import 'package:festum_evento/screen/DeshboardEvent/screen/event_category.dart';
import 'package:festum_evento/screen/DeshboardEvent/screen/event_setting_list.dart';
import 'package:festum_evento/screen/DeshboardEvent/screen/event_sitting_arrangement.dart';
import 'package:festum_evento/screen/DeshboardEvent/screen/event_times.dart';
import 'package:festum_evento/screen/LoginAndSignUp/screen/forget_password_screen.dart';
import 'package:festum_evento/screen/LoginAndSignUp/screen/login_screen.dart';
import 'package:festum_evento/screen/LoginAndSignUp/screen/new_password_screen.dart';
import 'package:festum_evento/screen/LoginAndSignUp/screen/otp_screen.dart';
import 'package:festum_evento/screen/LoginAndSignUp/screen/register_screen.dart';
import 'package:festum_evento/screen/deshboard_screen.dart';
import 'package:festum_evento/screen/splash_screen.dart';
import 'package:get/get.dart';

import '../../screen/DeshboardEvent/screen/event_address.dart';
import '../../screen/DeshboardEvent/screen/event_discount.dart';
import '../../screen/DeshboardEvent/screen/event_gallery.dart';
import '../../screen/DeshboardEvent/screen/event_permission_letter.dart';
import '../../screen/DeshboardEvent/screen/event_personal_details.dart';

class AppRoute {
  static appRoutes() => [
        GetPage(
            name: RouteName.splashScreen,
            page: () => SplashScreen(),),
        GetPage(
            name: RouteName.loginScreen,
            page: () => LoginScreen(),),
        GetPage(
            name: RouteName.registerScreen,
            page: () => RegisterScreen(),),
        GetPage(
            name: RouteName.otpScreen,
            page: () => OtpScreen(),),
        GetPage(
            name: RouteName.deshboardScreen,
            page: () => DeshboardScreen(),),
        GetPage(
            name: RouteName.forgotPasswordScreen,
            page: () => ForgetPasswordScreen(),),
        GetPage(
            name: RouteName.newPasswordScreen,
            page: () => NewPasswordScreen(),),
        GetPage(
            name: RouteName.eventCategoryScreen,
            page: () => EventCategoryScreen(),),
        GetPage(
            name: RouteName.eventTimeScreen,
            page: () => const EventTimesScreen(),),
        GetPage(
            name: RouteName.eventSittingListScreen,
            page: () => const EventSettingListScreen(),),
        GetPage(
              name: RouteName.eventSittingListScreen,
              page: () => const EventSettingListScreen(),),
        GetPage(
              name: RouteName.eventLocationScreen,
              page: () => const EventAddressScreen(),),
        GetPage(
          name: RouteName.eventGalleryScreen,
          page: () => const EventGalleryScreen(),),
    GetPage(
          name: RouteName.eventPermissionLetterScreen,
          page: () => const EventPermissionLetterScreen(),),
    GetPage(
          name: RouteName.eventDiscountScreen,
          page: () => const EventDiscountScreen(),),
    GetPage(
          name: RouteName.eventPersonalDetailsScreen,
          page: () => const EventPersonalDetailsScreen(),),

      ];
}
