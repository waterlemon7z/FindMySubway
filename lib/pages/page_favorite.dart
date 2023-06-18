import 'dart:async';

import 'package:find_my_subway/data/data_hive.dart';
import 'package:find_my_subway/data/data_set.dart';
import 'package:find_my_subway/data/userData.dart';
import 'package:find_my_subway/widgets/widget_arrivals/widget_location.dart';
import 'package:flutter/material.dart';
import 'package:find_my_subway/data/get_data.dart';
import 'package:find_my_subway/widgets/widget_appbar.dart';
import 'package:find_my_subway/widgets/widget_arrivals.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import '../data/data_location.dart';
import '../widgets/widget_showToast.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> with AutomaticKeepAliveClientMixin<FavoritePage> {
  @override
  bool get wantKeepAlive => true;
  late Future infoList;
  late Future<List<StationInform>> stationData;
  HiveProvider mainHive = new HiveProvider();
  var box = Hive.box("Preferences");
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    infoList = getSubwayInfo();
    _timer = Timer.periodic(Duration(milliseconds: 15000), (timer) => autoRefresh());
    if(box.get("AutoTimer") == 0)
      _timer.cancel();
  }

  void autoRefresh() {
    setState(() {
      infoList = getSubwayInfo();
      showToast("새로고침", true);
    });
  }

  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: SearchAppbar(
        titleName: "즐겨찾는 지하철 역",
        mainHive: mainHive,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: "locate",
            child: Icon(Icons.location_on_outlined),
            onPressed: () async {
              await find(mainHive);
              setState(() {
                infoList = getSubwayInfo();
                // showToast("새로고침", true);
              });
            },
          ),
          FloatingActionButton.small(
            heroTag: "refresh",
            child: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _timer.cancel();
                infoList = getSubwayInfo();
                showToast("새로고침", true);
                _timer = Timer.periodic(Duration(milliseconds: 15000), (timer) => autoRefresh());
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: infoList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(color: Colors.cyanAccent),
            ));
          } else if (snapshot.hasError) {
            return Text(
              'Error: ${snapshot.error}\n불러오기 에러',
              style: TextStyle(fontSize: 15),
            );
          } else {
            if (snapshot.data.stationList.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      '저장된 역이 없습니다.\n우상단의 검색을 통해 추가할 수 있습니다.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.stationList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(),
                          SizedBox(),
                          SizedBox(),
                          SizedBox(),
                          Icon(
                            Icons.delete_forever,
                            color: Color(0xffffffff),
                          ),
                        ],
                      ),
                    ),
                    background:  Container(
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.delete_forever,
                            color: Color(0xffffffff),
                          ),
                          SizedBox(),
                          SizedBox(),
                          SizedBox(),
                          SizedBox(),
                        ],
                      ),
                    ),
                    onDismissed: (direction) {
                      mainHive.delete(snapshot.data.stationList[index].id);
                      setState(() {
                        infoList = getSubwayInfo();
                        snapshot.data.stationList.removeAt(index);
                      });
                      showToast("해당 역이 삭제되었습니다", true);
                    },
                    child: Column(
                      children: [
                        Arrivals(
                          udata: UserData(id: snapshot.data.stationList[index].id, stName: snapshot.data.stationList[index].stName),
                          upNdownTrain: [snapshot.data.upTrainList[index], snapshot.data.downTrainList[index]],
                          mainHive: mainHive,
                          staInfo: snapshot.data.staInfo,
                          comingTrainNo: snapshot.data.comingTrainNo[index],
                        ),
                        Visibility(
                          child: SubwayLocationInfo(
                            snapshot.data.stData,
                            snapshot.data.stationList[index].id,
                            snapshot.data.stCurSituation,
                          ),
                          visible: box.get("Location") == 1 ? true : false,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
