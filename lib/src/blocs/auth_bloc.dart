import 'dart:async';

import 'package:taxi_app/src/firebase/firebase_auth.dart';

class AuthBloc {
  var _firAuth = FirAuth();
  StreamController _nameController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passController = new StreamController();
  StreamController _phoneController = new StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;
  Stream get phoneStream => _phoneController.stream;

  bool isValid(String name, String email, String pass, String phone){
    if(name == null || name.length == 0){
      _nameController.sink.addError("Enter name");
      return false;
    }
    _nameController.sink.add("");

    if(phone == null || phone.length == 0){
      _phoneController.sink.addError("Enter phone");
      return false;
    }
    _phoneController.sink.add("");

    if(email == null || email.length == 0){
      _emailController.sink.addError("Enter email");
      return false;
    }
    _emailController.sink.add("");
    if(pass == null ){
      _passController.sink.addError("Enter password");
      return false;
    }else if(pass.length < 6){
      _passController.sink.addError("Password must be more than 5 characters");
      return false;
    }
    _passController.sink.add("");
    return true;
  }

  void signUp(String email, String pass, String phone, String name,
      Function onSuccess, Function(String) onError) {
    _firAuth.signUp(email, pass, name, phone, onSuccess, onError);
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firAuth.signIn(email, pass, onSuccess, onSignInError);
  }

  void dispose(){
    _nameController.close();
    _emailController.close();
    _passController.close();
    _phoneController.close();
  }
}