import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_select/login/login_model.dart';
import 'package:tea_select/main_fire/home.dart';
import 'package:tea_select/main.dart';
import 'package:tea_select/timer_fire/timer_list.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Consumer<LogoinpModel>(builder: (context, model, child) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.yellow
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom:12.0,
                        left: 16.0,
                        child: Text('Menu',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                          ),
                        ))
                  ],
                )
              ),
                ListTile(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('ログアウトしますか？'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('はい'),
                              onPressed: () {
                                model.Logout();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyLogin(),
                                  ),
                                );
                              },
                            ),
                            TextButton(
                              child: Text('いいえ'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  title: Row(
                    children: [
                      Icon(Icons.settings),
                      Padding(
                        padding: const EdgeInsets.only(left:14.0),
                        child: Text('ログアウト'),
                      ),
                      Expanded(child: SizedBox()),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
            ],
          ),
    );
        }
      );
  }
}
