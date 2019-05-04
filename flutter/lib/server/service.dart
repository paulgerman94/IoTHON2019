import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iothon2019/server/model.dart';

class ServiceAPI {
  String iothonHost = "35.228.63.92:5000";

  Future<LightPole> getLocationData(double lat, double long) async {
    var queryParameters = {'lat': lat.toString(), 'long': long.toString()};

    //Uri to bring the data from a Lightpole
    var uri = Uri.http(iothonHost, '/location', queryParameters);
    http.Response resp = await http.get(uri);

    if (resp.statusCode == 200) {
      return LightPole.fromJson(json.decode(resp.body));
    } else {
      throw Exception('It fails. fuck you!');
    }
  }
}
