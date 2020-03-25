import 'package:covid19/models/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


class DetailNegara extends StatefulWidget {
  final CountryModel detail;

  const DetailNegara({Key key, this.detail}) : super(key: key);

  @override
  _DetailNegaraState createState() => _DetailNegaraState();
}

class _DetailNegaraState extends State<DetailNegara> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    TextStyle txts = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    final formatNumber = NumberFormat('#,###');
    return Scaffold(
        backgroundColor: Color(0xFFECF0F3),
//        appBar: AppBar(
//          title: Text('Kasus Di ${detail.region}'),
//        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                splashColor: Colors.transparent,
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                height: 70,
                width: 200,
                child: Center(
                    child: Text(
                      '${widget.detail.region}',
                      style: txts,
                    )),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFECF0F3),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(10, 10),
                          color: Colors.black12,
                          blurRadius: 12),
                      BoxShadow(
                          offset: Offset(-5, -5),
                          color: Colors.white,
                          blurRadius: 12)
                    ]),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[
                    _neuroPishm(
                        title: 'Total Kasus',
                        subtitle: widget.detail.confirmed,
                        titleUnder: 'Aktif  : \t',
                        number: '${formatNumber.format(widget.detail.active)}'),
                    _neuroPishm(
                        title: 'Hari ini',
                        subtitle: widget.detail.today,
                        titleUnder: '',
                        number: ''),
                    _neuroPishm(
                        title: 'Sembuh',
                        subtitle: widget.detail.recovered,
                        warna: Colors.blue,
                        titleUnder: 'Kritis : \t',
                        number: '${formatNumber.format(widget.detail.critical)}'),
                    _neuroPishm(
                        title: 'Meninggal',
                        subtitle: widget.detail.deaths,
                        warna: Colors.red,
                        titleUnder: 'Hari ini : \t',
                        number: '${formatNumber.format(widget.detail.todayDeaths)}')
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _neuroPishm({title, subtitle, warna, titleUnder, number}) {
    final formatNumber = NumberFormat('#,###');
    return Container(
      padding: EdgeInsets.all(12),
      height: ScreenUtil().setHeight(200),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFECF0F3),
          boxShadow: [
            BoxShadow(
                offset: Offset(5, 5), color: Colors.black12, blurRadius: 12),
            BoxShadow(
                offset: Offset(-5, -5), color: Colors.white, blurRadius: 12)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 15, color: warna),
          ),
          Divider(),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${formatNumber.format(subtitle)}',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(80), fontWeight: FontWeight.bold, color: warna),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            titleUnder + number,
            style: TextStyle(color: warna),
          )
        ],
      ),
    );
  }
}