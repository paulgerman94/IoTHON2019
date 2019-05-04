// To parse this JSON data, do
//
//     final lightPole = lightPoleFromJson(jsonString);

import 'dart:convert';

LightPole lightPoleFromJson(String str) => LightPole.fromJson(json.decode(str));

String lightPoleToJson(LightPole data) => json.encode(data.toJson());

class LightPole {
  AirQuality airQuality;
  double humidity;
  double temperature;

  LightPole({
    this.airQuality,
    this.humidity,
    this.temperature,
  });

  factory LightPole.fromJson(Map<String, dynamic> json) => new LightPole(
    airQuality: AirQuality.fromJson(json["air_quality"]),
    humidity: json["humidity"].toDouble(),
    temperature: json["temperature"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "air_quality": airQuality.toJson(),
    "humidity": humidity,
    "temperature": temperature,
  };
}

class AirQuality {
  String dominantPollutant;
  String type;

  AirQuality({
    this.dominantPollutant,
    this.type,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) => new AirQuality(
    dominantPollutant: json["dominant_pollutant"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "dominant_pollutant": dominantPollutant,
    "type": type,
  };
}

List<LightPoles> lightPolesFromJson(String str) => new List<LightPoles>.from(json.decode(str).map((x) => LightPoles.fromJson(x)));

String lightPolesToJson(List<LightPoles> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class LightPoles {
  AirQuality airQuality;
  double humidity;
  double temperature;
  String time;

  LightPoles({
    this.airQuality,
    this.humidity,
    this.temperature,
    this.time,
  });

  factory LightPoles.fromJson(Map<String, dynamic> json) => new LightPoles(
    airQuality: AirQuality.fromJson(json["air_quality"]),
    humidity: json["humidity"].toDouble(),
    temperature: json["temperature"].toDouble(),
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "air_quality": airQuality.toJson(),
    "humidity": humidity,
    "temperature": temperature,
    "time": time,
  };
}
