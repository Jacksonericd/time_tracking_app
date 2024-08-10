class WeatherResponse {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  String? visibility;
  Wind? wind;
  Rain? rain;
  Clouds? clouds;
  String? dt;
  Sys? sys;
  String? timezone;
  String? id;
  String? name;
  String? cod;

  WeatherResponse(
      {this.coord,
      this.weather,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.rain,
      this.clouds,
      this.dt,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final weather = <Weather>[];
    if (json['weather'] != null) {
      json['weather'].forEach((v) {
        weather.add(Weather.fromJson(v));
      });
    }

    return WeatherResponse(
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      weather: weather,
      base: json['base'],
      main: json['main'] != null ? Main.fromJson(json['main']) : null,
      visibility: json['visibility'].toString(),
      wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
      rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
      clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null,
      dt: json['dt'].toString(),
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      timezone: json['timezone'].toString(),
      id: json['id'].toString(),
      name: json['name'].toString(),
      cod: json['cod'].toString(),
    );
  }
}

class Coord {
  String? lon;
  String? lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon'].toString(),
      lat: json['lat'].toString(),
    );
  }
}

class Weather {
  String? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'].toString(),
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class Main {
  String? temp;
  String? feelsLike;
  String? tempMin;
  String? tempMax;
  String? pressure;
  String? humidity;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity});

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toString(),
      feelsLike: json['feels_like'].toString(),
      tempMin: json['temp_min'].toString(),
      tempMax: json['temp_max'].toString(),
      pressure: json['pressure'].toString(),
      humidity: json['humidity'].toString(),
    );
  }
}

class Wind {
  String? speed;
  String? deg;

  Wind({this.speed, this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'].toString(),
      deg: json['deg'].toString(),
    );
  }
}

class Rain {
  String? d1h;

  Rain({this.d1h});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(d1h: json['1h'].toString());
  }
}

class Clouds {
  String? all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(all: json['all'].toString());
  }
}

class Sys {
  String? type;
  String? id;
  String? country;
  String? sunrise;
  String? sunset;

  Sys({this.type, this.id, this.country, this.sunrise, this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      type: json['type'].toString(),
      id: json['id'].toString(),
      country: json['country'].toString(),
      sunrise: json['sunrise'].toString(),
      sunset: json['sunset'].toString(),
    );
  }
}
