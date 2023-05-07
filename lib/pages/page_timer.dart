import 'package:find_my_subway/data/data_time_convert.dart';
import 'package:find_my_subway/widgets/widget_showToast.dart';
import 'package:flutter/material.dart';
import 'package:find_my_subway/widgets/widget_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class SubwayTimer extends StatefulWidget {
  @override
  State<SubwayTimer> createState() => _SubwayTimerState();
}

class _SubwayTimerState extends State<SubwayTimer> {
  @override
  late Icon iconStartAndPause;
  late String strTime;
  List<String> timeList = [];
  late Future loadData;

  @override
  void initState() {
    super.initState();
    loadData = prefsLoad();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars(titleName: "Timer to school"),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: FutureBuilder(
          future: loadData,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
              SharedPreferences prefs = snapshot.data;
              iconStartAndPause = prefs.getInt("StartTime")! != -1 ? Icon(Icons.stop_circle) : Icon(Icons.play_circle);
              strTime = prefs.getInt("StartTime")! == -1
                  ? "--:--"
                  : DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(prefs.getInt("StartTime")! * 1000));
              print(prefs.getStringList("Times"));
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 100,
                        // color: Color(0xff000000),
                        child: Column(
                          children: [
                            Text(
                              DateFormat('MM/dd').format(DateTime.now()),
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("날짜"),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        child: Column(
                          children: [
                            Text(
                              DateFormat.EEEE().format(DateTime.now()).substring(0, 3),
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("요일"),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        child: Column(
                          children: [
                            Text(
                              " ",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("  "),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      Text(
                        strTime,
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "시작 시간",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onLongPress: () {
                      if (prefs.getInt("StartTime")! == -1) {
                        prefs.setInt("StartTime", (DateTime.now().millisecondsSinceEpoch).toInt());
                        setState(() {
                          strTime = DateFormat('HH:mm').format(DateTime.now());
                          iconStartAndPause = Icon(Icons.play_circle);
                        });
                      } else {
                        var date = new DateTime.fromMicrosecondsSinceEpoch(prefs.getInt("StartTime")! * 1000);
                        print(date);
                        prefs.setInt("StartTime", -1);
                        timeList = prefs.getStringList("Times")!;
                        timeList.add(DateTime.now().difference(date).inSeconds.toString());
                        prefs.setStringList("Times", timeList);
                        setState(() {
                          iconStartAndPause = Icon(Icons.stop_circle);
                        });
                      }
                    },
                    child: IconButton(
                      onPressed: () {
                        if (prefs.getInt("StartTime")! == -1) {
                          // prefs.setBool("TimeState", true);
                          prefs.setInt("StartTime", (DateTime.now().millisecondsSinceEpoch).toInt());
                          setState(() {
                            strTime = DateFormat('HH:mm').format(DateTime.now());
                            iconStartAndPause = Icon(Icons.play_circle);
                          });
                        } else {
                          showToast("길게눌러 종료하기", true);
                        }
                      },
                      icon: iconStartAndPause,
                      iconSize: 100,
                      enableFeedback: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "평균시간",
                              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(),
                            Text(
                              secToEverageStr(prefs.getStringList("Times")!) + " (총 ${prefs.getStringList("Times")!.length}회)",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: prefs.getStringList("Times")!.length,
                      itemBuilder: (context, index) {
                        List<String> temp = prefs.getStringList("Times")!;
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
                            background: Container(
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
                              temp.removeAt(temp.length - index - 1);
                              prefs.setStringList("Times", temp);
                              setState(() {
                                loadData = prefsLoad();
                              });
                              showToast("해당 시간이 삭제되었습니다", true);
                            },
                            child: Text(
                              secToStr(int.parse(temp[temp.length - index - 1])),
                            ));
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<SharedPreferences> prefsLoad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt("StartTime")! == -1) {
      iconStartAndPause = Icon(Icons.play_circle);
    } else {
      iconStartAndPause = Icon(Icons.stop_circle);
    }
    return prefs;
  }
}
