import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tea_select/main_fire/side_menu.dart';
import 'package:tea_select/timer_fire/Time.dart';
import 'package:tea_select/timer_fire/timer.dart';
import 'package:tea_select/timer_fire/timer_model.dart';

class TimerList extends StatelessWidget {



  final _random = Random();

  int newSeconds = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerModel>(builder: (context, model, child) {
      return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text(
            'タイマーリスト',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,

        ),
        body: Consumer<TimerModel>(builder: (context, model, child) {
          final timeList = model.timeList;
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height,
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 17,
                      scrollDirection: Axis.vertical,
                      children: timeList
                          .map(
                            (Time) => InkWell(
                              onTap: () async {
                                await ViewTimerPP(context, model, Time);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TeaTimerPage()),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                    color: Color.fromARGB(
                                        _random.nextInt(256),
                                        _random.nextInt(256),
                                        _random.nextInt(256),
                                        _random.nextInt(256)),
                                    border:
                                        Border.all(color: Colors.black, width: 5)),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Text(
                                        Duration(seconds: Time.time)
                                            .toString()
                                            .replaceAll(RegExp("^0:"), "")
                                            .replaceAll(RegExp("\\..*"), ""),
                                        style: TextStyle(
                                          fontSize: 45,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                        right: MediaQuery.of(context).size.width *0.16,
                                        child: InkWell(
                                          onTap: ()async{
                                            await viewDelete(context, model, Time);
                                          },
                                          child: Icon(Icons.delete,
                                            size: 35,
                                            color: Colors.black,
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 50),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.blueAccent,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                  Text(
                                  '時間をセット',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            )),
                            CupertinoTimerPicker(
                              mode: CupertinoTimerPickerMode.ms,
                              onTimerDurationChanged: (Duration duration) {
                                model.newTimertime = duration.inSeconds;
                              },
                            ),
                            Column(
                              children: [
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.35,
                                  child: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      model.addTimer();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      '追加する',
                                      style: TextStyle(fontSize: 25),
                                    )),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.5,
                                  child: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'キャンセル',
                                      style: TextStyle(fontSize: 25),
                                    )),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.35,
                                  child: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            label: Text(
              'タイマーを追加',
              style: TextStyle(color: Colors.black),
            ),
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ),
      );
    });
  }
}

Future ViewTimerPP(BuildContext context, TimerModel model, Time time) async {
  await model.viewtimer(time);
}
Future viewDelete(BuildContext context, TimerModel model, Time time) async {
  await model.deletetimer(time);
}
