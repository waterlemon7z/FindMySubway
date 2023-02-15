import 'dart:convert';
import 'package:http/http.dart' as http;

import 'data_msg_parse.dart';

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

class SubwayListDataSet{
  List<String> stationList = [];
  List<String> addedStation = ["정왕","매교", "매탄권선", "망포", "영통", "상갈", "기흥"];
  List<List<List<String>>> upTrainList = [];
  List<List<List<String>>> downTrainList = [];
}
Future<SubwayListDataSet> getSubwayInfo() async {
  var SubData = new SubwayListDataSet();
  List<List<String>> tempUpTrain = [];
  List<List<String>> tempDownTrain = [];
  // String apikey = "49647777496c656d39304a6d717744";
  String apikey = "sample";
  for (String cur in SubData.addedStation) {
    Network net = Network("http://swopenapi.seoul.go.kr/api/subway/$apikey/"
        "json/realtimeStationArrival/0/5/$cur");
    var fetchData = await net.getJsonData();
    SubData.stationList.add(cur);
    for (int i = 0; i < fetchData["realtimeArrivalList"].length; i++) {
      var target = fetchData["realtimeArrivalList"][i];
      if (target["subwayId"] == "1075") {
        if (target["updnLine"] == "상행") {
          tempUpTrain.add([parseAheadString(target["bstatnNm"]), parseString(target["arvlMsg2"])]);
        } else if (target["updnLine"] == "하행") {
          tempDownTrain.add([parseAheadString(target["bstatnNm"]), parseString(target["arvlMsg2"])]);
        } else
          print("fail");
      }
    }
    SubData.upTrainList.add([...tempUpTrain]);
    SubData.downTrainList.add([...tempDownTrain]);
    tempUpTrain.clear();
    tempDownTrain.clear();
  }
  // print(stationList.length);
  // print(upTrainList);
  // print(downTrainList);
  return SubData;
}

Future<List<String>> getAllStationName() async {
  Map<String, String> stationInfo = {};
  String apikey = "49647777496c656d39304a6d717744";
  // String apikey = "sample";
  Network net = Network(
      "http://openapi.seoul.go.kr:8088/$apikey/json/SearchSTNBySubwayLineInfo/1/100/ / /수인분당선");
  var fetchData = await net.getJsonData();
  for (int i = 0;
  i < fetchData["SearchSTNBySubwayLineInfo"]["row"].length;
  i++) {
    stationInfo[fetchData["SearchSTNBySubwayLineInfo"]["row"][i]["FR_CODE"]] =
    fetchData["SearchSTNBySubwayLineInfo"]["row"][i]["STATION_NM"];
  }
  stationInfo = Map.fromEntries(stationInfo.entries.toList()
    ..sort((e1, e2) => e1.key.compareTo(e2.key)));
  print(stationInfo);
  return stationInfo.values.toList();
}
