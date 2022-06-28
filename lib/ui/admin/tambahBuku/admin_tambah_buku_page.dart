import 'package:flutter/material.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/ui/widget/button_picker.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:my_perpus/ui/widget/input_field_rounded.dart';

class AdminTambahBukuPage extends StatefulWidget {
  const AdminTambahBukuPage({Key? key}) : super(key: key);

  @override
  _AdminTambahBukuPageState createState() => _AdminTambahBukuPageState();
}

class _AdminTambahBukuPageState extends State<AdminTambahBukuPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Tambah Buku", style: TextStyle(color: ColorPalette.generalPrimaryColor),),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20),
                InputFieldRounded(
                  hint: "Judul Buku",
                  onChange: (val) {},
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Penerbit",
                  onChange: (val) {},
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Pengarang",
                  onChange: (val) {},
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Tahun",
                  onChange: (val) {},
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Jenis",
                  onChange: (val) {},
                  secureText: false,
                ),
                ButtonPicker(
                  onTap: (){

                  },
                ),
                ButtonRounded(text: "Tambah")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
