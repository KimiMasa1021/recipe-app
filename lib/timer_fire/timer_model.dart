import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tea_select/timer_fire/Time.dart';

class TimerModel extends ChangeNotifier{

  List<Time> timeList = [];
  int newTimertime = 0;

  String uid = FirebaseAuth.instance.currentUser.uid;

  Future gettimerList() async {

    final snapshot =
    await FirebaseFirestore
        .instance
        .collection('users')
        .doc(uid)
        .collection('timer')
        .get();

    final docs = snapshot.docs;
    final timeList = docs.map((doc) => Time(doc)).toList();
    this.timeList = timeList;
    notifyListeners();

  }

  bool isdotti = true;
  void swich(){
    isdotti = !isdotti;
    notifyListeners();
  }

  Future getTimerListRealtime() async {

    final snapshots =
    await FirebaseFirestore
        .instance
        .collection('users')
        .doc(uid)
        .collection('timer')
        .snapshots();
    snapshots.listen((snapshot){
      final docs = snapshot.docs;
      final timeList = docs.map((doc) => Time(doc)).toList();
      this.timeList = timeList;
      notifyListeners();
    });
  }


  Future addTimer()async{
    final addtime = FirebaseFirestore.instance.collection('users').doc(uid).collection('timer');
    await addtime.add({
      'time':newTimertime,
    });
  }

  int lastseconds;

  Future viewtimer (Time time)async{
    DocumentSnapshot viewtimertime = await FirebaseFirestore.instance.collection('users').doc(uid).collection('timer').doc(time.documentID).get();
    lastseconds = viewtimertime['time'];
    notifyListeners();
  }


  Future deletetimer (Time time)async{
    final delete =  await FirebaseFirestore.instance.collection('users').doc(uid).collection('timer').doc(time.documentID).delete();
    notifyListeners();
  }


}