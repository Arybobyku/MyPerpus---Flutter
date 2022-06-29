import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/provider/auth.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AuthProvider>(
        builder: (context,valueAuth,_) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Icon(Icons.person),
                      ],
                    ),
                  ),
                  ButtonRounded(
                    text: "Keluar",
                    invert: true,
                    onPressed: (){
                      doSignOut(context);
                    },
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  doSignOut(BuildContext context)async{
    EasyLoading.show(status: "Loading...");
    var result = await  Provider.of<AuthProvider>(context,listen: false).doSignOut();
    result.fold((l){
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
    }, (r){
      EasyLoading.dismiss();
      Get.offAllNamed(Routes.login);
    });
  }
}
