import 'package:covid19/botom_nav_Bar.dart';
import 'package:covid19/providers/country_provider.dart';
import 'package:covid19/providers/global_provider.dart';
import 'package:covid19/providers/history_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalProvider(),),
        ChangeNotifierProvider(create: (_)=>CountryProvider(),),
        ChangeNotifierProvider(create: (_)=>HistoryProvider(),)
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: BotomNavBar(),
      ),
    );
  }
}

