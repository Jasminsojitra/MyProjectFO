import 'package:festum_evento/Languague/main/LocaleString.dart';
import 'package:festum_evento/res/routes/routes.dart';
import 'package:festum_evento/screen/LoginAndSignUp/screen/login_screen.dart';
import 'package:festum_evento/screen/splash_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/view_models/controller/LoadingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(LoadingController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      translations: LocaleString(),
      fallbackLocale: const Locale('en', 'US'),
      locale: const Locale('en', 'US'),
      theme: ThemeData(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        fontFamily: 'Helvetica',
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: AppColors.appColor,
            onPrimary: Colors.white,
            secondary: AppColors.darkAppColor,
            onSecondary: AppColors.darkAppColor,
            error: AppColors.redColor,
            onError: AppColors.greyColor,
            background: Colors.white,
            onBackground: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black)
      ),
      debugShowCheckedModeBanner: false,
      getPages: AppRoute.appRoutes(),
      home: const SplashScreen(),
    );
  }
}