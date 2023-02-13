import 'dart:convert';
import 'package:http/http.dart' as http;

class Network
{
  final String url;
  Network(this.url);

  Future<dynamic> getJsonData() async
  {
    try{
      http.Response response = await http.get(Uri.parse(url));
      // print(url);
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var myParsingData = jsonDecode(jsonData);
        return myParsingData;
      }
    }
    catch(e)
    {
      print("fail");
    }
  }
}