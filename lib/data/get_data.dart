import 'dart:convert';
import 'package:find_my_subway/data/data_set.dart';
import 'package:find_my_subway/data/database.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'data_msg_parse.dart';

class Network {
  final String url;

  Network(this.url);

  Future<dynamic> getJsonData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      // print(url);
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var myParsingData = jsonDecode(jsonData);
        return myParsingData;
      }
    } catch (e) {
      print("fail");
    }
  }
}

Future<SubwayListDataSet> getSubwayInfo(UsrDataProvider myDb) async {

  // await myDb.insert(UserData(id: 220, stName: "수원"));
  // await myDb.update(UserData(id: 210, stName: "망포"));
  // await myDb.delete(UserData(id: 2, stName: "수원"));
  // await myDb.delete(UserData(id: 220, stName: "수원"));
  List<UserData>dataFromDb = await myDb.getDB();
  List<String> addedStation = [];
  List<List<String>> tempUpTrain = [];
  List<List<String>> tempDownTrain = [];
  for(int i = 0; i < dataFromDb.length; i++) {
    addedStation.add(dataFromDb[i].stName);
    print(dataFromDb[i].id);
  }


  var SubData = new SubwayListDataSet();

  String apikey = "49647777496c656d39304a6d717744";
  // String apikey = "sample";
  for (String cur in addedStation) {
    Network net = Network("http://swopenapi.seoul.go.kr/api/subway/$apikey/"
        "json/realtimeStationArrival/0/10/$cur");
    var fetchData = await net.getJsonData();
    SubData.stationList.add(cur);
    if(fetchData["status"] == 500){
      SubData.upTrainList.add([...tempUpTrain]);
      SubData.downTrainList.add([...tempDownTrain]);
      continue;
    }
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
  print(SubData);
  return SubData;
}

Future<Map<String, List<String>>> getAllStationName() async {
  Map<String, List<String>> stationInfo = {};
  // String apikey = "49647777496c656d39304a6d717744";
  // // String apikey = "sample";
  // Network net = Network("http://openapi.seoul.go.kr:8088/$apikey/json/SearchSTNBySubwayLineInfo/1/100/ / /subwayData.json");
  // var fetchData = await net.getJsonData();

  String jsonString = await rootBundle.loadString('assets/subwayData.json');
  final fetchData = json.decode(jsonString);
  for (int i = 0; i < fetchData["SearchSTNBySubwayLineInfo"]["row"].length; i++) {
    stationInfo[fetchData["SearchSTNBySubwayLineInfo"]["row"][i]["FR_CODE"]] = [
      fetchData["SearchSTNBySubwayLineInfo"]["row"][i]["STATION_NM"],
      fetchData["SearchSTNBySubwayLineInfo"]["row"][i]["STATION_NM_ENG"],
      fetchData["SearchSTNBySubwayLineInfo"]["row"][i]["STATION_NM_JPN"],
    ];
  }
  stationInfo = Map.fromEntries(stationInfo.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
  // print(stationInfo);
  return stationInfo;
}
