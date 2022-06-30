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

  Future<void> setPeminjaman(BukuModel buku, UserModel user) async {
    DateTime tanggalPeminjaman = DateTime.now();
    DateTime tanggalPengembalian = tanggalPeminjaman.add(Duration(days: 14));
    try {
      await _peminjaman.doc().set({
        'idUser': _auth.currentUser!.uid,
        'bukuModel': buku.toJson(),
        'userModel': user.toJson(),
        'status': 0,
        'tanggalPeminjaman': tanggalPeminjaman,
        'tanggalPengembalian': tanggalPengembalian,
      });

      var bukuById = await _bukuReference.doc(buku.id);
      bukuById.update({
        "isAvailable":false
      });

    } catch (e) {
      rethrow;
    }
  }
}
