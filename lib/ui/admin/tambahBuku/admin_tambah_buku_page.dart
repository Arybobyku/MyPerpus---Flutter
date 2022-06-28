import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/model/buku_model.dart';
import 'package:my_perpus/provider/buku.dart';
import 'package:my_perpus/ui/widget/button_picker.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:my_perpus/ui/widget/input_field_rounded.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AdminTambahBukuPage extends StatefulWidget {
  const AdminTambahBukuPage({Key? key}) : super(key: key);

  @override
  _AdminTambahBukuPageState createState() => _AdminTambahBukuPageState();
}

class _AdminTambahBukuPageState extends State<AdminTambahBukuPage> {
  File? imageCoverFile = null;
  String? judul = null;
  String? penerbit = null;
  String? pengarang = null;
  String? tahun = null;
  String? jenis = null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Tambah Buku",
            style: TextStyle(color: ColorPalette.generalPrimaryColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                InputFieldRounded(
                  hint: "Judul Buku",
                  onChange: (val) {
                    judul = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Penerbit",
                  onChange: (val) {
                    penerbit = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Pengarang",
                  onChange: (val) {
                    pengarang = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Tahun",
                  onChange: (val) {
                    tahun = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Jenis",
                  onChange: (val) {
                    jenis = val;
                  },
                  secureText: false,
                ),
                imageCoverFile != null
                    ? Container(
                        margin: EdgeInsets.only(top: 15, bottom: 30),
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(imageCoverFile!),
                          ),
                        ),
                      )
                    : ButtonPicker(
                        onTap: () => doImagePicker(),
                      ),
                ButtonRounded(
                  text: "Tambah",
                  onPressed: () => doTambahBuku(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  doImagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        imageCoverFile = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  doTambahBuku() async {
    if (judul != null &&
        penerbit != null &&
        pengarang != null &&
        tahun != null &&
        jenis != null &&
        imageCoverFile != null) {
      var buku = BukuModel(
          judul: judul!,
          pengarang: pengarang!,
          penerbit: penerbit!,
          jenis: jenis!,
          tahun: tahun!);

      EasyLoading.show(status: "Loading");

      var result = await Provider.of<BukuProvider>(context, listen: false)
          .doTambahBuku(buku: buku, coverBuku: imageCoverFile!);

      result.fold((l){
        EasyLoading.dismiss();
        Alert(
          context: context,
          type: AlertType.error,
          title: "Gagal menambahkan buku",
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
        Get.back();
      });

    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Gagal menambahkan buku",
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
