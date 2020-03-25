import 'dart:convert';

import 'package:covid19/models/province_model.dart';
import 'package:covid19/providers/history_provider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class KasusIndonesia extends StatefulWidget {
  @override
  _KasusIndonesiaState createState() => _KasusIndonesiaState();
}

class _KasusIndonesiaState extends State<KasusIndonesia> {
  ProvinceModel _selectedItem;
  final url =
      'https://services5.arcgis.com/VS6HdKS0VfIhv8Ct/arcgis/rest/services/COVID19_Indonesia_per_Provinsi/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json';

  Future<List<ProvinceModel>> _fetchProvince() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final items =
          json.decode(response.body)['features'].cast<Map<String, dynamic>>();
      List<ProvinceModel> listOfProvince = items
          .map<ProvinceModel>((json) => ProvinceModel.fromMap(json))
          .toList();
      return listOfProvince;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF0F3),
      appBar: AppBar(
        title: Text('Kasus di Indonesia'),
        elevation: 0,
      ),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(color: Color(0xFFECF0F3), boxShadow: [
                BoxShadow(
                    offset: Offset(10, 10),
                    color: Colors.black12,
                    blurRadius: 12),
                BoxShadow(
                    offset: Offset(-5, -5), color: Colors.white, blurRadius: 12)
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FutureBuilder<List<ProvinceModel>>(
                      future: _fetchProvince(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ProvinceModel>> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: SpinKitWave(
                            color: Colors.red,
                          ));
                        }
                        return DropdownButton<ProvinceModel>(
                            isExpanded: false,
                            hint: Text('Pilih Provinsi'),
                            value: _selectedItem == null ? _selectedItem : null,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedItem = newValue;
                              });
                            },
                            items: snapshot.data.map((ProvinceModel items) {
                              return new DropdownMenuItem<ProvinceModel>(
                                value: items,
                                child: Text(items.attributes.province),
                              );
                            }).toList());
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _selectedItem == null
                ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                      child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.asset('assets/images/empty_vector.png'),
                        Center(
                            child: Text(
                          'No Province Selected',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                      ],
                    )),
                )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 200,
                          padding: EdgeInsets.all(12),
                          child: Center(
                              child: Text(
                            _selectedItem.attributes.province,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFFECF0F3),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(5, 5),
                                    color: Colors.black12,
                                    blurRadius: 12),
                                BoxShadow(
                                    offset: Offset(-5, -5),
                                    color: Colors.white,
                                    blurRadius: 12)
                              ]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _detailProvince(
                          title: 'Dikonfirmasi',
                          subtitle: _selectedItem.attributes.positif.toString(),
                          color: Colors.black
                        ),
                        _detailProvince(
                          title: 'Sembuh',
                          subtitle: _selectedItem.attributes.sembuh.toString(),
                          color: Colors.blue
                        ),
                        _detailProvince(
                          title: 'Meninggal',
                          subtitle: _selectedItem.attributes.meninggal.toString(),
                          color: Colors.red
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _detailProvince({title,subtitle,color}) {
    return Container(
      height: 100,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFECF0F3),
          boxShadow: [
            BoxShadow(
                offset: Offset(10, 10), color: Colors.black12, blurRadius: 12),
            BoxShadow(
                offset: Offset(-5, -5), color: Colors.white, blurRadius: 12)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,style: TextStyle(color: color,fontSize: 15),),
          SizedBox(height: 10,),
          Center(child: Text(subtitle +' Orang',style: TextStyle(color: color,fontWeight: FontWeight.bold,fontSize: 25),))
        ],
      ),
    );
  }
}
