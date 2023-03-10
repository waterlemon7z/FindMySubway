import 'package:find_my_subway/data/data_set.dart';
List<StationInform> mapData2List(Map<String, List<String>> datas)
{
  List<StationInform> rst = [];
  List<String> tempKey = [];
  List<List<String>> tempVal = [];
  for(String temp in datas.keys)
    {
      tempKey.add(temp);
    }
  for(List<String> temp in datas.values)
    {
      tempVal.add(temp);
    }
  
  for(int i = 0; i < tempKey.length; i++)
    {
      rst.add(StationInform(tempKey[i], tempVal[i][0], tempVal[i][1], tempVal[i][2]));
      // rst.add(StationInform(stCode: tempKey[i], kName: tempVal[i][0], eName: tempVal[i][1], jName: tempVal[i][2]));
    }
  return rst;
}