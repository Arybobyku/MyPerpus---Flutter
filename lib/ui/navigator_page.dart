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
    return Container(
      child: Text(
        "MyPerpus",
        style: TextStyle(
          color: ColorPalette.generalPrimaryColor,
        ),
      ),
    );
  }

  navigated(BuildContext context) async {
    var storageService = locator<LocalStorageService>();
    var name = storageService.getStringFromPref(Constants.userName);

    await Future.delayed(const Duration(seconds: 5), () async {
      if (name == null) {
        Get.offAllNamed(Routes.login);
      } else {
        Get.offAllNamed(Routes.mainMenu);
      }
    });
  }
}
