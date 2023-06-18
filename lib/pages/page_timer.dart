import 'package:find_my_subway/data/data_time_convert.dart';
import 'package:find_my_subway/widgets/widget_showToast.dart';
import 'package:flutter/material.dart';
import 'package:find_my_subway/widgets/widget_appbar.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class SubwayTimer extends StatefulWidget {
  @override
  State<SubwayTimer> createState() => _SubwayTimerState();
}

class _SubwayTimerState extends State<SubwayTimer> {
  late Icon iconStartAndPause;
  late String strTime;
  List<String> timeList = [];
  var box = Hive.box("Preferences");

  @override
  void initState() {
    super.initState();
    if (box.get("StartTime")! == -1) {
      iconStartAndPause = Icon(Icons.play_circle);
    } else {
      iconStartAndPause = Icon(Icons.stop_circle);
    }
    iconStartAndPause = box.get("StartTime")! != -1 ? Icon(Icons.stop_circle) : Icon(Icons.play_circle);
    strTime = box.get("StartTime")! == -1
        ? "--:--"
        : DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(box.get("StartTime")! * 1000));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars(titleName: "Timer to school"),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
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
                  if (box.get("StartTime")! == -1) {
                    box.put("StartTime", (DateTime.now().millisecondsSinceEpoch).toInt());
                    setState(() {
                      strTime = DateFormat('HH:mm').format(DateTime.now());
                      iconStartAndPause = Icon(Icons.play_circle);
                    });
                  } else {
                    var date = new DateTime.fromMicrosecondsSinceEpoch(box.get("StartTime")! * 1000);
                    print(date);
                    box.put("StartTime", -1);
                    timeList = box.get("Times")!;
                    timeList.add(DateTime.now().difference(date).inSeconds.toString());
                    box.put("Times", timeList);
                    setState(() {
                      iconStartAndPause = Icon(Icons.stop_circle);
                    });
                  }
                },
                child: IconButton(
                  onPressed: () {
                    if (box.get("StartTime")! == -1) {
                      // prefs.setBool("TimeState", true);
                      box.put("StartTime", (DateTime.now().millisecondsSinceEpoch).toInt());
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
                          secToEverageStr(box.get("Times")!) + " (총 ${box.get("Times")!.length}회)",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: box.get("Times")!.length,
                  itemBuilder: (context, index) {
                    List<String> temp = box.get("Times")!;
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
                          box.put("Times", temp);
                          showToast("해당 시간이 삭제되었습니다", true);
                        },
                        child: Text(
                          secToStr(int.parse(temp[temp.length - index - 1])),
                        ));
                  },
                ),
              ),
            ],
          )),
    );
  }
}
