import 'package:covid19/providers/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ByCountry extends StatefulWidget {
  @override
  _ByCountryState createState() => _ByCountryState();
}

class _ByCountryState extends State<ByCountry> {
  @override
  Widget build(BuildContext context) {
    var countryData = Provider.of<CountryProvider>(context).listCountry;
    return Scaffold(
      appBar: AppBar(
        title: Text('Berdasarkan Negara'),
      ),
      body: Center(
        child: countryData != null?
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemCount: countryData.length,
          itemBuilder: (context,i){
            return Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Card(
                  child: Container(
                    height: 80,
                    child: ListTile(
                      title: Text(countryData[i].region,style: TextStyle(fontSize: 20),),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text('Dikonfirmasi : ${countryData[i].confirmed}',style: TextStyle(color: Colors.green),),
                          Text('Sembuh : ${countryData[i].recovered}',style: TextStyle(color: Colors.blue),),
                          Text('Meninggal : ${countryData[i].deaths}',style: TextStyle(color: Colors.red),),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ):SpinKitFadingCube,
      ),
    );
  }
}
