import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_perpus/model/peminjaman_model.dart';

class AdminService{
  final CollectionReference _peminjamanReference =
  FirebaseFirestore.instance.collection('Peminjaman');

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
}