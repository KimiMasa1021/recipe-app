import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:tea_select/ad_helper.dart';
import 'package:tea_select/main_fire/Share_model.dart';
import 'package:tea_select/main_fire/TeaModel.dart';



class ViewPage extends StatelessWidget {

  final GlobalKey shareKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: shareKey,
      child: Scaffold(
          body:Consumer<TeaProvider>(builder: (context, model, child){
            return
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.3,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(model.viewImage.toString()),
                                            fit: BoxFit.cover,
                                          ),
                                          color: Colors.pinkAccent
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child:Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size.width,
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.6)
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Row(
                                                      children:[
                                                        Icon(Icons.account_circle_outlined, color: Colors.black,size:40,),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:5.0,right: 5),
                                                          child: Text(model.viewTodo,
                                                            style: TextStyle(
                                                              fontSize: 24,
                                                            ),
                                                          ),
                                                        ),
                                                      ]
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.6)
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Icon(Icons.timer, color: Colors.black,size:40,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:5.0,right: 5),
                                                    child: Text(model.viewTime+"min",
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ]
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:3.0),
                                child: Text(model.viewItem,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                decoration: BoxDecoration(
                                  boxShadow:[
                                    BoxShadow(
                                      color: Colors.black45,
                                      offset: Offset(0,0),
                                      blurRadius: 10.0,
                                      spreadRadius: 0.5
                                    )
                                  ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0,top: 10),
                                      child: Text('作り方',
                                        style: TextStyle(
                                          fontSize: 19,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 30),
                                      child: Text(model.viewText,
                                        style: TextStyle(

                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 40.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.95,
                                  decoration: BoxDecoration(
                                      boxShadow:[
                                        BoxShadow(
                                            color: Colors.black45,
                                            offset: Offset(0,0),
                                            blurRadius: 10.0,
                                            spreadRadius: 0.5
                                        )
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0,top: 10),
                                        child: Text('材料',
                                          style: TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 30),
                                        child: Text(model.viewName,
                                          style: TextStyle(

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.03,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
             );

          },
          ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.share,),
          onPressed: (){
            ShareProvider().shareImageAndText('レシピシェア', shareKey);
          },
        ),
      ),
    );
  }
}
