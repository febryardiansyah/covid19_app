import 'dart:convert';

import 'package:covid19/models/country_model.dart';
import 'package:covid19/providers/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'detail_negara.dart';

class ByCountry extends StatefulWidget {
  @override
  _ByCountryState createState() => _ByCountryState();
}

class _ByCountryState extends State<ByCountry> {
  TextEditingController controller = TextEditingController();
  List<CountryModel> _searchResult = [];
  List<CountryModel> _countryDetails = [];
  final url = 'https://corona.lmao.ninja/countries';

  Future<Null> getJson() async {
    final response = await http.get(url);
    var res = json.decode(response.body);
    setState(() {
      for (Map country in res) {
        _countryDetails.add(CountryModel.fromJson(country));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJson();
  }

  @override
  Widget build(BuildContext context) {
    var countryData = Provider.of<CountryProvider>(context).listCountry;
    return Scaffold(
      backgroundColor: Color(0xFFECF0F3),
      appBar: AppBar(
        title: Text('Berdasarkan Negara'),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Cari Negara',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.transparent))),
              onChanged: (value) {
                onSearchText(value
                    .toLowerCase()
                    .substring(0)
                    .toLowerCase()
                    .substring(1));
                print(value
                    .toUpperCase()
                    .substring(0)
                    .toLowerCase()
                    .substring(1));
              },
            ),
          ),
          Expanded(
            child: _searchResult.length == 0 || controller.text.isEmpty
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    itemCount: _countryDetails.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Color(0xFFECF0F3),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(5, 5),
                                      color: Colors.black12,
                                      blurRadius: 12),
                                  BoxShadow(
                                      offset: Offset(5, 5),
                                      color: Colors.black12,
                                      blurRadius: 12),
                                  BoxShadow(
                                      offset: Offset(-5, -5),
                                      color: Colors.white,
                                      blurRadius: 12)
                                ]),
                            child: ListTile(
                              leading: Text('${i + 1}'),
                              title: Text(
                                _countryDetails[i].region,
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
                  )
                : new ListView.builder(
                    itemCount: _searchResult.length,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    itemBuilder: (context, i) {
                      return Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration:
                            BoxDecoration(color: Color(0xFFECF0F3), boxShadow: [
                          BoxShadow(
                              offset: Offset(5, 5),
                              color: Colors.black12,
                              blurRadius: 12),
                          BoxShadow(
                              offset: Offset(5, 5),
                              color: Colors.black12,
                              blurRadius: 12),
                          BoxShadow(
                              offset: Offset(-5, -5),
                              color: Colors.white,
                              blurRadius: 12)
                        ]),
                        child: ListTile(
                          leading: Text('${i + 1}'),
                          title: Text(
                            _searchResult[i].region,
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
                                            detail: _searchResult[i],
                                          )));
                            },
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }

  onSearchText(String query) async {
    _searchResult.clear();
    if (query.isEmpty) {
      setState(() {});
      return;
    }
    _countryDetails.forEach((res) {
      if (res.region.contains(query)) {
        _searchResult.add(res);
      }
    });
    setState(() {});
  }
}
