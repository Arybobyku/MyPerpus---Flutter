import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_perpus/model/peminjaman_model.dart';
import 'package:my_perpus/service/admin_service.dart';

class AdminProvider extends ChangeNotifier{
  AdminService _adminService = AdminService();
  List<PeminjamanModel> listPeminjaman = [];
  late PeminjamanModel detailPeminjaman;

  Future<Either<String, List<PeminjamanModel>>>  getAllPeminjaman()async{
     try{
     var result = await  _adminService.getAllPeminjaman();
     listPeminjaman = result;
     notifyListeners();
     return right(result);
     }catch(e){
       print("MY ERROR ${e}");
       return left(e.toString());
     }
  }

  onClickDetailPeminjaman(PeminjamanModel peminjaman){
    detailPeminjaman = peminjaman;
    notifyListeners();
  }

  Future<Either<String,bool>> doKonfirmasiPeminjaman()async{
    try{
     await _adminService.konfirmasiPeminjaman(detailPeminjaman);
     detailPeminjaman.status = 1;
     listPeminjaman[listPeminjaman.indexWhere((element) => element.id == detailPeminjaman.id)] = detailPeminjaman;
     notifyListeners();
     return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

}