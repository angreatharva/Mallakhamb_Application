import 'package:bhausaheb2k24/routes/app_pages.dart';
import 'package:bhausaheb2k24/routes/app_routes.dart';
import 'package:bhausaheb2k24/screens/Login/login.dart';
import 'package:bhausaheb2k24/translation/app_Translation.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'constants/app_Colors.dart';

void main() {
  // Initialize EasyLoading
  EasyLoading.init();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.SPLASH, // Set the initial route to SPLASH
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    builder: EasyLoading.init(), // Initialize EasyLoading builder
    home: SplashScreen(), // Set the home to your splash screen
    locale: Get.deviceLocale,
    fallbackLocale:  Locale('en', 'US'),
    translationsKeys: AppTranslation.translations,
  ));
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _imagePrecached = false;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  double _initialSize = 100.0; // Initial size of the logo
  double _targetSize = 200.0; // Target size of the logo

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_imagePrecached) {
      precacheImage(AssetImage("assets/images/bhausahebLogo.jpg"), context);
      _imagePrecached = true;
    }
  }

  @override
  void initState() {
    super.initState();
    // Start the animation after a short delay
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _initialSize = 200.0; // Change the initial size to start small
      });
    });
    // Navigate to the login screen after a longer delay
    Future.delayed(Duration(milliseconds: 1800), () {
      Get.offNamed(Routes.LOGIN, arguments: _navigatorKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: _initialSize,
          height: _initialSize,
          child: Hero(
            tag: 'logo',
            child: Image.asset(
              "assets/images/bhausahebLogo.jpg",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
