class CitiesByCountry {
  bool? error;
  String? msg;
  List<String>? data;

  CitiesByCountry({this.error, this.msg, this.data});

  factory CitiesByCountry.fromJson(Map<String, dynamic> json) {
    final cities = <String>[];

    if (json['data'] != null) {
      json['data'].forEach((v) {
        cities.add(v);
      });
    }

    return CitiesByCountry(
      error: json['error'],
      msg: json['msg'],
      data: cities,
    );
  }
}
