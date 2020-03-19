class CountryModel {
  final String region;
  final int today, confirmed, recovered, deaths, todayDeaths, active, critical;

  CountryModel(
      {this.region,
      this.today,
      this.confirmed,
      this.recovered,
      this.deaths,
      this.todayDeaths,
      this.active,
      this.critical});

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
      region: json['country'] == null ? null : json['country'] as String,
      today: json['todayCases'] == null ? null : json['todayCases'] as int,
      confirmed: json['cases'] == null ? null : json['cases'] as int,
      recovered: json['recovered'] == null ? null : json['recovered'] as int,
      deaths: json['deaths'] == null ? null : json['deaths'] as int,
      todayDeaths:
          json['todayDeaths'] == null ? null : json["todayDeaths"] as int,
      active: json['active'] == null ? null : json['active'] as int,
      critical: json['critical'] == null ? null : json['critical'] as int);

  Map<String, dynamic> toJson() {
    return {
      'country': region,
      'todayCases': today,
      'cases': confirmed,
      'recovered': recovered,
      'deaths': deaths,
      'todayDeaths': todayDeaths,
      'active' : active,
      'critical':critical
    };
  }
}
