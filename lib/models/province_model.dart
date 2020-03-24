import 'dart:convert';

ProvinceModel provinceModelFromJson(String res) => ProvinceModel.fromMap(json.decode(res));
FeatureModel featureModelFromJson(String res) => FeatureModel.fromMap(json.decode(res));

class FeatureModel{
  List<ProvinceModel>features;

  FeatureModel({this.features});

  factory FeatureModel.fromMap(Map<String,dynamic>json){
    return FeatureModel(
      features: List<ProvinceModel>.from(json['features'].map((item)=>ProvinceModel.fromMap(item)))
    );
  }


}

class Attributes {
  int positif, sembuh, meninggal;
  String province;

  Attributes({this.positif, this.sembuh, this.meninggal, this.province});

  factory Attributes.fromMap(Map<String, dynamic> json) {
    return Attributes(
        positif: json['Kasus_Posi'],
        sembuh: json['Kasus_Semb'],
        meninggal: json['Kasus_Meni'],
        province: json['Provinsi']);
  }
}
class Geometry {
  double x, y;

  Geometry({this.x, this.y});

  factory Geometry.fromMap(Map<String, dynamic> json) {
    return Geometry(x: json['x'], y: json['y']);
  }
}

class ProvinceModel {
  Attributes attributes;
  Geometry geometry;

  ProvinceModel({this.attributes, this.geometry});

  factory ProvinceModel.fromMap(Map<String, dynamic> json) {
    return ProvinceModel(
      attributes: json['attributes'] == null
          ? null
          : Attributes.fromMap(json['attributes']),
      geometry:
          json['geometry'] == null ? null : Geometry.fromMap(json['geometry']),
    );
  }
}
