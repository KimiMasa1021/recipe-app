import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_select/main_fire/home.dart';
import 'package:tea_select/timer_fire/timer_list.dart';
import 'package:tea_select/timer_fire/timer_model.dart';


class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _selectedIndex = 0;
  static List<Widget> _pageList = [
    HomePage(),
    TimerList()
  ];
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex  = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Scaffold(
        body: _pageList[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.file_copy_outlined),
                label: 'メニュー'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.access_time_outlined),
                label: 'タイマー'
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}