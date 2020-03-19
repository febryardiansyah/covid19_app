import 'package:covid19/providers/country_provider.dart';
import 'package:covid19/providers/global_provider.dart';
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
  }
  @override
  Widget build(BuildContext context) {
    var globalData = Provider.of<GlobalProvider>(context).global;
    final formatNumber = NumberFormat('#,###');
    final formatTgl = DateFormat('dd - MMMM - yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text('Covid - 19'),
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
            color: Colors.green,
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
      child: Card(
        child: ListTile(
          title: Text(title,style: TextStyle(fontSize: 15,),),
          subtitle: Text(subtitle,style: TextStyle(fontSize: 40,color: color),),
        ),
      ),
    );
  }
}
