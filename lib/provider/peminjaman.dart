import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/model/buku_model.dart';
import 'package:my_perpus/model/peminjaman_model.dart';
import 'package:my_perpus/model/user_model.dart';
import 'package:my_perpus/service/notification.dart';
import 'package:my_perpus/service/peminjaman_service.dart';

import '../service/riwayat_service.dart';

class PeminjamanProvider extends ChangeNotifier{
  PeminjamanService _peminjamanService = PeminjamanService();

  RiwayatService _riwayatService = RiwayatService();
  List<BukuModel> keranjang = [];

  List<PeminjamanModel> riwayatSaya = [];
  late PeminjamanModel detailRiwayat;

  List<PeminjamanModel> deadlinePengembalian = [];

  tambahKeKeranjang(BukuModel model){
    if(keranjang.length<=3){
      keranjang.add(model);
      notifyListeners();
    }
  }

  Future<Either<String,PeminjamanModel>> perpanjangPeminjaman(PeminjamanModel peminjamanModel)async{
    try{
      var result = await _peminjamanService.perpanjangPeminjaman(peminjamanModel);
      riwayatSaya[riwayatSaya.indexWhere((element) =>
      element.id == peminjamanModel.id)] = peminjamanModel;
      notifyListeners();
      return right(result);
    }catch(e){
      return left(e.toString());
    }
  }

  hapusItemDalamKeranjang(String id){
    keranjang.removeWhere((element) => element.id==id);
    notifyListeners();
  }

  detailRiwayatSaya(PeminjamanModel peminjamanModel){
    detailRiwayat = peminjamanModel;
  }

  Future<Either<String,List<BukuModel>>> doPeminjaman(UserModel user, DateTime tanggalPeminjman)async{
    try{
      List<BukuModel> buku = [];
      keranjang.forEach((element)async {
        await _peminjamanService.setPeminjaman(element,user,tanggalPeminjman);
        buku.add(element);
      });
      keranjang = [];
      getRiwayatSaya();
      notifyListeners();
     return right(buku);
    }catch(e){
     return left(e.toString());
    }
  }

  Future<Either<String,bool>> getRiwayatSaya()async{
    try{
      var result = await _riwayatService.getMyPeinjaman();
      riwayatSaya = result;

      riwayatSaya.forEach((element) {
        if(getDurationDifferenceInt(element.tanggalPeminjaman!, element.tanggalPengembalian!)<2 && element.status==2){
          showNotification("Buku ${element.bukuModel.judul} harus segera dikembalikan sebelum tanggal ${parseDate(element.tanggalPengembalian.toString())}");
        }
      });
      notifyListeners();
      return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

  Future showNotification(String message)async{
    await NotificationService.flutterLocalNotificationsPlugin.show(
        12345,
        "Pengembalian Buku",
        message,
        platformChannelSpecifics,
        payload: 'data');
  }

}