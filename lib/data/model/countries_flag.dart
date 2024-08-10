class CountriesFlag {
  bool? error;
  String? msg;
  List<CountryData>? data;

  CountriesFlag({this.error, this.msg, this.data});

  factory CountriesFlag.fromJson(Map<String, dynamic> json) {
    final data = <CountryData>[];

    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(CountryData.fromJson(v));
      });
    }

    return CountriesFlag(
      error: json['error'],
      msg: json['msg'],
      data: data,
    );
  }
}
  
class CountryData {
  String? name;
  String? unicodeFlag;

  CountryData({this.name, this.unicodeFlag});

  factory CountryData.fromJson(Map<String, dynamic> json) {
    return CountryData(
      name: json['name'],
      unicodeFlag: json['unicodeFlag'],
    );
  }
}
