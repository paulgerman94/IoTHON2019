// To parse this JSON data, do
//
//     final lightPole = lightPoleFromJson(jsonString);

import 'dart:convert';

LightPole lightPoleFromJson(String str) => LightPole.fromJson(json.decode(str));

String lightPoleToJson(LightPole data) => json.encode(data.toJson());

class LightPole {
  AirQuality airQuality;
  double humidity;
  Pollen pollen;
  double temperature;

  LightPole({
    this.airQuality,
    this.humidity,
    this.pollen,
    this.temperature,
  });

  factory LightPole.fromJson(Map<String, dynamic> json) => new LightPole(
    airQuality: AirQuality.fromJson(json["air_quality"]),
    humidity: json["humidity"].toDouble(),
    pollen: Pollen.fromJson(json["pollen"]),
    temperature: json["temperature"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "air_quality": airQuality.toJson(),
    "humidity": humidity,
    "pollen": pollen.toJson(),
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

class Pollen {
  String grass;
  String tree;

  Pollen({
    this.grass,
    this.tree,
  });

  factory Pollen.fromJson(Map<String, dynamic> json) => new Pollen(
    grass: json["grass"],
    tree: json["tree"],
  );

  Map<String, dynamic> toJson() => {
    "grass": grass,
    "tree": tree,
  };
}

List<LightPoles> lightPolesFromJson(String str) => new List<LightPoles>.from(json.decode(str).map((x) => LightPoles.fromJson(x)));

String lightPolesToJson(List<LightPoles> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class LightPoles {
  AirQuality airQuality;
  double humidity;
  Pollen pollen;
  double temperature;
  String time;

  LightPoles({
    this.airQuality,
    this.humidity,
    this.pollen,
    this.temperature,
    this.time,
  });

  factory LightPoles.fromJson(Map<String, dynamic> json) => new LightPoles(
    airQuality: AirQuality.fromJson(json["air_quality"]),
    humidity: json["humidity"].toDouble(),
    pollen: Pollen.fromJson(json["pollen"]),
    temperature: json["temperature"].toDouble(),
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "air_quality": airQuality.toJson(),
    "humidity": humidity,
    "pollen": pollen.toJson(),
    "temperature": temperature,
    "time": time,
  };
}


enum DominantPollutant { PM25 }

final dominantPollutantValues = new EnumValues({
  "pm25": DominantPollutant.PM25
});

enum Type { LOW_AIR_QUALITY }

final typeValues = new EnumValues({
  "Low air quality": Type.LOW_AIR_QUALITY
});

enum Grass { NONE }

final grassValues = new EnumValues({
  "None": Grass.NONE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
