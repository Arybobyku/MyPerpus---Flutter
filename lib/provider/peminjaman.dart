import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_perpus/model/buku_model.dart';
import 'package:my_perpus/model/peminjaman_model.dart';
import 'package:my_perpus/model/user_model.dart';
import 'package:my_perpus/service/peminjaman_service.dart';

import '../service/riwayat_service.dart';

class PeminjamanProvider extends ChangeNotifier{
  PeminjamanService _peminjamanService = PeminjamanService();

  RiwayatService _riwayatService = RiwayatService();
  List<BukuModel> keranjang = [];

  List<PeminjamanModel> riwayatSaya = [];
  late PeminjamanModel detailRiwayat;

  tambahKeKeranjang(BukuModel model){
    if(keranjang.length<=3){
      keranjang.add(model);
      notifyListeners();
    }
  }

  hapusItemDalamKeranjang(String id){
    keranjang.removeWhere((element) => element.id==id);
    notifyListeners();
  }

  detailRiwayatSaya(PeminjamanModel peminjamanModel){
    detailRiwayat = peminjamanModel;
  }

  Future<Either<String,List<BukuModel>>> doPeminjaman(UserModel user)async{
    try{
      List<BukuModel> buku = [];
      keranjang.forEach((element)async {
        await _peminjamanService.setPeminjaman(element,user);
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
      notifyListeners();
      return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

}