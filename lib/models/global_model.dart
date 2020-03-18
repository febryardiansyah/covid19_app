import 'dart:convert';
import 'package:meta/meta.dart';

GlobalModel globalModelFromJson(String res) =>
    GlobalModel.fromMap(json.decode(res));

String globalModelToJson(GlobalModel data) => json.encode(data.toMap);

class GlobalModel {
  Confirmed confirmed;
  Confirmed recovered;
  Confirmed death;
  DateTime lastUpdate;

  GlobalModel(
      {@required this.confirmed,
      @required this.recovered,
      @required this.death,
      @required this.lastUpdate});

  factory GlobalModel.fromMap(Map<String, dynamic> json) => GlobalModel(
        confirmed: json["confirmed"] == null ? null: Confirmed.fromMap(json["confirmed"]),
        recovered: json["recovered"] == null?null:Confirmed.fromMap(json["recovered"]),
        death: json["deaths"] == null?null:Confirmed.fromMap(json["deaths"]),
        lastUpdate: json['lastUpdate'] == null?null:DateTime.parse(json["lastUpdate"])
    );

  Map<String, dynamic> toMap() => {
        "confirmed": confirmed == null ? null : confirmed.toMap(),
        "recovered": recovered == null ? null : recovered.toMap(),
        "deaths": death == null ? null : death.toMap(),
        "lastUpdate": lastUpdate == null?null:lastUpdate.toIso8601String()
      };
}
class Confirmed {
 final int value;
  final String detail;

  Confirmed({@required this.value, @required this.detail});

  factory Confirmed.fromMap(Map<String, dynamic> json) => Confirmed(
      value: json["value"] == null ? null : json["value"],
      detail: json["detail"] == null ? null : json["detail"]);

  Map<String, dynamic> toMap() => {
    "value": value == null ? null : value,
    "detail": detail == null ? null : detail,
  };
}
