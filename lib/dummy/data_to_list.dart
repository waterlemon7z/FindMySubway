import 'package:find_my_subway/data/data_set.dart';

List<StationInform> mapData2List(Map<String, Map<String, String>> datas) {
  List<StationInform> rst = [];
  for (String line in datas.keys) {
    for (String eachStation in datas[line]!.keys) {
      rst.add(StationInform(eachStation, line, datas[line]![eachStation]!));
    }
  }
  return rst;
}
