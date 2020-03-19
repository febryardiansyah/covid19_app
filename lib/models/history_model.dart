class HistoryModel {
  String kasus, gender, pengumuman, penularan, status, rs,umur,wn;

  HistoryModel(
      {this.kasus,
      this.gender,
      this.pengumuman,
      this.penularan,
      this.status,
      this.rs,
      this.umur,
      this.wn});

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      kasus: json['kasus'],
      gender: json['gender'],
      pengumuman: json['pengumuman'],
      penularan: json['penularan'],
      status: json['status'],
      rs: json['rs'],
      umur: json['umurtext'],
      wn: json['wn']
    );
  }
  Map<String,dynamic> toJson(){
    return{
      'kasus':kasus,
      'gender':gender,
      'pengumuman':pengumuman,
      'penularan':penularan,
      'status':status,
      'rs':rs,
      'umurtext':umur,
      'wn':wn
    };
  }
}
