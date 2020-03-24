import 'dart:convert';

VersionModel versionModelFromJson(String res) =>VersionModel.fromMap(json.decode(res));

class VersionModel {
 String id,title,version,date;
 List<String> changelog;

 VersionModel({this.id, this.title, this.version, this.date, this.changelog});

 factory VersionModel.fromMap(Map<String,dynamic>json){
   return VersionModel(
     id: json['id'],
     title: json['title'],
     version: json['version'],
     date: json['date'],
     changelog: json['changelog']
   );
 }

}