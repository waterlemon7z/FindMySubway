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
  late String stCode;
  late String kName;
  late String eName;
  late String jName;

  StationInform({required this.stCode, required this.kName, required this.eName, required this.jName});
}

class EachStation{
  bool exP = false;
  String arrival = "-1";
  EachStation({exP,arrival});

}