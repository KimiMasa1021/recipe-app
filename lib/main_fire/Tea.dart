

import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  Todo(DocumentSnapshot doc){
    this.documentID = doc.id;
    this.title = doc['title'];
    this.recipe = doc['recipe'];
    this.material = doc['material'];
    this.time = doc['time'];
    this.name = doc['name'];
    this.imageURL = doc['imageURL'];
  }
  String documentID;
  String time;
  String material;
  String recipe;
  String title;
  String name;
  String imageURL;
}
