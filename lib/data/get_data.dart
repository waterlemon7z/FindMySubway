// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:find_my_subway/data/data_hive.dart';
import 'package:find_my_subway/data/data_set.dart';
import 'package:find_my_subway/data/userData.dart';
import 'package:flutter/services.dart';
import 'data_Network.dart';
import 'data_msg_parse.dart';
import 'data_to_list.dart';

class DataFromAPI {
  static String apikey = "49647777496c656d39304a6d717744";

  // String apikey = "sample";
  //Todo: Line ID Set
  static String _lineIdConvertor(String str) {
    if (str == "LineBundang") {
      return "1075";
    } else if (str == "LineShinBundang") {
      return "1077";
    } else if (str == "LineGyeongui") {
      return "1063";
    } else if (str == "LineGyeongchun") {
      return "1067";
    } else if (str == "LineGyeonggang") {
      return "1081";
    } else if (str == "Line1") {
      return "1001";
    } else if (str == "Line2") {
      return "1002";
    } else if (str == "Line3") {
      return "1003";
    } else if (str == "Line4") {
      return "1004";
    } else if (str == "Line5") {
      return "1005";
    } else if (str == "Line6") {
      return "1006";
    } else if (str == "Line7") {
      return "1007";
    } else if (str == "Line8") {
      return "1008";
    } else if (str == "Line9") {
      return "1009";
    }
    return "";
  }

  static Future<List<RealTimeEachStationArrival>> getStationList(List<Pair<Pair<String, String>, int>> addedStation) async {
    List<RealTimeEachStationArrival> rst = [];
    print("total station count : ${addedStation.length}");
    for (Pair<Pair<String, String>, int> cur in addedStation) {
      // pair(pair(stName, line), id)
      print("loading station : ${cur.first.first}");
      Network net = Network("http://swopenapi.seoul.go.kr/api/subway/$apikey/"
          "json/realtimeStationArrival/0/30/${cur.first.first}");
      String line = _lineIdConvertor(cur.first.last);
      Map<String, dynamic> fetchData = await net.getJsonData();
      if (fetchData.containsKey("errorMessage") == true && fetchData["errorMessage"]["status"] == 200) {
        rst.add(RealTimeEachStationArrival(cur.first.last, cur.last, cur.first.first));

        // print("test : ${fetchData["realtimeArrivalList"][3]}");
        for (var target in fetchData["realtimeArrivalList"]) {
          if (target["subwayId"] == line) {
            if (target["updnLine"] == "상행" || target["updnLine"] == "내선") {
              rst.last.up.add(Pair(parseAheadString(target["bstatnNm"]), parseString(target["arvlMsg2"], target["arvlMsg3"])));
            } else if (target["updnLine"] == "하행" || target["updnLine"] == "외선") {
              rst.last.down.add(Pair(parseAheadString(target["bstatnNm"]), parseString(target["arvlMsg2"], target["arvlMsg3"])));
            }
          }
        }
      } else if (fetchData["status"] == 500) {
        rst.add(RealTimeEachStationArrival(cur.first.last, cur.last, cur.first.first));
      }

      int index = 0;
      Iterable<String> stationNames = SubwayListDataSet.allStationDataByLine[cur.first.last]!.values;

      for (String iter in stationNames) {
        if (iter == rst.last.kName) {
          break;
        }
        index++;
      }

      if (index - 1 >= 0 ) {
        rst.last.nextName = stationNames.elementAt(index - 1);
      }
      if (index + 1 < stationNames.length) {
        rst.last.prevName= stationNames.elementAt(index + 1);
      }
      if (rst.last.kName == "가산디지털단지") {
        rst.last.nextName = "구로";
      }
      //Todo: ahead Set
      if (line == "1075") {
        rst.last.ahead = ["청량리", "인천"]; // 수인분당
      } else if (line == "1077") {
        rst.last.ahead = ["신사", "광교"]; //신분당
      } else if (line == "1063") {
        rst.last.ahead = ["문산", "지평"]; //경의중앙
      } else if (line == "1067") {
        rst.last.ahead = ["청량리/광운대", "춘천"]; //경춘
      } else if (line == "1081") {
        rst.last.ahead = ["판교", "여주"]; //경춘
      } else if (line == "1001") {
        rst.last.ahead = ["상행", "하행"];
      } else if (line == "1002") {
        rst.last.ahead = ["내선 순환", "외선 순환"];
      } else if (line == "1003") {
        rst.last.ahead = ["대화", "오금"];
      } else if (line == "1004") {
        rst.last.ahead = ["진접", "오이도"];
      } else if (line == "1005") {
        rst.last.ahead = ["방화", "하행"];
      } else if (line == "1006") {
        rst.last.ahead = ["응암", "신내"];
      } else if (line == "1007") {
        rst.last.ahead = ["장암", "석남"];
      } else if (line == "1008") {
        rst.last.ahead = ["암사", "모란"];
      } else if (line == "1009") {
        rst.last.ahead = ["김포공항", "중앙보훈병원"];
      }
    }
    return rst;
  }

