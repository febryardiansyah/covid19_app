import 'package:covid19/providers/province_provider.dart';
import 'package:covid19/providers/country_provider.dart';
import 'package:covid19/providers/global_provider.dart';
import 'package:covid19/providers/history_provider.dart';
import 'package:covid19/providers/version_provider.dart';
import 'package:covid19/screens/help_screen.dart';
import 'package:covid19/screens/indonesia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currentVersion = 'v.1.0';
  List<String>listChangelog =[];
  String newVersion,title,date;
  void getListChangeLog()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>prefList = pref.getStringList('listChangelog');

    String _version = pref.getString('version');
    String _judul = pref.getString('title');
    String _tgl = pref.getString('date');
    setState(() {
      listChangelog = prefList;
      newVersion = _version;
      title = _judul;
      date = _tgl;
    });
  }
  _launchUrl()async{
    final url = 'https://github.com/febryardiansyah/covid19_app/releases/tag/covid19v.1';
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }
  void dialogAlert(){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Wrap(
                children: <Widget>[
                  Text('Changelog : '),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FaIcon(FontAwesomeIcons.list),
                      Center(child: Text('$listChangelog')),
                    ],
                  ),
                  Divider(),
                  Text('Versi terbaru : \t'+newVersion),
                  Divider(),
                  Text('Tanggal Update : \t'+date)
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Download Versi Terbaru'),
                  onPressed: (){
                    _launchUrl();
                  },
                ),
                FlatButton(
                  child: Text('Abaikan'),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
  }
  void cekVersi()async{
    if(newVersion != currentVersion){
      dialogAlert();
    }else{
      return null;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<GlobalProvider>(context, listen: false).getGlobalProvider();
    Provider.of<HistoryProvider>(context, listen: false).getHistory();
    Provider.of<CountryProvider>(context, listen: false).getCountry();
    Provider.of<ProvinceProvider>(context,listen: false).getProvince();
    Provider.of<VersionProvider>(context, listen: false).getVersion();
    getListChangeLog();
    Future.delayed(Duration.zero,this.cekVersi);
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
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HelpScreen()));
            },
          )
        ],
      ),
      body: globalData != null
          ? ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Text(
                        'Terakhir diperbaharui : \t${formatTgl.format(globalData.lastUpdate)}')),
                SizedBox(
                  height: 10,
                ),
                _listTileWidget(
                    title: 'Dikonfirmasi',
                    subtitle: '${formatNumber.format(
                      globalData.confirmed.value,
                    )}',
                    icon: FontAwesomeIcons.userFriends),
                _listTileWidget(
                    title: 'Sembuh',
                    subtitle:
                        '${formatNumber.format(globalData.recovered.value)}',
                    color: Colors.blue,
                    icon: FontAwesomeIcons.userCheck),
                _listTileWidget(
                    title: 'Meninggal',
                    subtitle: '${formatNumber.format(globalData.death.value)}',
                    color: Colors.red,
                    icon: FontAwesomeIcons.userMinus),
              ],
            )
          : Center(
              child: SpinKitFadingCube(
                color: Colors.red,
              ),
            ),
    );
  }

  Widget _listTileWidget({title, subtitle, color, icon}) {
    return Container(
      height: 140,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFECF0F3),
          boxShadow: [
            BoxShadow(
                offset: Offset(10, 10), color: Colors.black12, blurRadius: 12),
            BoxShadow(
                offset: Offset(-5, -5), color: Colors.white, blurRadius: 12)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(color: color, fontSize: 15),
            ),
            Text(
              subtitle,
              style: TextStyle(
                  color: color, fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FaIcon(
                icon,
                color: color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
