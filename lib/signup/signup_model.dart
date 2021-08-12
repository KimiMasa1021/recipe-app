import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier{
  String mail = '';
  String password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUp() async {

    final User user = (await _auth.createUserWithEmailAndPassword(
      email: mail,
      password: password,
    )).user;

    final email = user.email;
    FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'email': email,
      'createdAt': Timestamp.now(),
     });

  }

  bool isLoading = false;

  startLoading(){
    isLoading = true;
    notifyListeners();
  }

  endLoading(){
    isLoading = false;
    notifyListeners();
  }
  }