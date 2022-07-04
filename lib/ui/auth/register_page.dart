import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/model/user_model.dart';
import 'package:my_perpus/provider/auth.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:my_perpus/ui/widget/dropdown_container.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../widget/input_field_rounded.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? jenisIdentitas = "KTP";
  String? nomorIdentitas = null;
  String? email = null;
  String? password = null;
  DateTime? tanggalLahir = null;
  String? namaLengkap = null;
  String? tempatLahir = null;
  String? alamat = null;
  String? provinsi = null;
  String? kota = null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  "Daftar",
                  style: TextStyle(
                    fontSize: 30,
                    color: ColorPalette.generalPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                DropdownContainer(
                  value: jenisIdentitas ?? "",
                  onChanged: (val) {
                    setState(() {
                      jenisIdentitas = val;
                    });
                  },
                  items: ["SIM", "KTP"],
                  hint: 'Jenis Identitas',
                ),
                InputFieldRounded(
                  hint: "Nomor Identitas",
                  onChange: (val) {
                    nomorIdentitas = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Nama Lengkap",
                  onChange: (val) {
                    namaLengkap = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Email",
                  onChange: (val) {
                    email = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Tempat Lahir",
                  onChange: (val) {
                    tempatLahir = val;
                  },
                  secureText: false,
                ),
                GestureDetector(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      onChanged: (val) {},
                      onConfirm: (val) {
                        setState(() {
                          tanggalLahir = val;
                        });
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: kRoundedContainer,
                    child: Text(
                        tanggalLahir != null
                            ? "${tanggalLahir?.day}/${tanggalLahir?.month}/${tanggalLahir?.year}"
                            : "Tanggal Lahir",
                        style: TextStyle(
                            color: ColorPalette.generalPrimaryColor,
                            fontSize: 16)),
                  ),
                ),
                InputFieldRounded(
                  hint: "Alamat",
                  onChange: (val) {
                    alamat = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Provinsi",
                  onChange: (val) {
                    provinsi = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Kabupaten/Kota",
                  onChange: (val) {
                    kota = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Password",
                  onChange: (val) {
                    password = val;
                  },
                  suffixIcon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: ColorPalette.generalPrimaryColor,
                  ),
                  secureText: true,
                ),
                ButtonRounded(
                  text: "Masuk",
                  onPressed: () {
                    doRegister(
                      context: context,
                      jenisIdentitas: jenisIdentitas,
                      kota: kota,
                      namaLengkap: namaLengkap,
                      nomorIdentitas: nomorIdentitas,
                      provinsi: provinsi,
                      tanggalLahir: tanggalLahir,
                      tempatLahir: tempatLahir,
                      alamat: alamat,
                      email: email,
                      password: password
                    );
                  },
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  doRegister({
    required BuildContext context,
    String? jenisIdentitas,
    String? nomorIdentitas,
    DateTime? tanggalLahir,
    String? namaLengkap,
    String? tempatLahir,
    String? alamat,
    String? provinsi,
    String? kota,
    String? email,
    String? password,
  }) async {
    if (jenisIdentitas != null &&
        nomorIdentitas != null &&
        tanggalLahir != null &&
        namaLengkap != null &&
        tempatLahir != null &&
        alamat != null &&
        provinsi != null &&
        kota != null &&
        email != null &&
        password != null) {
      EasyLoading.show(status: "Loading...");
      UserModel user = UserModel(
          tempatLahir: tempatLahir,
          email: email,
          password: password,
          jenisIdentitas: jenisIdentitas,
          nomorIdentitas: nomorIdentitas,
          tanggalLahir: tanggalLahir,
          namaLengkap: namaLengkap,
          alamat: alamat,
          provinsi: provinsi,
          kota: kota,
          isOrder: false,
      );
      var result = await Provider.of<AuthProvider>(context, listen: false)
          .doSignUp(user: user);

      result.fold((l){
        EasyLoading.dismiss();
        Alert(
          context: context,
          type: AlertType.error,
          title: "Pendaftaran Gagal",
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
        Get.offAllNamed(Routes.mainMenu);
      });


    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Pendaftaran Gagal",
        desc: "Harap isi seluruh formulir",
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
    }
  }
}
