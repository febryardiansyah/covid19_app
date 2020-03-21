import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  _launchUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak Bisa';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF0F3),
      appBar: AppBar(
        elevation: 0,
        title: Text('Tentang..'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Rest Api yang digunakan'),
            Divider(),
            _listTileTemp(
                title: 'Covid-19 Api',
                subtitle: 'https://github.com/mathdroid/covid-19-api',
                onTap: () {
                  _launchUrl('https://github.com/mathdroid/covid-19-api');
                }),
            _listTileTemp(
                title: 'NovelCovid Api',
                subtitle: 'https://github.com/NovelCOVID/API',
                onTap: () {
                  _launchUrl('https://github.com/NovelCOVID/API');
                }),
            _listTileTemp(
                title: 'Covid-19 Cluster',
                subtitle:
                    'https://louislugas.github.io/covid_19_cluster/json/kasus-corona-indonesia.json',
                onTap: () {
                  _launchUrl(
                      'https://louislugas.github.io/covid_19_cluster/json/kasus-corona-indonesia.json');
                }),
            SizedBox(height: 50,),
            Text('Developer'),
            _developerTile(
                leading: CircleAvatar(child: FaIcon(FontAwesomeIcons.github),),
                title: 'Github',
                subtitle:
                'https://github.com/febryardiansyah',
                onTap: () {
                  _launchUrl(
                      'https://github.com/febryardiansyah');
                }),
            _developerTile(
                leading: CircleAvatar(child: FaIcon(FontAwesomeIcons.instagram),),
                title: 'Instagram',
                subtitle:
                'http://instagram.com/febry_ardiansyah24/',
                onTap: () {
                  _launchUrl(
                      'http://instagram.com/febry_ardiansyah24/');
                }),
          ],
        ),
      ),
    );
  }

  Widget _listTileTemp({title, subtitle, onTap}) {
    return ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: FaIcon(FontAwesomeIcons.arrowRight),
        onTap: onTap);
  }

  Widget _developerTile({leading, title, subtitle, onTap}) {
    return ListTile(
        leading: leading,
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: FaIcon(FontAwesomeIcons.arrowRight),
        onTap: onTap);
  }
}
