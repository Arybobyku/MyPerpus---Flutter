import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_perpus/model/buku_model.dart';
import 'package:my_perpus/service/buku_service.dart';

class BukuProvider extends ChangeNotifier {
  BukuService _bukuService = BukuService();
  List<BukuModel> listBuku = [];
  List<BukuModel> searchResult = [];

  BukuModel? bukuDetail = null;

  Future<Either<String, bool>> doTambahBuku(
      {required BukuModel buku, required File coverBuku}) async {
    try {
      var hasil = await _bukuService.simpanGambar(buku, coverBuku);
      await _bukuService.setBuku(hasil);
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<BukuModel>>> doGetAllBook() async {
    try {
      var result = await _bukuService.getAllBuku();
      listBuku = result;
      notifyListeners();
      return right(result);
    } catch (e) {
      return left(e.toString());
    }
  }

  clickBukuDetail(BukuModel bukuModel) {
    bukuDetail = bukuModel;
    notifyListeners();
  }

  searchBook(String keyword) {
    searchResult = listBuku.where((element) =>
    element.judul.toLowerCase().contains(keyword) ||
        element.pengarang.toLowerCase().contains(keyword) ||
        element.penerbit.toLowerCase().contains(keyword)
    ).toList();
    notifyListeners();
  }
}
