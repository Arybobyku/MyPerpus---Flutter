import 'package:flutter/material.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/provider/peminjaman.dart';
import 'package:my_perpus/ui/widget/horizontal_book.dart';
import 'package:my_perpus/ui/widget/status_container.dart';
import 'package:my_perpus/ui/widget/vertical_title_value.dart';
import 'package:provider/provider.dart';

class UserDetailRiwayat extends StatelessWidget {
  const UserDetailRiwayat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<PeminjamanProvider>(
        builder: (context,peminjaman,_) {
          return Scaffold(
            body: SingleChildScrollView(
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
                              value: parseDate( peminjaman.detailRiwayat.tanggalPeminjaman.toString())),
                        ),
                        StatusContainer(
                            status: peminjaman.detailRiwayat.status)
                      ],
                    ),
                    SizedBox(height: 20),
                    VerticalTitleValue(
                        title: 'Tanggal Pengembalian',
                        value: parseDate( peminjaman.detailRiwayat.tanggalPengembalian.toString())),
                    SizedBox(height: 20),
                    VerticalTitleValue(
                        title: 'ID Peminjaman',
                        value: peminjaman.detailRiwayat.id ?? "-"),
                    SizedBox(height: 20),
                    VerticalTitleValue(
                        title: 'Hari Pengembalian',
                        value:getDurationDifference(peminjaman.detailRiwayat.tanggalPeminjaman!,peminjaman.detailRiwayat.tanggalPengembalian!)),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
