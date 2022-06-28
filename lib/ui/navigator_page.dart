import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/local_storage_service.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/setup_locator.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key}) : super(key: key);

  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  @override
  Widget build(BuildContext context) {
    navigated(context);
    return Scaffold(
      backgroundColor: ColorPalette.generalBackgroundColor,
      body: Center(
        child: Text(
          "MyPerpus",
          style: TextStyle(
            color: ColorPalette.generalPrimaryColor,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

  navigated(BuildContext context) async {
    var user = await FirebaseAuth.instance.currentUser??null;
    await Future.delayed(const Duration(seconds: 5), () async {
      if (user==null) {
        Get.offAllNamed(Routes.login);
      } else {
        Get.offAllNamed(Routes.mainMenu);
      }
    });
  }
}
