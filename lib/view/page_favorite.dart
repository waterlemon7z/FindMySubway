import 'dart:async';

import 'package:find_my_subway/data/api/get_data.dart';
import 'package:find_my_subway/data/data_set.dart';
import 'package:find_my_subway/service/UserSubwayService.dart';
import 'package:find_my_subway/view/widgets/widget_appbar.dart';
import 'package:find_my_subway/view/widgets/widget_arrivals.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../view/widgets/widget_showToast.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> with AutomaticKeepAliveClientMixin<FavoritePage> {
  @override
  bool get wantKeepAlive => true;
  late Future infoList;
  late Future<List<StationInform>> stationData;

  //Todo
  final UserSubwayService _userSubwayService = UserSubwayService();
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
    infoList = DataFromAPI.getSubwayInfo();
    _timer = Timer.periodic(const Duration(milliseconds: 15000), (timer) => autoRefresh());
    if (box.get("AutoTimer") == 0) {
      _timer.cancel();
    }
  }

  void autoRefresh() {
    setState(() {
      infoList = DataFromAPI.getSubwayInfo();
      showToast("새로고침", true);
    });
  }

  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: SearchAppbar(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: "locate",
            child: const Icon(Icons.location_on_outlined),
            onPressed: () async {
              // await find(_userSubwayService);
              setState(() {
                infoList = DataFromAPI.getSubwayInfo();
                // showToast("새로고침", true);
              });
            },
          ),
          FloatingActionButton.small(
            heroTag: "refresh",
            child: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _timer.cancel();
                infoList = DataFromAPI.getSubwayInfo();
                showToast("새로고침", true);
                _timer = Timer.periodic(const Duration(milliseconds: 15000), (timer) => autoRefresh());
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
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(color: Colors.cyanAccent),
            ));
          } else if (snapshot.hasError) {
            return Text(
              'Error: ${snapshot.error}\n불러오기 에러',
              style: const TextStyle(fontSize: 15),
            );
          } else {
            if (snapshot.data.eachStationList.length == 0) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '저장된 역이 없습니다.\n우상단의 검색을 통해 추가할 수 있습니다.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              SubwayListDataSet data = snapshot.data;
              return ListView.builder(
                itemCount: data.eachStationList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: const Row(
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
                    background: Container(
                      color: Colors.red,
                      child: const Row(
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
                      _userSubwayService.delete(data.eachStationList[index].id);
                      setState(() {
                        infoList = DataFromAPI.getSubwayInfo();
                        snapshot.data.eachStationList.removeAt(index);
                      });
                      showToast("해당 역이 삭제되었습니다", true);
                    },
                    child: Column(
                      children: [
                        Arrivals(
                          // udata: UserData(id: snapshot.data.stationList[index].id, stName: snapshot.data.stationList[index].stName,line: snapshot.data.stationList[index].line),
                          curStationInfo: data.eachStationList[index],
                          // staInfo: data.stData[index],
                          // comingTrainNo: snapshot.data.comingTrainNo[index],
                        ),
                        // Visibility(
                        //   child: SubwayLocationInfo(
                        //     snapshot.data.stData,
                        //     snapshot.data.stationList[index].id,
                        //     snapshot.data.stCurSituation,
                        //   ),
                        //   visible: box.get("Location") == 1 ? true : false,
                        // ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
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
