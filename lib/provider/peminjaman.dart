import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_perpus/model/buku_model.dart';
import 'package:my_perpus/model/user_model.dart';
import 'package:my_perpus/service/peminjaman_service.dart';

class PeminjamanProvider extends ChangeNotifier{
  PeminjamanService _peminjamanService = PeminjamanService();
  List<BukuModel> keranjang = [];

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

  Future<Either<String,bool>> doPeminjaman(UserModel user)async{
    try{
      keranjang.forEach((element)async {
        await _peminjamanService.setPeminjaman(element,user);
      });
      keranjang = [];
      notifyListeners();
     return right(true);
    }catch(e){
     return left(e.toString());
    }
  }

}