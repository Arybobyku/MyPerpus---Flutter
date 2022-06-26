import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_perpus/model/user_model.dart';

import 'user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    String hobby = '',
  }) async {
    try {
      //NOTE: Create User to Firebase
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //NOTE: Insert to User Model
      UserModel user = UserModel(
          id: userCredential.user!.uid,
          email: email,
          password: password,
          name: name,);
      //NOTE: Register To FireStore
      await UserService().setUser(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  //NOTE: Function to Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  //NOTE: Function to Sign in
  Future<UserModel> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel user =
      await UserService().getUserById(userCredential.user!.uid);
      return user;
    } catch (e) {
      rethrow;
    }
  }
}