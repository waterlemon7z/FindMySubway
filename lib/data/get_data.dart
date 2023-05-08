import 'dart:convert';
import 'package:find_my_subway/data/data_hive.dart';
import 'package:find_my_subway/data/data_set.dart';
import 'package:find_my_subway/data/userData.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'data_msg_parse.dart';
import 'data_to_list.dart';

class Network {
  final String url;

  Network(this.url);

  Future<dynamic> getJsonData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
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

bool verifyWebsite(String str) {
  print(str);

  if (str == 500) {
    print("no");
    return false;
  }
  return true;
}

Future<SubwayListDataSet> getSubwayInfo(HiveProvider mainHive) async {
  List<UserData> dataFromDb = await mainHive.getUserDataFromHive();
  List<List<dynamic>> addedStation = [];
  List<List<String>> tempUpTrain = [];
  List<List<String>> tempDownTrain = [];
  List<int> tempNextTrain = [-1, -1];
  for (int i = 0; i < dataFromDb.length; i++) {
    addedStation.add([dataFromDb[i].stName, dataFromDb[i].id]);
  }

  var SubData = new SubwayListDataSet();
  SubData.stData = await mapData2List(await getAllStationName());
  String apikey = "49647777496c656d39304a6d717744";
  // String apikey = "sample";
  for (dynamic cur in addedStation) {
    Network net = Network("//swopenapi.seoul.go.kr/api/subway/$apikey/"
        "json/realtimeStationArrival/0/10/${cur[0]}");
    var fetchData = await net.getJsonData();
    SubData.stationList.add(UserData(id: cur[1], stName: cur[0]));
    if (fetchData["errorMessage"]["status"] == 200 || fetchData["status"] != 500)
      for (int i = 0; i < fetchData["realtimeArrivalList"].length; i++) {
        var target = fetchData["realtimeArrivalList"][i];
        if (target["subwayId"] == "1075") {
          if (target["updnLine"] == "상행") {
            if (tempNextTrain[0] == -1) {
              tempNextTrain[0] = int.parse(target["btrainNo"]);
            }
            tempUpTrain.add([parseAheadString(target["bstatnNm"]), parseString(target["arvlMsg2"])]);
          } else if (target["updnLine"] == "하행") {
            if (tempNextTrain[1] == -1) {
              tempNextTrain[1] = int.parse(target["btrainNo"]);
            }
            tempDownTrain.add([parseAheadString(target["bstatnNm"]), parseString(target["arvlMsg2"])]);
          } else
            print("fail");
        }
      }
    SubData.upTrainList.add([...tempUpTrain]);
    SubData.downTrainList.add([...tempDownTrain]);
    SubData.comingTrainNo.add([...tempNextTrain]);
    tempUpTrain.clear();
    tempDownTrain.clear();
    tempNextTrain = [-1, -1];
  }
  for (int i = 0; i < 63; i++) {
    SubData.stUpSituation.add(new EachStation(exP: false, arrival: "-1"));
    SubData.stDownSituation.add(new EachStation(exP: false, arrival: "-1"));
    // if(i == 58)
    //   {
    //     SubData.stUpSituation.add(new EachStation(exP : false, arrival: "-1"));
    //     SubData.stDownSituation.add(new EachStation(exP : false, arrival: "-1"));
    //   }
  }

  Network net = Network("//swopenapi.seoul.go.kr/api/subway/$apikey/json/realtimePosition/0/70/수인분당선");
  var fetchData = await net.getJsonData();
  if (fetchData["errorMessage"]["status"] == 200 || fetchData["status"] != 500)
    for (int i = 0; i < fetchData["realtimePositionList"].length; i++) {
      var target = fetchData["realtimePositionList"][i];
      if (target["updnLine"] == "0") {
        int stCode = int.parse(target["statnId"].substring(7));
        // SubData.stSituation[stCode - 209] = EachStation(arrival:int.parse(target["trainSttus"]), exP: target["directAt"] == '0' ? false : true);
        SubData.stUpSituation[stCode - 209].arrival = target["trainSttus"];
        SubData.stUpSituation[stCode - 209].exP = target["directAt"] == '0' ? false : true;
      } else {
        int stCode = int.parse(target["statnId"].substring(7));
        // SubData.stSituation[stCode - 209] = EachStation(arrival:int.parse(target["trainSttus"]), exP: target["directAt"] == '0' ? false : true);
        SubData.stDownSituation[stCode - 209].arrival = target["trainSttus"];
        SubData.stDownSituation[stCode - 209].exP = target["directAt"] == '0' ? false : true;
      }
    }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  SubData.vis = (await prefs.getInt("Location"))!;
  SubData.pref = await SharedPreferences.getInstance();
  SubData.staInfo = await getAllStationName();
  return SubData;
}

Future<Map<String, List<String>>> getAllStationName() async {
  Map<String, List<String>> stationInfo = {};
  Network net = Network("https://raw.githubusercontent.com/waterlemon7z/FindMySubway/main/assets/subwayData.json");
  var fetchData = await net.getJsonData();
  // String jsonString = await rootBundle.loadString('assets/subwayData.json');
  // var fetchData = json.decode(jsonString);

  for (int i = 0; i < fetchData["SearchSTNBySubwayLineInfo"]["row"].length; i++) {
    stationInfo[fetchData["SearchSTNBySubwayLineInfo"]["row"][i]["FR_CODE"]] = [
      fetchData["SearchSTNBySubwayLineInfo"]["row"][i]["STATION_NM"],
      fetchData["SearchSTNBySubwayLineInfo"]["row"][i]["STATION_NM_ENG"],
      fetchData["SearchSTNBySubwayLineInfo"]["row"][i]["STATION_NM_JPN"],
    ];
  }

  // stationInfo["K268"] = ["학익", "Hagik", "鶴翼"];
  stationInfo = Map.fromEntries(stationInfo.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
  return stationInfo;
}

Future<String> GetCurrentLoc(int trainNo, List<FriendData> arr) async {
  String rst = 'None';
  String apikey = "49647777496c656d39304a6d717744";
  // String apikey = "sample";
  Network net = Network("//swopenapi.seoul.go.kr/api/subway/$apikey/json/realtimePosition/0/70/수인분당선");
  var fetchData = await net.getJsonData();
  if (trainNo == -1) {
    rst = "지하철 탑승중이 아닙니다.";
  } else {
    // print("fine");
    for (int i = 0; i < fetchData["realtimePositionList"].length; i++) {
      // print(fetchData["realtimePositionList"][i]["trainNo"]);
      if (trainNo.toString().compareTo(fetchData["realtimePositionList"][i]["trainNo"]) == 0) {
        rst = fetchData["realtimePositionList"][i]["statnNm"];
      }
    }
  }
  for (int i = 0; i < arr.length; i++) {
    arr[i].station = "None";
    if (arr[i].trainNo == -1) {
      arr[i].station = "지하철 탑승중이 아닙니다.";
      continue;
    }
    for (int j = 0; j < fetchData["realtimePositionList"].length; j++) {
      // print(fetchData["realtimePositionList"][i]["trainNo"]);
      if (arr[i].trainNo.toString().compareTo(fetchData["realtimePositionList"][j]["trainNo"]) == 0) {
        arr[i].station = fetchData["realtimePositionList"][j]["statnNm"];
        break;
      }
    }
  }

  return rst;
}
