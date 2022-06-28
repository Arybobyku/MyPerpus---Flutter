import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_perpus/model/user_model.dart';
import 'package:my_perpus/service/auth_service.dart';
import 'package:my_perpus/service/user_service.dart';

class AuthProvider extends ChangeNotifier{
  final AuthService _authService = AuthService();
  late UserModel user;
  final UserService _userService = UserService();

  Future<Either<String, bool>> doSignIn({
    required String email, required String password
  })async{
    try{
      await _authService.signIn(email: email, password: password);
      return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> doSignUp({
    required UserModel user
  })async{
    try{
      await _authService.signUp(user);
      this.user = user;
      notifyListeners();
      return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String,bool>> doSignOut()async{
    try{
     await _authService.signOut();
      return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

}