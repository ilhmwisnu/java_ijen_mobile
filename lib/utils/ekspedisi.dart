import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:java_ijen_mobile/utils/cost.dart';

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

  static Future<List<Cost>> getSampleCost(String destination) async {
    List<Cost> allCost = [];
    final url = _baseUrl + "/cost";
    Uri uriUrl = Uri.parse(url);

    var ekspedisi = ["jne", "pos", "tiki"];

    for (var item in ekspedisi) {
      var res = await http.post(uriUrl, headers: {
        "key": _apiKey,
      }, body: {
        "origin": 160.toString(),
        "destination": destination.toString(),
        "weight": 1000.toString(),
        "courier": item
      });
      List costs = jsonDecode(res.body)["rajaongkir"]["results"][0]["costs"];
      // print(costs);
      for (var cost in costs) {
        // print(cost['service']);
        // print(cost['cost'][0]['etd']);
        // print(cost['cost'][0]['value']);
        allCost.add(Cost(
          namaLayanan: "${item.toUpperCase()} - ${cost['service']}",
          harga: cost['cost'][0]['value'],
          estimasi: cost['cost'][0]['etd'],
        ));
      }

      // print(allCost);
    }

    // allCost.forEach((element) {
    //   print(element);
    // });

    return allCost;
  }
}
