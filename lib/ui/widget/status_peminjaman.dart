import 'package:flutter/material.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';

class StatusPeminjaman extends StatelessWidget {
  const StatusPeminjaman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: kRoundedContainer.copyWith(
        border: Border.all(color: Colors.white,width: 2)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "10 juni 2022",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorPalette.generalSoftGreen),
                child: Text(
                  "Menunggu Konfirmasi",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Text(
            "Ary Boby Siregar",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
