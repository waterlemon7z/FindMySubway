import 'package:find_my_subway/data/data_set.dart';
List<StationInform> mapData2List(Map<String, Map<String, String>> datas)
{
  List<StationInform> rst = [];
  // for(String iter in datas.keys) {
  //   List<String> tempKey = [];
  //   List<List<String>> tempVal = [];
  //
  //   for (String temp in datas[iter]!.keys) {
  //     tempKey.add(temp);
  //   }
  //   for (List<String> temp in datas[iter]!.values) {
  //     tempVal.add(temp);
  //   }
  //
  //   for (int i = 0; i < tempKey.length; i++) {
  //     rst.add(StationInform(tempKey[i], iter, tempVal[i][0]));
  //   }
  // }
  //
  for(String line in datas.keys) {
      for(String eachStation in datas[line]!.keys)
        {
          rst.add(StationInform(eachStation, line, datas[line]![eachStation]!));
        }
    }
  return rst;
}