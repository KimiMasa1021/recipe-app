import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoinpModel extends ChangeNotifier{

  bool isLoading = false;

  startLoading(){
    isLoading = true;
    notifyListeners();
  }

  endLoading(){
    isLoading = false;
    notifyListeners();
  }


  String mail = '';
  String password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future Logoin() async {

    mail.isEmpty ? throw('メールアドレスを入力してね'):null;
    password.isEmpty ? throw('パスワードを入力してね'):null;

    final result =  await _auth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );

    final uid= result.user.uid;

    print(uid);

  }
  Future Logout() async {
    await FirebaseAuth.instance.signOut();
  }
}









class AuthModel extends ChangeNotifier {
  User _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthModel() {
    final User _currentUser = _auth.currentUser;

    if (_currentUser != null) {
      _user = _currentUser;
      notifyListeners();
    }
  }

  User get user => _user;
  bool get loggedIn => _user != null;

}
