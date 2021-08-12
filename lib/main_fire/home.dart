import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_select/ad_helper.dart';
import 'package:tea_select/main_fire/AddMenu.dart';
import 'package:tea_select/main_fire/TapedPage.dart';
import 'package:tea_select/main_fire/Tea.dart';
import 'package:tea_select/main_fire/TeaModel.dart';
import 'package:tea_select/login/login_model.dart';
import 'package:tea_select/main_fire/global_menu.dart';
import 'package:tea_select/main_fire/local_menu.dart';
import 'package:tea_select/main_fire/side_menu.dart';
import 'package:tea_select/signup/signup_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(
            bottom: const TabBar(
                tabs: [
                  Tab(child: Text('Myレシピ'),),
                  Tab(child: Text('Allレシピ'),),
                ]),
            backgroundColor: Colors.red,
            title: Text('レシピ共有スペース'),
            centerTitle: true,
          ),

          body:  TabBarView(
          children:[
            LocalMenu(),
            Global(),
          ]
      ),
          floatingActionButton:
          Consumer<TeaProvider>(builder: (context, model, child) {
            return Container(
              margin: EdgeInsets.only(bottom: 50),
              child: FloatingActionButton.extended(
                backgroundColor: Colors.red,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMenuPage(model),
                    ),
                  );
                },
                label: Text('レシピを追加'),
                icon: Icon(Icons.add),
              ),
            );
          }
          ),
        ),
    );
  }
}



Future ViewBook(BuildContext context , TeaProvider model , Todo todo) async {
    await model.getTapmodel(todo);
}

Future deleterecipe(BuildContext context, TeaProvider model, Todo todo) async {
  await model.deleterecipe(todo);
}
