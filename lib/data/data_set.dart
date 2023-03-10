import 'package:find_my_subway/data/database.dart';

class SubwayListDataSet {
  List<UserData> stationList = [];
  List<List<List<String>>> upTrainList = [];
  List<List<List<String>>> downTrainList = [];
  List<StationInform> stData = [];
  List<EachStation> stUpSituation = [];
  List<EachStation> stDownSituation = [];
  int vis = 1;
}

class StationInform {
  StationInform(stCode, kName, eName, jName)
  {
    this.stCode = stCode;
    this.kName = kName;
     this.eName = eName;
      this.jName = jName;
  }
  String stCode = '';
  String kName = '';
  String eName = '';
  String jName = '';
 }

class EachStation {
  bool exP = false;
  String arrival = "-1";

  EachStation({exP, arrival});
}
