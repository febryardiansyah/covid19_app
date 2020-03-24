import 'dart:convert';

import 'package:covid19/models/province_model.dart';
import 'package:covid19/models/province_provider.dart';
import 'package:covid19/providers/history_provider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;

class KasusIndonesia extends StatefulWidget {
  @override
  _KasusIndonesiaState createState() => _KasusIndonesiaState();
}

class _KasusIndonesiaState extends State<KasusIndonesia> {
  List<ProvinceModel>_provinceList = [];
  ProvinceModel _selectedItem;
  final url = 'https://services5.arcgis.com/VS6HdKS0VfIhv8Ct/arcgis/rest/services/COVID19_Indonesia_per_Provinsi/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json';

  Future<List<ProvinceModel>> _fetchProvince()async{
    var response = await http.get(url);
    if(response.statusCode == 200){
      final items = json.decode(response.body)['features'].cast<Map<String,dynamic>>();
      List<ProvinceModel> listOfProvince = items.map<ProvinceModel>((json)=>ProvinceModel.fromMap(json)).toList();
      return listOfProvince;
    }
  }
  @override
  Widget build(BuildContext context) {
    var getHistoryList = Provider.of<HistoryProvider>(context).historyList;
    var txtDetail = TextStyle(fontSize: 15);
    return Scaffold(
      backgroundColor: Color(0xFFECF0F3),
      appBar: AppBar(
        title: Text('Kasus di Indonesia'),
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            decoration: BoxDecoration(
              color: Color(0xFFECF0F3),
              boxShadow: [
                BoxShadow(
                    offset: Offset(10, 10), color: Colors.black12, blurRadius: 12),
                BoxShadow(
                    offset: Offset(-5, -5), color: Colors.white, blurRadius: 12)
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder<List<ProvinceModel>>(
                  future: _fetchProvince(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ProvinceModel>> snapshot) {
                    if(!snapshot.hasData){
                      return Center(child: SpinKitWave(color: Colors.red,));
                    }
                    return DropdownButton<ProvinceModel>(
                        isExpanded: false,
                        hint: Text('Pilih Provinsi'),
                        value: _selectedItem == null?_selectedItem:null,
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
                        }).toList()
                    );
                  }
                ),
                SizedBox(height: 10,),
                _selectedItem == null?Text('No Province Selected')
                :Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(_selectedItem.attributes.province,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Positif : \t'+ _selectedItem.attributes.positif.toString(),style: TextStyle(fontSize: 15),),
                        SizedBox(height: 10,),
                        Text('Sembuh : \t'+ _selectedItem.attributes.sembuh.toString(),style: TextStyle(fontSize: 15,color: Colors.blue),),
                        SizedBox(height: 10,),
                        Text('Meninggal : \t'+ _selectedItem.attributes.meninggal.toString(),style: TextStyle(fontSize: 15,color: Colors.red),),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
