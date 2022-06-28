import 'package:flutter/material.dart';
import 'package:my_perpus/model/buku_model.dart';

class PeminjamanProvider extends ChangeNotifier{
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
  
}