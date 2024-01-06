import 'package:analyzer_plugin/utilities/pair.dart';

class SubwayListDataSet {
  List<RealTimeEachStationArrival> eachStationList = [];
  static Map<String, List<StationInform>> allStationDataByLine = {};
  /*----------------------------------*/
  static Map<String, RealTimePosition> RealTimePos = {};

  static List<StationInform> allStationData = [];
}

class RealTimeEachStationArrival {
  RealTimeEachStationArrival(this.line, this.id, this.kName);

  final String kName;
  String prevName = "x";
  String nextName = "x";
  List<String> ahead = ["상행", "하행"];
  final String line;
  final String id;
  List<Pair<String, String>> up = []; // 종점, 현제
  List<Pair<String, String>> down = [];
}

class RealTimePosition {
  List<StArrivalInfo> up = [];
  List<StArrivalInfo> down = [];
}

class StationInform {
  StationInform(this.stCode, this.realStCode, this.line, this.kName);

  final String stCode;
  final String realStCode;
  final String line;
  final String kName;
}

class EachStation {
  bool exP = false;
  String arrival = "-1";

  EachStation({exP, arrival});
}

class StArrivalInfo {
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

class FriendPageData {
  late bool visible;
  late int autoTimer = 1;
  late int uid;
  late String cur;
  late int curTrainNo;
  List<String> friendList = [];
  List<FriendData> friendData = [];
}
