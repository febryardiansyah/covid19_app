import 'package:covid19/botom_nav_Bar.dart';
import 'package:covid19/models/province_provider.dart';
import 'package:covid19/providers/country_provider.dart';
import 'package:covid19/providers/global_provider.dart';
import 'package:covid19/providers/history_provider.dart';
import 'package:covid19/providers/version_provider.dart';
import 'package:covid19/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalProvider(),),
        ChangeNotifierProvider(create: (_) => HistoryProvider(),),
        ChangeNotifierProvider(create: (_) => CountryProvider(),),
        ChangeNotifierProvider(create: (_) => ProvinceProvider(),)
//        ChangeNotifierProvider(create: (_) => VersionProvider(),)
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFFECF0F3),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/':(_) => SplashScreen(),
          '/navBar':(_) => BotomNavBar(),
        },
      ),
    );
  }
}

