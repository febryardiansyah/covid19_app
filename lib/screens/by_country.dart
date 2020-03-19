import 'dart:math';

import 'package:covid19/models/country_model.dart';
import 'package:covid19/models/global_model.dart';
import 'package:covid19/providers/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ByCountry extends StatefulWidget {
  @override
  _ByCountryState createState() => _ByCountryState();
}

class _ByCountryState extends State<ByCountry> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var countryData = Provider.of<CountryProvider>(context).listCountry;
    return Scaffold(
      appBar: AppBar(
        title: Text('Berdasarkan Negara'),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10,right: 10,top: 10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Cari',
                hintText: 'Cari Negara',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
              ),
              onChanged: (value){
                Provider.of<CountryProvider>(context).listCountry.where((item){
                  return item.region.startsWith(value);
                }).toList();
              },
            ),
          ),
          countryData != null
              ? Padding(
            padding: EdgeInsets.only(top: 80),
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    itemCount: countryData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Column(
                        children: <Widget>[
                          Card(
                            child: ListTile(
                              leading: Text('${i+1}'),
                              title: Text(
                                countryData[i].region,
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: InkWell(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    'Lihat Detail',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailNegara(
                                                detail: countryData[i],
                                              )));
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
              )
              : SpinKitFadingCube,
        ],
      ),
    );
  }
}

class DetailNegara extends StatelessWidget {
  final CountryModel detail;

  const DetailNegara({Key key, this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle txts = TextStyle(fontSize: 18);
    final formatNumber = NumberFormat('#,###');
    return Scaffold(
      appBar: AppBar(
        title: Text('Kasus Di ${detail.region}'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        height: 200,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${detail.region}',
                  style: TextStyle(fontSize: 25),
                ),
                Divider(),
                Text(
                  'Kasus :\t ${formatNumber.format(detail.confirmed)} | Hari ini : ${formatNumber.format(detail.today)} | Aktif : ${formatNumber.format(detail.active)}',
                  style: txts,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                    'Meninggal :\t ${formatNumber.format(detail.deaths)} | Hari ini : ${formatNumber.format(detail.todayDeaths)}',
                    style: txts),
                SizedBox(
                  height: 5,
                ),
                Text(
                    'Sembuh :\t ${formatNumber.format(detail.recovered)} | Kritis : ${formatNumber.format(detail.critical)}',
                    style: txts),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
