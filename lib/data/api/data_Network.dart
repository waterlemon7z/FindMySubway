import 'dart:convert';

import 'package:http/http.dart' as http;

class Network {
  final String url;

  Network(this.url);

  Future<Map<String, dynamic>> getJsonData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String jsonData = response.body;
        Map<String, dynamic> myParsingData = jsonDecode(jsonData);
        return myParsingData;
      }
    } catch (e) {
      print("fail");
    }
    return {};
  }
}
