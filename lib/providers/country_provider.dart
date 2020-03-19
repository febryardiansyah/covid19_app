import 'dart:convert';

import 'package:covid19/models/country_model.dart';
import 'package:covid19/services/api_service.dart';
import 'package:flutter/material.dart';

class CountryProvider extends ChangeNotifier{
  var api = ApiService();
  List <CountryModel>_list = [];
  List<CountryModel> get listCountry => _list;

  Future<List<CountryModel>>getCountry()async{
    final response = await api.client.get('${api.countryUrl}/countries');
    
    if(response.statusCode == 200){
      notifyListeners();
      var res = json.decode(response.body).cast<Map<String,dynamic>>();
      _list = res.map<CountryModel>((model)=>CountryModel.fromJson(model)).toList();
      return _list;
    }else{
      return null;
    }
  }
}