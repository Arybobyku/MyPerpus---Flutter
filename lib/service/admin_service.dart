import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_perpus/model/peminjaman_model.dart';

class AdminService{
  final CollectionReference _peminjamanReference =
  FirebaseFirestore.instance.collection('Peminjaman');

  final CollectionReference _bukuReference =
  FirebaseFirestore.instance.collection('Buku');

  Future<List<PeminjamanModel>> getAllPeminjaman()async{
    try{
      QuerySnapshot result = await _peminjamanReference.get();
      List<PeminjamanModel> listPeminjaman = result.docs.map((e){
        return PeminjamanModel.fromjson(e.data() as Map<String, dynamic>, e.id);
      }).toList();
      print("Get Peminjaman From Firebase ${listPeminjaman.length}");
      return listPeminjaman;
    }catch(e){
      rethrow;
    }
  }

  konfirmasiPeminjaman(PeminjamanModel peminjaman)async{
      try{
        var peminjamanById = await _peminjamanReference.doc(peminjaman.id);
        peminjamanById.update({
          "status":1
        });

        var bukuById = await _bukuReference.doc(peminjaman.bukuModel.id);
        bukuById.update({
          "isAvailable":false
        });
      }catch(e){
        rethrow;
      }
  }

  konfirmasiPengambilan(PeminjamanModel peminjaman)async{
    try{
      var peminjamanById = await _peminjamanReference.doc(peminjaman.id);
      peminjamanById.update({
        "status":2
      });
    }catch(e){
      rethrow;
    }
  }

  konfirmasiPengembalian(PeminjamanModel peminjaman)async{
    try{
      var peminjamanById = await _peminjamanReference.doc(peminjaman.id);
      peminjamanById.update({
        "status":3
      });

      var bukuById = await _bukuReference.doc(peminjaman.bukuModel.id);
      bukuById.update({
        "isAvailable":true
      });
    }catch(e){
      rethrow;
    }
  }
}