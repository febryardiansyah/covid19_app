import 'dart:convert';

import 'package:covid19/models/province_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class ProvinceProvider extends ChangeNotifier{
  final url = 'https://services5.arcgis.com/VS6HdKS0VfIhv8Ct/arcgis/rest/services/COVID19_Indonesia_per_Provinsi/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json';
  FeatureModel featureModel;
  ProvinceModel provinceModel;
  List<ProvinceModel> _list = [];
  get listProvince => _list;

  Future <List<ProvinceModel>> getProvince()async{
    var response = await http.get(url);

    if(response.statusCode ==200){
      notifyListeners();
      final res = json.decode(response.body)['features'].cast<Map<String,dynamic>>();
      _list = res.map<ProvinceModel>((json)=>ProvinceModel.fromMap(json)).toList();
//      for(ProvinceModel list in _list){
//        print(list.attributes.province);
//      }
      return _list;
    }else{
      return null;
    }
  }
}