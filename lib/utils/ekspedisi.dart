import 'dart:convert';

import 'package:http/http.dart' as http;

class Ekspedisi {
  static const _baseUrl = "https://api.rajaongkir.com/starter/";
  static const _apiKey = "e641ec3996338e9e3fe86088922bb8cf";

  Ekspedisi._();

  static Future<List> getProvince() async {
    final url = _baseUrl + "/province";
    Uri uriUrl = Uri.parse(url);

    var res = await http.get(
      uriUrl,
      headers: {"key": _apiKey},
    );
    var data = jsonDecode(res.body);

    // print(data["rajaongkir"]["results"]);

    return data["rajaongkir"]["results"];
  }

  static Future<List> getCityById(id) async {
    final url = _baseUrl + "/city?province=$id";
    Uri uriUrl = Uri.parse(url);

    var res = await http.get(
      uriUrl,
      headers: {"key": _apiKey},
    );
    var data = jsonDecode(res.body);
    // print(data["rajaongkir"]["results"]);

    return data["rajaongkir"]["results"];
  }
}
