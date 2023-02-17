class SubwayListDataSet {
  List<String> stationList = [];
  List<List<List<String>>> upTrainList = [];
  List<List<List<String>>> downTrainList = [];
}

class StationInform {
  late String stCode;
  late String kName;
  late String eName;
  late String jName;

  StationInform({required this.stCode, required this.kName, required this.eName, required this.jName});
}
