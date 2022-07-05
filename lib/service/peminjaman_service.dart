import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_perpus/model/buku_model.dart';
import 'package:my_perpus/model/peminjaman_model.dart';
import 'package:my_perpus/model/user_model.dart';

class PeminjamanService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference _peminjaman =
      FirebaseFirestore.instance.collection('Peminjaman');

  final CollectionReference _bukuReference =
  FirebaseFirestore.instance.collection('Buku');

  final CollectionReference _userReference =
  FirebaseFirestore.instance.collection('Users');

  Future<void> setPeminjaman(BukuModel buku, UserModel user, DateTime tanggalPeminjaman) async {
    DateTime tanggalPengembalian = tanggalPeminjaman.add(Duration(days: 14));
    Random random = new Random();
    int randomNumber = random.nextInt(100);
    String code = "${randomNumber}${DateTime.now().millisecond}${DateTime.now().second}${DateTime.now().minute}${DateTime.now().month}${DateTime.now().year}";
    try {
      await _peminjaman.doc(code).set({
        'idUser': _auth.currentUser!.uid,
        'bukuModel': buku.toJson(),
        'userModel': user.toJson(),
        'status': 0,
        'perpanjang': 0,
        'tanggalPeminjaman': tanggalPeminjaman,
        'tanggalPengembalian': tanggalPengembalian,
      });

      var bukuById = await _bukuReference.doc(buku.id);
      int stokBuku = buku.stok-1;
      bukuById.update({
        "stok":stokBuku
      });

      var userById = await _userReference.doc(_auth.currentUser!.uid);
      userById.update({
        "isOrder":true
      });


    } catch (e) {
      rethrow;
    }
  }

  Future<PeminjamanModel> perpanjangPeminjaman(PeminjamanModel peminjamanModel)async{
    DateTime tanggalPengembalian = peminjamanModel.tanggalPengembalian!.add(Duration(days: 14));
    try{
      var peminjamanById = await _peminjaman.doc(peminjamanModel.id);
      peminjamanById.update({
        "tanggalPengembalian":tanggalPengembalian,
        "perpanjang":peminjamanModel.perpanjang+=1
      });

      peminjamanModel.tanggalPengembalian = tanggalPengembalian;
      return peminjamanModel;

    }catch(e){
      rethrow;
    }
  }

}
