import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/provider/auth.dart';
import 'package:my_perpus/provider/buku.dart';
import 'package:my_perpus/provider/peminjaman.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:my_perpus/ui/widget/horizontal_book.dart';
import 'package:my_perpus/ui/widget/vertical_title_value.dart';
import 'package:provider/provider.dart';

class UserDetailBukuPage extends StatelessWidget {
  const UserDetailBukuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer3<BukuProvider, PeminjamanProvider,AuthProvider>(
            builder: (context, valueBuku, valuePeminjaman,valuAuth, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 300,
                          width: double.infinity,
                          foregroundDecoration:
                              valueBuku.bukuDetail!.isAvailable!
                                  ? BoxDecoration()
                                  : BoxDecoration(
                                      color: ColorPalette.generalSoftGrey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image:
                                  NetworkImage(valueBuku.bukuDetail!.gambar!),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          valueBuku.bukuDetail!.judul,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        VerticalTitleValue(
                            title: 'Pengarang',
                            value: valueBuku.bukuDetail!.pengarang),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Penerbit',
                            value: valueBuku.bukuDetail!.penerbit),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Jenis Buku',
                            value: valueBuku.bukuDetail!.bentukKaryaTulis),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Tahun Terbit',
                            value: valueBuku.bukuDetail!.tahunTerbit),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                if(!valuAuth.user.isOrder)
                if(valueBuku.bukuDetail!.isAvailable!)
                if (!valuePeminjaman.keranjang.any((element) => element.id==valueBuku.bukuDetail!.id))
                  ButtonRounded(
                    text: "Tambah Buku",
                    onPressed: () {
                      Provider.of<PeminjamanProvider>(context,listen: false)
                          .tambahKeKeranjang(valueBuku.bukuDetail!);
                      Get.back();
                    },
                  )
              ],
            ),
          );
        }),
      ),
    );
  }
}
