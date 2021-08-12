

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Time {

  Time(DocumentSnapshot doc){
    this.documentID = doc.id;
    this.time = doc['time'];
  }
  int time;
  String documentID;
}
