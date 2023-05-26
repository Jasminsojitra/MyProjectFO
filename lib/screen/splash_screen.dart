import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/view_models/service/splash_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices services = SplashServices();

  @override
  void initState() {
    super.initState();
    services.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Align(
          alignment: Alignment.topCenter,
          child: SvgPicture.asset("assets/svg/splash_logo.svg"),
        ),
      ),
    );
  }
}
