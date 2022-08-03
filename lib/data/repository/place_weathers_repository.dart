import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:skincare_consult_codetest_flutter/data/responseCollection/place_weathers_response_collection.dart';

abstract class BasePlaceWeathersRepository {
  Future getLocalPlaceWeathers();
}

class PlaceWeathersRepository implements BasePlaceWeathersRepository {
  @override

  Future getLocalPlaceWeathers() async {
    try {
      String jsonString = await rootBundle.loadString("assets/test.json");

      print("RESPONSE :: ${jsonString}");
      var json = jsonDecode(jsonString);

      var data = PlaceWeathersResponseCollection.fromJson(json);
      if (data is PlaceWeathersResponseCollection) {
        return data;
      } else {
        print(":: ERROR response type ::");
        return null;
      }
    } catch (err) {
      print("ERROR: $err");
      return null;
    }
  }
}
