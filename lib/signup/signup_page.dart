import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_select/main_fire/StartPage.dart';
import 'package:tea_select/signup/signup_model.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController();
    final passwordController = TextEditingController();



    return Scaffold(
      backgroundColor:Colors.pinkAccent,
            resizeToAvoidBottomInset: false,
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: Consumer<SignUpModel>(
                builder: (context, model, child){
                  return Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 4),
                                  margin: EdgeInsets.only(left: 40,right: 40,top: 80),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(36)
                                  ),
                                  child: TextField(
                                    onChanged: (text){
                                      model.mail = text;
                                    },
                                    decoration: InputDecoration(
                                        icon: new Icon(Icons.mail_outline_outlined, color: Colors.black,),
                                        hintText: 'mail',
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 4),
                                  margin: EdgeInsets.only(left: 40,right: 40,top: 20),
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
                          Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                                children:[
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.63,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(

                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(190),
                                          topLeft: Radius.circular(190),
                                        )
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top:90.0,bottom: 20),
                                          child: Text('ようこそ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:25
                                            ),
                                          ),
                                        ),
                                        Container(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            child: Text('　このアプリは、レシピの共有とタイマーのプリセットを保存をすることができるができるアプリです。',
                                              style: TextStyle(
                                                fontSize: 20
                                              )
                                              ,)
                                        ),

                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 20,
                                    child: InkWell(
                                      child: Container(
                                        child: Center(
                                            child: Text('新規登録',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17
                                              ),
                                            )),
                                        width: 140,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black38,
                                                  blurRadius: 10.0,
                                                  spreadRadius: 0.5,
                                                  offset: Offset(5,5)
                                              )
                                            ],
                                            color: Colors.yellowAccent
                                        ),
                                      ),
                                      onTap: ()async{
                                        try{
                                          model.startLoading();
                                          await model.signUp();
                                          model.endLoading();


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
                                  ),
                                ]
                            ),
                          )
                        ],
                      ),
                      model.isLoading ? Container(
                        color: Colors.grey.withOpacity(0.6),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ): SizedBox()
                    ],
                  );
                },
              ),
            )
        );
  }
}

