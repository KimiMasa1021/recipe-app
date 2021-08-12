import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tea_select/main_fire/Tea.dart';

class TeaProvider extends ChangeNotifier {
  List<Todo> todoList = [];
  List<Todo> globalList = [];
  String newTeaText = '';
  String newTeaTodo = '';
  String newTeaItem = '';
  String newTeaTime = '';
  String newUpername = '';
  bool isLoading = false;
  startLoading(){
    isLoading = true;
    notifyListeners();
  }
  endLoading(){
    isLoading = false;
    notifyListeners();
  }


  Future getTeaList() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('todoList').where('myUid', isEqualTo:uid).get();
    final docs = snapshot.docs;
    final todoList = docs.map((doc) => Todo(doc)).toList();
    this.todoList = todoList;
    notifyListeners();
  }

  Future getglobalTeaList() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('todoList').where('myUid', isNotEqualTo:uid).get();
    final docs = snapshot.docs;
    final todoList = docs.map((doc) => Todo(doc)).toList();
    this.globalList = todoList;
    notifyListeners();
  }

  String viewText;
  String viewTodo;
  String viewItem;
  String viewTime;
  String viewName;
  String viewImage;


  Future<String> getTapmodel(Todo todo) async {
    DocumentSnapshot docSnapshot =
    await FirebaseFirestore.instance.collection('todoList').doc(todo.documentID).get();

    viewText = docSnapshot['title'];
    viewTodo = docSnapshot['name'];
    viewItem = docSnapshot['recipe'];
    viewTime = docSnapshot['time'];
    viewName = docSnapshot['material'];
    viewImage = docSnapshot['imageURL'];
    notifyListeners();
  }

  Future deleterecipe (Todo todo)async{
    final delete =  await FirebaseFirestore.instance.collection('todoList').doc(todo.documentID).delete();
    notifyListeners();
  }


  File imageFile;
//画像fileアプリ立ち上げ
  Future showImagepicker() async{
    final picker = ImagePicker();
    final pickerfire = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickerfire.path);
    notifyListeners();
  }
//FIREBASEアップロード
  Future<String> _uploadImage()async{
    if (imageFile == null) {
      return '';
    }
    final storage = FirebaseStorage.instance;
    TaskSnapshot snapshot = await storage
        .ref()
        .child("todoList/$newTeaTodo")
        .putFile(imageFile);
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  String uid = FirebaseAuth.instance.currentUser.uid;


//FIREBASEゲットとリアルタイムゲット　↓
  Future add() async{

    final imageURL = await _uploadImage();

    final collection = FirebaseFirestore.instance.collection('todoList');
    await collection.add({
      'title': newTeaText,
      'recipe' : newTeaTodo,
      'material' :newTeaItem,
      'time' : newTeaTime,
      'name' : newUpername,
      'imageURL' : imageURL,
      'myUid':uid,
    });
  }
  Future getTeaListRealtime() async {
    final snapshots =
    await FirebaseFirestore.instance.collection('todoList').where('myUid', isEqualTo:uid).snapshots();

    snapshots.listen((snapshot){
      final docs = snapshot.docs;
      final todoList = docs.map((doc) => Todo(doc)).toList();
      this.todoList = todoList;
      notifyListeners();
    });

  }
  Future getglobalTeaRealtime() async {
    final snapshots =
    await FirebaseFirestore.instance.collection('todoList').where('myUid', isNotEqualTo:uid).snapshots();

    snapshots.listen((snapshot){
      final docs = snapshot.docs;
      final todoList = docs.map((doc) => Todo(doc)).toList();
      this.globalList = todoList;
      notifyListeners();
    });

  }



}
