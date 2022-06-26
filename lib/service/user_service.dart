import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_perpus/model/user_model.dart';

class UserService {
  final CollectionReference _userReference = FirebaseFirestore.instance.collection('Users');

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'name': user.name,
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
        name: snapshot['name'],
        password: '',
      );
    } catch (e) {
      rethrow;
    }
  }
}