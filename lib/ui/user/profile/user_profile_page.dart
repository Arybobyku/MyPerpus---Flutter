import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
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
      child: Consumer<AuthProvider>(builder: (context, valueAuth, _) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: kRoundedContainer.copyWith(
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: valueAuth.user.photoProfile??"",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error,size: 40,),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  SizedBox(width: 5),
                                  Text(
                                    "ID",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  SizedBox(width: 10),
                                  Text(valueAuth.user.uuid)
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: valueAuth.user.isValid
                                      ? ColorPalette.generalSoftGreen
                                      : ColorPalette.generalSoftRed),
                              child: Text(
                                valueAuth.user.isValid
                                    ? "Tervalidasi"
                                    : "Belum Tervalidasi",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(width: 10),
                            Text(valueAuth.user.namaLengkap)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.email),
                            SizedBox(width: 10),
                            Text(valueAuth.user.email)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.house),
                            SizedBox(width: 10),
                            Text(valueAuth.user.alamat)
                          ],
                        ),
                      ],
                    ),
                  ),
                  ButtonRounded(
                    text: "Keluar",
                    invert: true,
                    onPressed: () {
                      doSignOut(context);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  doSignOut(BuildContext context) async {
    EasyLoading.show(status: "Loading...");
    var result =
        await Provider.of<AuthProvider>(context, listen: false).doSignOut();
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
      Get.offAllNamed(Routes.login);
    });
  }
}
