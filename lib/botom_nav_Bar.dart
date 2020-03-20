import 'package:covid19/screens/by_country.dart';
import 'package:covid19/screens/home_screen.dart';
import 'package:covid19/screens/kasus_indonesia.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotomNavBar extends StatefulWidget {
  @override
  _BotomNavBarState createState() => _BotomNavBarState();
}

class _BotomNavBarState extends State<BotomNavBar> {
  int _currentIndex = 0;
  List<Widget>_children =[
    Home(),
    ByCountry(),
    KasusIndonesia(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        backgroundColor: Color(0xFFECF0F3),
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.globe),
            title: Text('Global')
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidFlag),
            title: Text('Negara')
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.history),
            title: Text('Kasus')
          )
        ],
      ),
    );
  }
  void onTap(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}
