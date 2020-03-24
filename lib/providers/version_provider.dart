import 'dart:convert';

import 'package:covid19/models/version_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class VersionProvider extends ChangeNotifier {
  final url = 'http://1fde25d8.ngrok.io/corona-version-api/public/';
  VersionModel versionModel;
  List<VersionModel>_listVersi = [];
  List<VersionModel> get listVersi => _listVersi;

  Future<VersionModel> getVersion() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      notifyListeners();
      var res = versionModelFromJson(response.body);
      versionModel = res;
      pref.setStringList('listChangelog', versionModel.changelog);
      pref.setString('title', versionModel.title);
      pref.setString('date', versionModel.date);
      pref.setString('version', versionModel.version);
      return versionModel;
    } else {
      return null;
    }
  }
}