  static Future<void> getRealTimePosition() async {
    SubwayListDataSet.RealTimePos["LineBunDang"] = RealTimePosition();

    Network net = Network("http://swopenapi.seoul.go.kr/api/subway/$apikey/json/realtimePosition/0/70/수인분당선");

    var fetchData = await net.getJsonData();
    if (fetchData["errorMessage"]["status"] == 200 || fetchData["status"] != 500) {
      for (int i = 0; i < fetchData["realtimePositionList"].length; i++) {
        var target = fetchData["realtimePositionList"][i];
        if (target["updnLine"] == "0") {
          // up
          SubwayListDataSet.RealTimePos["LineBunDang"]!.up
              .add(StArrivalInfo(target["directAt"] == '0' ? false : true, target["trainSttus"], int.parse(target["statnId"].substring(7))));
        } else {
          // down
          SubwayListDataSet.RealTimePos["LineBunDang"]!.down
              .add(StArrivalInfo(target["directAt"] == '0' ? false : true, target["trainSttus"], int.parse(target["statnId"].substring(7))));
        }
      }
    }
    return;
  }

  static Future<void> initStationData() async {
    SubwayListDataSet.allStationDataByLine = await getAllStationName();
    SubwayListDataSet.allStationData = mapData2List(SubwayListDataSet.allStationDataByLine);
  }

  static Future<SubwayListDataSet> getSubwayInfo() async {
    // Boss!!
    HiveProvider mainHive = HiveProvider();
    SubwayListDataSet SubData = SubwayListDataSet();

    List<UserData> dataFromDb = await mainHive.getUserDataFromHive();
    List<Pair<Pair<String, String>, int>> addedStation = [];
    for (int i = 0; i < dataFromDb.length; i++) {
      addedStation.add(Pair(Pair(dataFromDb[i].stName, dataFromDb[i].line), dataFromDb[i].id));
    }
    SubData.eachStationList = await getStationList(addedStation);
    //Todo: await getRealTimePosition();
    // SubData.staInfo = await getAllStationName();
    // print(SubData.stationList[1].id);
    return SubData;
  }

  static Future<Map<String, Map<String, String>>> getAllStationName() async {
    //Todo: Line Set
    List<Pair<String, String>> searchList = [
      Pair("01호선", "Line1"),
      Pair("02호선", "Line2"),
      Pair("03호선", "Line3"),
      Pair("04호선", "Line4"),
      Pair("05호선", "Line5"),
      Pair("06호선", "Line6"),
      Pair("07호선", "Line7"),
      Pair("08호선", "Line8"),
      Pair("09호선", "Line9"),
      Pair("수인분당선", "LineBundang"),
      Pair("신분당선", "LineShinBundang"),
      Pair("경의선", "LineGyeongui"),
      Pair("경춘선", "LineGyeongchun"),
      Pair("경강선", "LineGyeonggang"),
    ];
    // Map<String, Map<String, List<String>>> stationInfo = {};
    Map<String, Map<String, String>> result = {};
    Network net = Network("https://raw.githubusercontent.com/waterlemon7z/FindMySubway/main/assets/subwayData.json");
    var fetchData = await net.getJsonData();
    // String jsonString = await rootBundle.loadString('assets/subwayData.json');
    // var fetchData = json.decode(jsonString);

    // for (Pair<String, String> iter in searchList) {
    //   Map<String, List<String>> items = {};
    //   for (int i = 0; i < fetchData["DATA"].length; i++) {
    //     if (fetchData["DATA"][i]["line_num"] == iter.first) {
    //       items[fetchData["DATA"][i]["fr_code"]] = [
    //         fetchData["DATA"][i]["station_nm"],
    //       ];
    //     }
    //   }
    //   // stationInfo["K268"] = ["학익", "Hagik", "鶴翼"];
    //   items = Map.fromEntries(items.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
    //   stationInfo[iter.last] = items;
    // }
    for (Pair<String, String> line in searchList) {
      result[line.last] = {};
    }
    for (var iter in fetchData["DATA"]) {
      for (Pair<String, String> line in searchList) {
        if (iter["line_num"] == line.first) {
          // print("${line.last} ${iter["fr_code"]} ${iter["station_nm"]}");
          result[line.last]![iter["fr_code"]] = iter["station_nm"];
          break;
        }
      }
    }
    for (Pair<String, String> line in searchList) {
      var items = result[line.last];

      result[line.last] = Map.fromEntries(
          items!.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
    }
    return result;
  }

  static Future<String> GetCurrentLoc(int trainNo, List<FriendData> arr) async {
    String rst = 'None';
    String apikey = "49647777496c656d39304a6d717744";
    // String apikey = "sample";
    Network net = Network("http://swopenapi.seoul.go.kr/api/subway/$apikey/json/realtimePosition/0/70/수인분당선");
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
}
