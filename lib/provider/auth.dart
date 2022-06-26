import 'package:fpdart/fpdart.dart';
import 'package:my_perpus/service/auth_service.dart';
import 'package:my_perpus/service/user_service.dart';

class AuthProvider{
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  bool isLoading = false;

  Future<Either<String,bool>> doSignIn({
    required String email, required String password
  })async{
    try{
      isLoading = true;
      await _authService.signIn(email: email, password: password);
      isLoading = false;
      return right(true);
    }catch(e){
      isLoading = false;
      return left(e.toString());
    }
  }

  Future<Either<String,bool>> doSignOut()async{
    try{
      isLoading = true;
     await _authService.signOut();
      isLoading =false;
      return right(true);
    }catch(e){
      isLoading = false;
      return left(e.toString());
    }
  }

}