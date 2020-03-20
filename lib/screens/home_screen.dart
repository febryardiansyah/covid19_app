import 'package:covid19/providers/country_provider.dart';
import 'package:covid19/providers/global_provider.dart';
import 'package:covid19/providers/history_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<GlobalProvider>(context,listen: false).getGlobalProvider();
    Provider.of<CountryProvider>(context,listen: false).getCountry();
    Provider.of<HistoryProvider>(context,listen: false).getHistory();
  }
  @override
  Widget build(BuildContext context) {
    var globalData = Provider.of<GlobalProvider>(context).global;
    final formatNumber = NumberFormat('#,###');
    final formatTgl = DateFormat('dd - MMMM - yyyy');

    return Scaffold(
      backgroundColor: Color(0xFFECF0F3),
      appBar: AppBar(
        title: Text('Covid - 19'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.live_help),
            onPressed: (){},
          )
        ],
      ),
      body: globalData != null ? ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          SizedBox(height: 10,),
          Align(
              alignment: Alignment.topRight,
              child: Text('Terakhir diperbaharui : \t${formatTgl.format(globalData.lastUpdate)}')),
          SizedBox(height: 10,),
          _listTileWidget(
            title: 'Dikonfirmasi',
            subtitle: '${formatNumber.format(globalData.confirmed.value,)}',
          ),
          _listTileWidget(
            title: 'Sembuh',
            subtitle: '${formatNumber.format(globalData.recovered.value)}',
            color: Colors.blue,
          ),
          _listTileWidget(
            title: 'Meninggal',
            subtitle: '${formatNumber.format(globalData.death.value)}',
            color: Colors.red,
          ),
        ],
      ):Center(child: SpinKitFadingCube(color: Colors.red,),),
    );
  }
  Widget _listTileWidget({title,subtitle,color,}){
    return Container(
      height: 140,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFECF0F3),
          boxShadow: [
            BoxShadow(
                offset: Offset(10, 10),
                color: Colors.black12,
                blurRadius: 12),
            BoxShadow(
                offset: Offset(-5, -5),
                color: Colors.white,
                blurRadius: 12)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,style: TextStyle(color: color,fontSize: 15),),
            Text(subtitle,style: TextStyle(color: color,fontSize: 35,fontWeight: FontWeight.bold),),
            Align(
              alignment: Alignment.bottomRight,
              child: Text('Global'),
            )
          ],
        ),
      ),
    );
  }
}
