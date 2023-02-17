import 'package:find_my_subway/data/database.dart';
import 'package:flutter/material.dart';
import 'package:find_my_subway/data/get_data.dart';
import 'package:find_my_subway/widgets/widget_appbar.dart';
import 'package:find_my_subway/widgets/widget_arrivals.dart';
import 'package:flutter/rendering.dart';

import '../widgets/widget_showToast.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with AutomaticKeepAliveClientMixin<FavoritePage> {
  @override
  bool get wantKeepAlive => true;
  late Future infoList;

  UsrDataProvider myDb = new UsrDataProvider();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppbar(titleName: "즐겨찾는 지하철 역", myDb: myDb,),
      // appBar: SearchAppBar(addedStation: addedStation),
      backgroundColor: Color(0xff000000),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          setState(() {
            infoList =  getSubwayInfo(myDb);
            showToast("새로고침");
          });
        },
        child: Icon(Icons.refresh),
      ),
      body: FutureBuilder(
        future: infoList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
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
                      style: TextStyle(color: Color(0xffffffff)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            else
            {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    for (int index = 0; index < snapshot.data.stationList.length; index++)
                      Arrivals(
                        station: snapshot.data.stationList[index],
                        upNdownTrain: [snapshot.data.upTrainList[index], snapshot.data.downTrainList[index]],
                      ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }

  void initState() {
    super.initState();
    infoList = getSubwayInfo(myDb);
    myDb.initDB();
  }
}