import 'package:find_my_subway/data/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubwayListDataSet {
  List<UserData> stationList = [];
  List<List<List<String>>> upTrainList = [];
  List<List<List<String>>> downTrainList = [];
  List<StationInform> stData = [];
  List<EachStation> stUpSituation = [];
  List<EachStation> stDownSituation = [];
  int vis = 1;
  late SharedPreferences pref;
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

class FriendData {
  late String name;
  late String station;
  late int trainNo;
}

class FriendPageData{
  late SharedPreferences prefs;
  late bool visible;
  late int autoTimer = 1;
  late int uid;
  late String cur;
  late int curTrainNo;
  List<String> friendList = [];
  List<FriendData> friendData = [];
}