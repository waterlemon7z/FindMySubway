import 'package:flutter/material.dart';
import 'package:find_my_subway/data/get_data.dart';
import 'package:find_my_subway/widgets/widget_appbar.dart';
import 'package:find_my_subway/widgets/widget_arrivals.dart';
import 'package:flutter/rendering.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with AutomaticKeepAliveClientMixin<FavoritePage> {
  @override
  bool get wantKeepAlive => true;
  late Future infoList;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(addedStation: ["수원","매교", "매탄권선", "망포", "영통", "상갈", "기흥"]),
      backgroundColor: Color(0xff000000),
      floatingActionButton: FloatingActionButton.small(
        onPressed:  () {
          setState(() {
            infoList = getSubwayInfo();
          });
        },
        child: Icon(Icons.refresh),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
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
                  return Container(
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
              },
            ),
          ],
        ),
      ),
    );
  }

  void initState() {
    super.initState();
    infoList = getSubwayInfo();
    print("asdsf");
  }
}
