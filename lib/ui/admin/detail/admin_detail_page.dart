import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/provider/admin.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:my_perpus/ui/widget/horizontal_book.dart';
import 'package:my_perpus/ui/widget/status_container.dart';
import 'package:my_perpus/ui/widget/vertical_title_value.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AdminDetailPage extends StatefulWidget {
  const AdminDetailPage({Key? key}) : super(key: key);

  @override
  _AdminDetailPageState createState() => _AdminDetailPageState();
}

class _AdminDetailPageState extends State<AdminDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AdminProvider>(builder: (context, valueAdmin, _) {
        return Scaffold(
          backgroundColor: ColorPalette.generalBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:valueAdmin.detailPeminjaman.bukuModel.length,
                            itemBuilder: (context,index){
                         return Padding(
                           padding: const EdgeInsets.only(top: 20),
                           child: GestureDetector(
                             onTap: (){
                               Get.toNamed(Routes.detailBukuGeneral,arguments: valueAdmin.detailPeminjaman.bukuModel[index]);
                             },
                             child: HorizontalBook(
                                  bukuModel: valueAdmin.detailPeminjaman.bukuModel[index]),
                           ),
                         );
                        }),

                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: VerticalTitleValue(
                                  title: 'ID Peminjaman',
                                  value: valueAdmin.detailPeminjaman.id ?? "-"),
                            ),
                            StatusContainer(
                                status: valueAdmin.detailPeminjaman.status)
                          ],
                        ),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Nama Peminjam',
                            value: valueAdmin
                                .detailPeminjaman.userModel.namaLengkap),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Email Peminjam',
                            value: valueAdmin.detailPeminjaman.userModel.email),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Jenis Identitas Peminjaman',
                            value: valueAdmin
                                .detailPeminjaman.userModel.jenisIdentitas),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Identitas Peminjaman',
                            value: valueAdmin
                                .detailPeminjaman.userModel.nomorIdentitas),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Tanggal Peminjaman',
                            value: parseDate(valueAdmin
                                .detailPeminjaman.tanggalPeminjaman
                                .toString())),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Tanggal Pengembalian',
                            value: parseDate(valueAdmin
                                .detailPeminjaman.tanggalPengembalian
                                .toString())),

                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),

                if(valueAdmin.detailPeminjaman.status==0)
                  ButtonRounded(
                    text: "Konfirmasi Pengambilan Buku",
                    onPressed: () => doKonfirmasiPengambilan(context),
                  ),
                if(valueAdmin.detailPeminjaman.status==1)
                Row(
                  children: [
                    Expanded(
                      child: ButtonRounded(
                        text: "Konfirmasi",
                        onPressed: () => doKonfirmasiPeminjaman(context),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ButtonRounded(
                        text: "Batalkan",
                        invert: true,
                        onPressed: () => doKonfirmasiPembatalan(context),
                      ),
                    ),
                  ],
                ),
                if(valueAdmin.detailPeminjaman.status==2)
                  ButtonRounded(
                    text: "Konfirmasi Pengembalian",
                    onPressed: () => doKonfirmasiPengembalian(context),
                  ),

              ],
            ),
          ),
        );
      }),
    );
  }

  doKonfirmasiPeminjaman(BuildContext context) async {
    EasyLoading.show(status: "Loading");
    var result = await Provider.of<AdminProvider>(context, listen: false)
        .doKonfirmasiPeminjaman();

    result.fold((l) {
      EasyLoading.dismiss();
      Alert(
        context: context,
        type: AlertType.error,
        title: "Gagal",
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
      Alert(
        context: context,
        type: AlertType.success,
        title: "Sukses",
        desc: "Sukses konfirmasi peminjaman",
        buttons: [
          DialogButton(
            child: Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){
              Navigator.pop(context);
              Get.back();
            },
            color: ColorPalette.generalPrimaryColor,
            radius: BorderRadius.circular(0.0),
          ),
        ],
      ).show();
    });
  }

  doKonfirmasiPengambilan(BuildContext context) async {
    EasyLoading.show(status: "Loading");
    var result = await Provider.of<AdminProvider>(context, listen: false)
        .doKonfirmasiPengambilan();

    result.fold((l) {
      EasyLoading.dismiss();
      Alert(
        context: context,
        type: AlertType.error,
        title: "Gagal",
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
      Alert(
        context: context,
        type: AlertType.success,
        title: "Sukses",
        desc: "Sukses konfirmasi pengambilan",
        buttons: [
          DialogButton(
            child: Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){
              Navigator.pop(context);
              Get.back();
            },
            color: ColorPalette.generalPrimaryColor,
            radius: BorderRadius.circular(0.0),
          ),
        ],
      ).show();
    });
  }

  doKonfirmasiPengembalian(BuildContext context) async {
    EasyLoading.show(status: "Loading");
    var result = await Provider.of<AdminProvider>(context, listen: false)
        .doKonfirmasiPengembalian();

    result.fold((l) {
      EasyLoading.dismiss();
      Alert(
        context: context,
        type: AlertType.error,
        title: "Gagal",
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
      Alert(
        context: context,
        type: AlertType.success,
        title: "Sukses",
        desc: "Sukses konfirmasi pengembalian",
        buttons: [
          DialogButton(
            child: Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){
              Navigator.pop(context);
              Get.back();
            },
            color: ColorPalette.generalPrimaryColor,
            radius: BorderRadius.circular(0.0),
          ),
        ],
      ).show();
    });
  }

  doKonfirmasiPembatalan(BuildContext context) async {
    EasyLoading.show(status: "Loading");
    var result = await Provider.of<AdminProvider>(context, listen: false)
        .doKonfirmasiPembatalan();

    result.fold((l) {
      EasyLoading.dismiss();
      Alert(
        context: context,
        type: AlertType.error,
        title: "Gagal",
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
      Alert(
        context: context,
        type: AlertType.success,
        title: "Sukses",
        desc: "Sukses konfirmasi pembatalan",
        buttons: [
          DialogButton(
            child: Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){
              Navigator.pop(context);
              Get.back();
            },
            color: ColorPalette.generalPrimaryColor,
            radius: BorderRadius.circular(0.0),
          ),
        ],
      ).show();
    });
  }
}
