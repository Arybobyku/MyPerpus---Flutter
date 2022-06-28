import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_perpus/model/buku_model.dart';
import 'package:my_perpus/service/buku_service.dart';

class BukuProvider extends ChangeNotifier{
      BukuService _bukuService = BukuService();
     Future<Either<String,bool>> doTambahBuku({required BukuModel buku,required File coverBuku})async{
    try{
      var hasil = await _bukuService.simpanGambar(buku,coverBuku);
      await _bukuService.setBuku(hasil);
      return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

}