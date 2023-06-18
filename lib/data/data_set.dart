import 'package:find_my_subway/data/userData.dart';

class SubwayListDataSet {
  List<UserData> stationList = [];
  List<List<List<String>>> upTrainList = [];
  List<List<List<String>>> downTrainList = [];
  List<StationInform> stData = [];
  // List<EachStation> stUpSituation = [];
  // List<EachStation> stDownSituation = [];
  Map<String, Map<int, StArrivalInfo>> stCurSituation = {"up": {}, "down": {}};
  int vis = 1;
  late Map<String, List<String>> staInfo;
  List<List<int>> comingTrainNo = [];
}

class StationInform {
  StationInform(stCode, kName, eName, jName) {
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
class StArrivalInfo{
  final bool exP;
  final String arrival;
  final int stId;
  StArrivalInfo(this.exP, this.arrival, this.stId);
}

class FriendData {
  late String name;
  late String station;
  late int trainNo;
}

class FriendPageData{
  late bool visible;
  late int autoTimer = 1;
  late int uid;
  late String cur;
  late int curTrainNo;
  List<String> friendList = [];
  List<FriendData> friendData = [];
}