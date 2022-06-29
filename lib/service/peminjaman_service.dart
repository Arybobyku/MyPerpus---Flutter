import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_perpus/model/buku_model.dart';
import 'package:my_perpus/model/user_model.dart';

class PeminjamanService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _bukuReference =
  FirebaseFirestore.instance.collection('Peminjaman');

  Future<void> setPeminjaman(BukuModel buku,UserModel user)async{
    DateTime tanggalPeminjaman = DateTime.now();
    DateTime tanggalPengembalian = tanggalPeminjaman.add(Duration(days: 14));
    try{
      await  _bukuReference.doc().set({
        'idUser': _auth.currentUser!.uid,
        'bukuModel': buku.toJson(),
        'userModel': user.toJson(),
        'status': 0,
        'tanggalPeminjaman': tanggalPeminjaman,
        'tanggalPengembalian': tanggalPengembalian,
      });
    }catch(e){
      rethrow;
    }
  }

}