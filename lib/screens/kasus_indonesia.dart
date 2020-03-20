import 'package:covid19/providers/history_provider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KasusIndonesia extends StatefulWidget {
  @override
  _KasusIndonesiaState createState() => _KasusIndonesiaState();
}

class _KasusIndonesiaState extends State<KasusIndonesia> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text('Total kasus : ${getHistoryList.length}'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: getHistoryList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ExpansionTileCard(
                        title: Text(
                          '${getHistoryList[i].kasus}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Lihat Detail'),
                        children: <Widget>[
                          Divider(
                            thickness: 1,
                            height: 1,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Gender : \t ${getHistoryList[i].gender}',
                                    style: txtDetail,
                                  ),
                                  Text(
                                    'Umur : \t ${getHistoryList[i].umur}',
                                    style: txtDetail,
                                  ),
                                  Text(
                                    'Pengumuman : \t ${getHistoryList[i].pengumuman}',
                                    style: txtDetail,
                                  ),
                                  Text(
                                    'Penularan : \t ${getHistoryList[i].penularan}',
                                    style: txtDetail,
                                  ),
                                  Text(
                                    'Status : \t ${getHistoryList[i].status}',
                                    style: txtDetail,
                                  ),
                                  Text(
                                    'Rumah Sakit : \t ${getHistoryList[i].rs}',
                                    style: txtDetail,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
