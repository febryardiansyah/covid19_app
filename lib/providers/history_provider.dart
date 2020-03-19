import 'dart:convert';

import 'package:covid19/models/history_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class HistoryProvider extends ChangeNotifier {
  List<HistoryModel> _list = [];

  List<HistoryModel> get historyList => _list;

  Future<List<HistoryModel>> getHistory() async {
    final response = await http.get('https://louislugas.github.io/covid_19_cluster/json/kasus-corona-indonesia.json');

    if (response.statusCode == 200) {
      notifyListeners();
      var res = json.decode(response.body)['nodes'].cast<Map<String, dynamic>>();
      _list = res.map<HistoryModel>((model) => HistoryModel.fromJson(model))
          .toList();
      return _list;
    } else {
      return null;
    }
  }
}
