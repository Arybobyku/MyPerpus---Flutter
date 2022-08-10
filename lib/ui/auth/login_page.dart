import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/provider/auth.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/user/main_menu_page.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:my_perpus/ui/widget/input_field_rounded.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:download_assets/download_assets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DownloadAssetsController downloadAssetsController = DownloadAssetsController();
  String message = "Press the download button to start the download";
  bool downloaded = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future _init() async {
    await downloadAssetsController.init();
    downloaded = await downloadAssetsController.assetsDirAlreadyExists();
  }

  @override
  Widget build(BuildContext context) {
    var email = null;
    var password = null;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPalette.generalWhite,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    margin: EdgeInsets.only(top: 50, bottom: 20),
                    child: SvgPicture.asset(
                      "images/share.svg",
                      width: 300,
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    margin: EdgeInsets.only(top: 30, bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Masuk",
                          style: TextStyle(
                            fontSize: 30,
                            color: ColorPalette.generalPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputFieldRounded(
                          label: "Email",
                          hint: "Email",
                          onChange: (val) {
                            email = val;
                          },
                          secureText: false,
                        ),
                        InputFieldRounded(
                          label: "Password",
                          hint: "Password",
                          suffixIcon: Icon(
                            Icons.remove_red_eye_outlined,
                            color: ColorPalette.generalPrimaryColor,
                          ),
                          onChange: (val) {
                            password = val;
                          },
                          secureText: true,
                        ),
                        ButtonRounded(
                          text: "Masuk",
                          onPressed: () {
                            doLogin(context, email, password);
                          },
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Belum punya akun? ",
                              style: TextStyle(fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.register);
                              },
                              child: Text(
                                "Daftar",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: ColorPalette.generalPrimaryColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: ()=>Get.toNamed(Routes.webView,arguments: "https://docs.google.com/document/d/1KgY5KFYT2iQQaxQc5Ym0haLEvOGbPLza/edit?usp=sharing&ouid=114108662564056139028&rtpof=true&sd=true"),
                            child: Text(
                              "Tata cara penggunaan aplikasi",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: ColorPalette.generalPrimaryColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  doLogin(BuildContext context, String email, String password) async {
    EasyLoading.show(status: 'loading...');
    var result =
    await Provider.of<AuthProvider>(context, listen: false).doSignIn(
      email: email,
      password: password,
    );
    result.fold((l) {
      EasyLoading.dismiss();
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error Login",
        desc: l,
        buttons: [
          DialogButton(
            child: Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: ColorPalette.generalPrimaryColor,
            radius: BorderRadius.circular(0.0),
          ),
        ],
      ).show();
    }, (r) {
      EasyLoading.dismiss();
      Get.offAllNamed(
        Routes.navigator,
      );
    });
  }

  Future _downloadAssets() async {
    bool assetsDownloaded = await downloadAssetsController.assetsDirAlreadyExists();

    if (assetsDownloaded) {
      setState(() {
        message = "Click in refresh button to force download";
        print(message);
      });
      return;
    }

    try {
      await downloadAssetsController.startDownload(
        assetsUrl: "https://github.com/edjostenes/download_assets/raw/master/assets.zip",
        onProgress: (progressValue) {
          downloaded = false;
          setState(() {
            if (progressValue < 100) {
              message = "Downloading - ${progressValue.toStringAsFixed(2)}";
              print(message);
            } else {
              message = "Download completed\nClick in refresh button to force download";
              print(message);
              downloaded = true;
            }
          });
        },
      );
    } on DownloadAssetsException catch (e) {
      print(e.toString());
      setState(() {
        downloaded = false;
        message = "Error: ${e.toString()}";
      });
    }
  }
}
