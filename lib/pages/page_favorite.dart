import 'package:flutter/material.dart';
import 'package:find_my_subway/data/get_data.dart';
import 'package:find_my_subway/widgets/widget_appbar.dart';
import 'package:find_my_subway/widgets/widget_arrivals.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  List stations = ["고색", "죽전", "오리", "매탄권선", "수원","복정"];
  List<String> stationList = [];
  List<List<List<String>>> upTrainList = [];
  List<List<List<String>>> downTrainList = [];
  List<List<String>> tempUpTrain = [];
  List<List<String>> tempDownTrain = [];

  Future<bool> getSubwayInfo() async {
    String apikey = "49647777496c656d39304a6d717744";
    // String apikey = "sample";
    for (String cur in stations) {
      Network net = Network("http://swopenapi.seoul.go.kr/api/subway/$apikey/"
          "json/realtimeStationArrival/0/10/$cur");
      var fetchData = await net.getJsonData();
      // print(fetchData);
      stationList.add(cur);
      for (int i = 0; i < fetchData["realtimeArrivalList"].length; i++) {
        var target = fetchData["realtimeArrivalList"][i];
        if(target["subwayId"] == "1075") {
          if (target["updnLine"] == "상행") {
            tempUpTrain.add([target["bstatnNm"], target["arvlMsg2"]]);
          } else if (target["updnLine"] == "하행") {
            tempDownTrain.add([target["bstatnNm"], target["arvlMsg2"]]);
          } else
            print("fail");
        }
      }
      upTrainList.add([...tempUpTrain]);
      downTrainList.add([...tempDownTrain]);
      tempUpTrain.clear();
      tempDownTrain.clear();
    }
    print(stationList.length);
    print(upTrainList);
    print(downTrainList);
    return true;
  }

  void initState() {
    super.initState();
    stationList.clear();
    upTrainList.clear();
    downTrainList.clear();
  }
  var test = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars(titleName: "즐겨찾는 지하철 역"),
      backgroundColor: Color(0xff000000),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getSubwayInfo(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData == false) {
                return CircularProgressIndicator();
              }
              //error가 발생하게 될 경우 반환하게 되는 부분
              else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 15),
                  ),
                );
              } else {
                return Column(
                  children: [
                    for (int i = 0; i < stationList.length; i++)
                      Arrivals(
                        station: stationList[i],
                        upNdownTrain: [upTrainList[i], downTrainList[i]],
                      ),
                  ],
                );
              }
            }),
      ),
    );
  }
}
