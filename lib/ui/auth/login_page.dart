import 'package:flutter/material.dart';
import 'package:my_perpus/helper/color_palette.dart';

class LoginPage extends StatelessWidget {

  static const id = "loginPage";

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.generalWhite,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
