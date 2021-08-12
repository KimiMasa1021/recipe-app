import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_select/main_fire/TapedPage.dart';
import 'package:tea_select/main_fire/TeaModel.dart';
import 'package:tea_select/main_fire/home.dart';

class LocalMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<TeaProvider>(builder: (context, model, child) {
      final todoList = model.todoList;
      return Column(
        children: [
          Expanded(
            child: ListView(
              children: todoList
                  .map(
                    (todo) => Stack(
                  children: [
                    Card(
                      margin: const EdgeInsets.only(left:20,right:20,top:5,bottom:5),
                      elevation: 3,
                      child: InkWell(
                        onTap: ()async{
                          await ViewBook(context , model , todo);
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ViewPage()));
                        },
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.17,
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 90,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right:10.0,left:10.0),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.black45,
                                            image: DecorationImage(
                                              image: NetworkImage(todo.imageURL.toString()),
                                              fit: BoxFit.cover,
                                            ),
                                          ),

                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0),
                                        child: Text(todo.name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    height: 80,
                                    child: VerticalDivider(
                                      color: Colors.black54,
                                    )
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom:4.0),
                                        child: Text(todo.recipe,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17
                                          ),),
                                      ),
                                      Text(todo.title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      Text( '調理時間：'+todo.time+'min'),
                                    ],
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 14,
                        right: 20,
                        child: InkWell(
                            onTap: (){
                              showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  title: Text('不適切な投稿の場合、削除をお願いします。'),
                                  actions: [
                                    TextButton(onPressed: ()async{
                                      await deleterecipe(context , model , todo);
                                      Navigator.pop(context);
                                    }, child: Text('削除')),
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text('キャンセル')),
                                  ],
                                );
                              });
                            },
                            child: Icon(Icons.more_vert)))
                  ],
                ),
              ).toList(),
            ),
          ),
          /*Container(
              height: 50,
              child: checkForAd()),*/
        ],
      );
    });
  }
}
