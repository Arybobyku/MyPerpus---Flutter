import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_perpus/model/peminjaman_model.dart';
import 'package:my_perpus/service/admin_service.dart';

class AdminProvider extends ChangeNotifier{
  AdminService _adminService = AdminService();
  List<PeminjamanModel> listPeminjaman = [];

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

}