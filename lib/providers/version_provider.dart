import 'dart:convert';

import 'package:covid19/models/version_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class VersionProvider extends ChangeNotifier {
  final String url = 'http://9f254ef1.ngrok.io/corona-version-api/public';
  VersionModel versionModel;
  List<VersionModel>_listVersi = [];
  List<VersionModel> get listVersi => _listVersi;

  Future<List<VersionModel>> getVersion() async {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      notifyListeners();
      var res = json.decode(response.body).cast<Map<String,dynamic>>();
      _listVersi = res.map<VersionModel>((json)=>versionModelFromJson(json));
      print(_listVersi.length);
      return _listVersi;
    } else {
      return null;
    }
  }
}
