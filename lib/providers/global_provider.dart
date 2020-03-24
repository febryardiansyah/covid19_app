import 'package:covid19/models/global_model.dart';
import 'package:covid19/services/api_service.dart';
import 'package:flutter/material.dart';


class GlobalProvider extends ChangeNotifier{
  var api = ApiService();
  GlobalModel global;

  Future<GlobalModel>getGlobalProvider()async{
    final response = await api.client.get("${api.baseUrl}/api");

    if(response.statusCode == 200){
      notifyListeners();
      var res = globalModelFromJson(response.body);
      global = res;
      return global;
    }else{
      return null;
    }
  }
}