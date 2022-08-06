import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/provider/buku.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/horizontal_book.dart';
import 'package:provider/provider.dart';

class AdminListBukuPage extends StatelessWidget {
  const AdminListBukuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.generalBackgroundColor,
          title: Text(
            "List Buku",
            style: TextStyle(color: ColorPalette.generalPrimaryColor),
          ),
        ),
        body: Consumer<BukuProvider>(builder: (context, valueBuku, _) {
          return Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: ListView.builder(
              itemCount: valueBuku.listBuku.length,
              itemBuilder: (context,index) {
                var buku = valueBuku.listBuku[index];
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.detailBukuGeneral,arguments: buku);
                  },
                  child: Column(
                    children: [
                        SizedBox(height: 20),
                      HorizontalBook(bukuModel: buku),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
