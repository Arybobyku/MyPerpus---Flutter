import 'package:cached_network_image/cached_network_image.dart';
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
        body: Consumer3<BukuProvider, PeminjamanProvider, AuthProvider>(
            builder: (context, valueBuku, valuePeminjaman, valuAuth, _) {
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
                        CachedNetworkImage(
                          imageUrl: valueBuku.bukuDetail!.gambar!,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 300,
                            width: double.infinity,
                            foregroundDecoration: valueBuku.bukuDetail!.stok > 0
                                ? BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fitHeight),
                                  )
                                : BoxDecoration(
                                    color: ColorPalette.generalSoftGrey,
                                    backgroundBlendMode: BlendMode.saturation,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
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
                        VerticalTitleValue(
                            title: 'Stok Buku',
                            value: valueBuku.bukuDetail!.stok.toString()),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                if (valuePeminjaman.riwayatSaya
                    .any((element) => element.status > 3) ||valuePeminjaman.riwayatSaya.isEmpty)
                  if (valuAuth.user.isValid)
                    if (valueBuku.bukuDetail!.stok > 0)
                      if (!valuePeminjaman.keranjang.any(
                          (element) => element.id == valueBuku.bukuDetail!.id))
                        ButtonRounded(
                          text: "Tambah Buku",
                          onPressed: () {
                            Provider.of<PeminjamanProvider>(context,
                                    listen: false)
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
