import 'dart:convert';

import 'package:doctor_v2/Model/SelectTestModel.dart';
import 'package:doctor_v2/main.dart';

import 'package:http/http.dart' as http;

class Services {
  static Future<SelectTestModel> getTest() async {
    final param = {};
    SelectTestModel obj = SelectTestModel(result: []);
    http.Response response =
        await apiRequest(baseUrl + '/login/fetch/fetch.php', param);

    print(response.body);

    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      obj = SelectTestModel.fromJson(item);
      return obj;
    } else
      return obj;
  }
}

Future<http.Response> apiRequest(String url, Map jsonMap) async {
  var body = jsonEncode(jsonMap);
  var response = await http.post(
    Uri.parse(url),
    headers: {
      "Accept": "application/json",
      "content-type": "application/json",
    },
    body: body,
  );
  return response;
}
