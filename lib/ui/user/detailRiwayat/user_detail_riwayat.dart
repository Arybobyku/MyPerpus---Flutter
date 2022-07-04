import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/model/peminjaman_model.dart';
import 'package:my_perpus/provider/peminjaman.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:my_perpus/ui/widget/horizontal_book.dart';
import 'package:my_perpus/ui/widget/status_container.dart';
import 'package:my_perpus/ui/widget/vertical_title_value.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserDetailRiwayat extends StatelessWidget {
  const UserDetailRiwayat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<PeminjamanProvider>(builder: (context, peminjaman, _) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        HorizontalBook(
                            bukuModel: peminjaman.detailRiwayat.bukuModel),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: VerticalTitleValue(
                                  title: 'Tanggal Peminjaman',
                                  value: parseDate(peminjaman
                                      .detailRiwayat.tanggalPeminjaman
                                      .toString())),
                            ),
                            StatusContainer(
                                status: peminjaman.detailRiwayat.status)
                          ],
                        ),
                        SizedBox(height: 20),
                        VerticalTitleValue(
                            title: 'Tanggal Pengembalian',
                            value: parseDate(peminjaman
                                .detailRiwayat.tanggalPengembalian
                                .toString())),
                        SizedBox(height: 20),
                        VerticalTitleValue(
                            title: 'ID Peminjaman',
                            value: peminjaman.detailRiwayat.id ?? "-"),
                        SizedBox(height: 20),
                        VerticalTitleValue(
                            title: 'Hari Pengembalian',
                            value: getDurationDifference(
                                DateTime.now(),
                                peminjaman.detailRiwayat.tanggalPengembalian!)),
                      ],
                    ),
                  ),
                ),
              ),
              if (peminjaman.detailRiwayat.perpanjang < 1 && peminjaman.detailRiwayat.status==2)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ButtonRounded(
                    text: "Perpanjang peminjaman",
                    onPressed: () {
                      doPerpanjangan(context, peminjaman.detailRiwayat);
                    },
                  ),
                )
            ],
          ),
        );
      }),
    );
  }

  doPerpanjangan(BuildContext context, PeminjamanModel peminjamanModel) async {
    EasyLoading.show(status: "Loading...");
    var result = await Provider.of<PeminjamanProvider>(context, listen: false)
        .perpanjangPeminjaman(peminjamanModel);
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
            onPressed: () {
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
