import 'package:flutter/material.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/model/peminjaman_model.dart';

class StatusPeminjaman extends StatelessWidget {
  const StatusPeminjaman({Key? key,required this.peminjamanModel}) : super(key: key);
final PeminjamanModel peminjamanModel;
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
                 parseDate(peminjamanModel.tanggalPeminjaman.toString()),
                  style: TextStyle(fontSize: 16,),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorPalette.generalSoftGreen),
                child: Text(
                  checkStatus(peminjamanModel.status),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Text(
           "ID Peminjaman: "+ peminjamanModel.id!,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(
            peminjamanModel.userModel.email,
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
