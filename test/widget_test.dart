// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:find_my_subway/data/hive/data_hive.dart';
import 'package:find_my_subway/data/data_msg_parse.dart';
import 'package:find_my_subway/data/data_set.dart';
import 'package:find_my_subway/data/api/get_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test("망포역 정보가 잘 불러와지는가.", () async {
    List<Pair<Pair<String, String>, int>> input = [];
    input.add(Pair(Pair("망포", "LineBundang"), 12));
    RealTimeEachStationArrival rst = RealTimeEachStationArrival("LineBundang", 12, "망포");

    var stationList = await DataFromAPI.getStationList(input);
    print(stationList[0].up);
    print(stationList[0].down);
    expect(stationList[0].id, equals(12));
  });

  test("망포역 정보가 잘 불러와지는가.", () async {
    List<Pair<Pair<String, String>, int>> input = [];
    input.add(Pair(Pair("구로", "Line1"), 12));
    RealTimeEachStationArrival rst = RealTimeEachStationArrival("Line1", 12, "구로");

    var stationList = await DataFromAPI.getStationList(input);
    print(stationList[0].up);
    print(stationList[0].down);
    expect(stationList[0].id, equals(12));
  });
  test("수인분당의 정보가 잘 불러와지는가.", () async {
    await DataFromAPI.getRealTimePosition();
    print(SubwayListDataSet.RealTimePos["LineBunDang"]!.up[1].stId);
  });
  test("모든 역의 정보가 잘 불러와지는가.", () async {
    Map<String, Map<String, String>> data = await DataFromAPI.getAllStationName();
    for (String line in data.keys) {
      for (String id in data[line]!.keys) {
        print("$line $id ${data[line]![id]!}");
      }
    }
  });
  // test("문자열 파싱 (~분~초 후 내용 지우기)", () {
  //   String str = "7분 36초 후 (남부터미널)";
  //   str = parseString(str);
  //   expect(str, "7분 36초 (남부터미널)");
  // });

  test("다트 문자열 테스트", () {
    String str = "D10";
    int id = parseStationId(str);
    expect(id, 1077010);
  });

}
