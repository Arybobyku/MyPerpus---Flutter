import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_perpus/model/user_model.dart';

class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('Users');

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'namaLengkap': user.namaLengkap,
        'alamat': user.alamat,
        'jenisIdentitas': user.jenisIdentitas,
        'provinsi': user.provinsi,
        'role': 0,
        'kota': user.kota,
        'tempatLahir': user.tempatLahir,
        'tanggalLahir': user.tanggalLahir,
        'nomorIdentitas': user.nomorIdentitas,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      return UserModel(
        id: id,
         email: snapshot['email'],
         namaLengkap: snapshot['namaLengkap'],
         password: '',
         jenisIdentitas: snapshot['jenisIdentitas'],
         provinsi: snapshot['provinsi'],
         kota: snapshot['kota'],
         role: snapshot['role'],
         alamat: snapshot['alamat'],
         nomorIdentitas: snapshot['nomorIdentitas'],
         tanggalLahir: snapshot['tanggalLahir'],
         tempatLahir: snapshot['tempatLahir'],
      );
    } catch (e) {
      rethrow;
    }
  }
}
