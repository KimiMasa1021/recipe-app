import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:tea_select/ad_helper.dart';
import 'package:tea_select/main_fire/StartPage.dart';
import 'package:tea_select/main_fire/TeaModel.dart';
import 'package:tea_select/login/login_model.dart';
import 'package:tea_select/signup/signup_model.dart';
import 'package:tea_select/signup/signup_page.dart';
import 'package:tea_select/timer_fire/timer_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider<LogoinpModel>(
          create: (_) => LogoinpModel()),
      ChangeNotifierProvider<TeaProvider>(
          create: (_) => TeaProvider()..getTeaListRealtime()..getglobalTeaRealtime()),
      ChangeNotifierProvider<SignUpModel>(
          create: (_) => SignUpModel()),
      ChangeNotifierProvider<AuthModel>(
          create: (_) => AuthModel()),
      ChangeNotifierProvider<TimerModel>(
          create: (_) => TimerModel()..getTimerListRealtime()),
    ],
    child:MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool _loggedIn = context.watch<AuthModel>().loggedIn;
    return MaterialApp(
        debugShowCheckedModeBanner:false,
      home: _loggedIn
          ? MyPage()
          : MyLogin(),
    );
  }
}


class MyLogin extends StatefulWidget {

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<LogoinpModel>(
          builder: (context, model, child){
            return Stack(
              children: [
                Column(
                  children: [
                    Container(

                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(

                        children:[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.63,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.pinkAccent,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(190),
                                    bottomLeft: Radius.circular(190)
                                )
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 70, bottom: 20),
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  height: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('images/playstore.png'),
                                      fit: BoxFit.fitWidth,
                                    ),
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 4),
                                  margin: EdgeInsets.only(left: 20,right: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(36)
                                  ),
                                  child: TextField(
                                    onChanged: (text){
                                      model.mail = text;
                                    },
                                    decoration: InputDecoration(
                                        icon: new Icon(Icons.email, color: Colors.black,),
                                        hintText: "Email Address",
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 4),
                                  margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(36)
                                  ),
                                  child: TextField(
                                    obscureText: true,
                                    onChanged: (text){
                                      model.password = text;
                                    },
                                    decoration: InputDecoration(
                                        icon: new Icon(Icons.lock, color: Colors.black,),
                                        hintText: 'password',
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Consumer<LogoinpModel>(builder: (context, model, child,) {
                              return Positioned(
                                bottom: 35,
                                left: MediaQuery.of(context).size.width /3.2,
                                child: InkWell(
                                  child: Container(
                                    width: 140,
                                    height: 70,
                                    decoration:BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 10.0,
                                              spreadRadius: 0.5,
                                              offset: Offset(5,5)
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.yellow
                                    ),
                                    child: Center(
                                      child: Text('ログイン',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17
                                        ),),
                                    ),
                                  ),
                                  onTap: ()async{
                                    try{
                                      model.startLoading();
                                      await model.Logoin();
                                      model.endLoading();
                                      /*Navigator.push(
                                    context, MaterialPageRoute(
                                      builder: (context) => MyPage()),);*/
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context) => MyPage()),
                                              (_) => false);
                                    }catch(e){
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('入力項目が間違っています'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('OK'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  model.endLoading();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:35.0),
                      child: InkWell(
                        child: Container(
                          width: 320,
                          height: 70,
                          decoration:BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 10.0,
                                    spreadRadius: 0.5,
                                    offset: Offset(5,5)
                                )
                              ],
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.yellow
                          ),
                          child: Center(
                            child: Text('初めてのご利用はこちらから',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        onTap: ()async{
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context)=> SignUpPage())
                          );
                        },
                      ),
                    )
                  ],
                ),
                Consumer<LogoinpModel>(builder: (context, model, child,) {
                    return model.isLoading ? Container(
                      color: Colors.grey.withOpacity(0.6),
                      child: Center(
                        child: CircularProgressIndicator(),
                      )
                    ):SizedBox();
                  }
                )
              ],
            );
          }
      ),
    );
  }
}
