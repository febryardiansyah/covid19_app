class CountryModel {
  final String region, iso2;
  final int confirmed, recovered, deaths;
  int lastUpdate;

  CountryModel(
      {this.region,
      this.iso2,
      this.confirmed,
      this.recovered,
      this.deaths,
      this.lastUpdate});

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
      region: json['countryRegion'] == null ? null : json['countryRegion'] as String,
      iso2: json['iso2'] == null ? null : json['iso2'] as String,
      confirmed: json['confirmed'] == null ? null : json['confirmed'] as int,
      recovered: json['recovered'] == null ? null : json['recovered'] as int,
      deaths: json['deaths'] == null ? null : json['deaths'] as int,
      lastUpdate: json['lastUpdate'] == null ? null : json["lastUpdate"]);

  Map<String, dynamic> toJson() {
    return {
      'countryRegion': region,
      'iso2': iso2,
      'confirmed': confirmed,
      'recovered': recovered,
      'deaths': deaths,
      'lastUpdate': lastUpdate,
    };
  }
}
