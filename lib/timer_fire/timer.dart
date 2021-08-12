import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tea_select/ad_helper.dart';
import 'package:tea_select/timer_fire/timer_model.dart';





class TeaTimerPage extends StatefulWidget {

  const TeaTimerPage({Key key}) : super(key: key);

  @override
  _TeaTimerPageState createState() => _TeaTimerPageState();
}

class _TeaTimerPageState extends State<TeaTimerPage> {

  CountDownController _controller = CountDownController();
  BannerAd _ad;

  bool isLoading;

  @override
  void initState(){
    super.initState();

    _ad = BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: AdRequest(),
        size: AdSize.largeBanner,
        listener: BannerAdListener(
          onAdLoaded: (_){
            setState(() {
              isLoading = true;
            });
          },
          onAdFailedToLoad: (_,error){
            print('Ad fireled to load with error: $error');
          },
        )
    );
    _ad.load();
  }
  @override
  void dispose(){
    _ad?.dispose();
    super.dispose();
  }

  Widget checkForAd (){
    if(isLoading == true){
      return Container(
        child: AdWidget(ad: _ad,),
        width: _ad.size.width.toDouble(),
        alignment: Alignment.center,
      );
    }else{
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('キッチンタイマー'),
        centerTitle: true,
      ),
      body: Consumer<TimerModel>(builder: (context, model, child) {

        int _defaultSeconds = model.lastseconds;

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 100,
                  child: checkForAd()),
              CircularCountDownTimer(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                duration: _defaultSeconds,
                ringColor: Colors.grey,
                fillColor: Colors.blueAccent,
                controller: _controller,
                backgroundColor: Colors.white54,
                strokeWidth: 30.0,
                strokeCap: StrokeCap.round,
                isTimerTextShown: true,
                isReverse: false,
                autoStart: false,
                onComplete: (){

                  if(model.isdotti == false){
                    FlutterRingtonePlayer.playAlarm();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("完了"),
                          content: new Text("設定したタイマーが終了しました。"),
                          actions: <Widget>[
                            new TextButton(
                              child: new Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                FlutterRingtonePlayer.stop();
                              },
                            ),
                          ],
                        );
                      },
                    );

                  }

                },
                textStyle: TextStyle(fontSize: 50.0,color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(3, 3)
                            )
                          ],
                          shape: BoxShape.circle,
                          color: Colors.white
                      ),
                      child: InkWell(
                        onTap: (){

                          model.isdotti ? _controller.resume() : _controller.pause();
                          model.swich();

                        },
                        child: Center(child:  model.isdotti ? Icon(Icons.play_arrow,size: 50,) : Icon(Icons.pause,size: 50,),
                        ),),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(3, 3)
                            )
                          ],
                          shape: BoxShape.circle,
                            color: Colors.white
                        ),
                        child: InkWell(
                          onTap: (){
                            _controller.restart(duration: _defaultSeconds,);
                          },
                          child: Icon(Icons.repeat_sharp,
                            size: 50,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
