import 'dart:convert';

import 'package:covidtracker/Models/WorldStateModel.dart';
import 'package:covidtracker/view/World_State.dart';
import 'package:http/http.dart' as http;
import 'Utilities/api_url.dart';

class StateServices {
  Future<WorldStateModel> getStateApi() async {
    final response = await http.get(Uri.parse(apiUrl.WorldStateApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> getCountryApi() async {
    var data;
    final response = await http.get(Uri.parse(apiUrl.countriesList ));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
