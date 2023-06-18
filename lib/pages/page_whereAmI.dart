import 'dart:async';

import 'package:find_my_subway/data/data_set.dart';
import 'package:find_my_subway/widgets/widget_appbar.dart';
import 'package:find_my_subway/widgets/widget_arrivals/widget_line_icon.dart';
import 'package:find_my_subway/widgets/widget_arrivals/widget_station_name.dart';
import 'package:find_my_subway/widgets/widget_showToast.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/get_data.dart';

class WhereAmI extends StatefulWidget {
  @override
  State<WhereAmI> createState() => _WhereAmIState();
}

class _WhereAmIState extends State<WhereAmI> {
  late Future loadData;
  final firestore = FirebaseFirestore.instance;

  // late bool visible;
  // late int autoTimer;
  // late int uid;
  // late String cur;
  // late int curTrainNo;
  late Timer _timer;

  // List<String> friendList = [];
  // List<FriendData> friendData = [];
  late FriendPageData friendpd;
  String? friendUid = '-1';

  void initState() {
    super.initState();
    loadData = friendPageLoad();
    _timer = Timer.periodic(Duration(milliseconds: 15000), (timer) => autoRefresh());
  }

  void autoRefresh() {
    if (mounted)
      setState(() {
        if (friendpd.autoTimer == 1) {
          loadData = friendPageLoad();
          showToast("새로고침", true);
        }
      });
  }

  Future<void> _AddFriendPopUp(BuildContext context) async {
    final TextEditingController _textFieldController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          String? valueText;
          return AlertDialog(
            title: const Text('친구 추가'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("내 ID : ${friendpd.uid}"),
                TextField(
                  onChanged: (value) {
                    if (mounted)
                      setState(() {
                        valueText = value;
                      });
                  },
                  controller: _textFieldController,
                  decoration: const InputDecoration(hintText: "친구의 ID 입력하기"),
                ),
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                // color: Colors.transparent,
                textColor: Colors.black,
                child: const Text('취소하기'),
                onPressed: () {
                  if (mounted)
                    setState(() {
                      Navigator.pop(context);
                    });
                },
              ),
              MaterialButton(
                // color: Colors.green,
                textColor: Colors.black,
                child: const Text('추가하기'),
                onPressed: () {
                  if (mounted)
                    setState(() {
                      friendUid = valueText;
                      Navigator.pop(context);
                    });
                },
              ),
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars(titleName: "My Location"),
      floatingActionButton: FloatingActionButton.small(
        heroTag: "refresh",
        child: Icon(Icons.refresh),
        onPressed: () {
          _timer.cancel();
          showToast("새로고침", true);
          _timer = Timer.periodic(Duration(milliseconds: 15000), (timer) => autoRefresh());

          if (mounted)
            setState(() {
              loadData = friendPageLoad();
            });
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: FutureBuilder(
          future: loadData,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
              friendpd = snapshot.data;
              var box = Hive.box("Preferences");
              return Column(
                children: [
                  ListTile(
                    leading: box.get("CurrentTrain")! != -1 ? IconBundang() : null,
                    title: StationName(
                      stName: friendpd.cur.toString(),
                    ),
                    trailing: box.get("CurrentTrain")! != -1
                        ? TextButton(
                            child: Text(
                              "하차",
                              // style: TextStyle(color: Color(0xff000000)),
                            ),
                            onPressed: () {
                              box.put("CurrentTrain", -1);
                              firestore.collection("CurrentLoc").doc(friendpd.uid.toString()).update(<String, dynamic>{"TrainNo": -1});
                              showToast("하차완료", false);
                              if (mounted)
                                setState(() {
                                  loadData = friendPageLoad();
                                });
                            },
                          )
                        : null,
                  ),
                  Expanded(
                    child: Visibility(
                      visible: friendpd.visible,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Friend's Location",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await _AddFriendPopUp(context);
                                  print(friendUid);
                                  if (friendUid?.compareTo("-1") != 0) {
                                    if (!friendpd.friendList.contains(friendUid)) {
                                      if (mounted)
                                        setState(() {
                                          friendpd.friendList.add(friendUid!);
                                          box.put("FriendList", friendpd.friendList);
                                          loadData = friendPageLoad();
                                        });
                                      friendUid = '-1';
                                    } else {
                                      showToast("이미 추가된 친구입니다.", false);
                                    }
                                  }
                                },
                                child: Text(
                                  "친구 추가",
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: friendpd.friendList.length != 0
                                ? ListView.builder(
                                    itemCount: friendpd.friendList.length,
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
                                          friendpd.friendList.removeAt(index);
                                          box.put("FriendList", friendpd.friendList);
                                          loadData = friendPageLoad();
                                          showToast("해당 친구가 삭제되었습니다", true);
                                        },
                                        child: ListTile(
                                          leading: IconBundang(),
                                          title: StationName(
                                            stName: friendpd.friendData[index].station,
                                          ),
                                          subtitle: Text(
                                            friendpd.friendData[index].name,
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "좌측의 친구 추가 버튼을\n눌러서 친구 추가하기",
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(),
                                      SizedBox(),
                                    ],
                                  ),
                          ),
                        ],
                      ),
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

  Future<FriendPageData> friendPageLoad() async {
    FriendPageData data = new FriendPageData();
    var box = Hive.box("Preferences");
    // prefs.setStringList("FriendList", []);
    FriendData temp;
    data.autoTimer = box.get("AutoTimer")!;
    data.curTrainNo = box.get("CurrentTrain")!;
    data.visible = box.get("FriendFunc")!;
    data.uid = box.get("FriendCode")!;
    data.friendList = box.get("FriendList")!;
    // var result = await firestore.collection('CurrentLoc').doc("PWTp3yeU0onphMA6B6LU").get();
    // await firestore.collection("CurrentLoc").doc(uid.toString()).set(<String, int>{"ID" : uid, "TrainNo": curTrainNo});
    for (int i = 0; i < data.friendList.length; i++) {
      temp = new FriendData();
      try {
        var result = await firestore.collection('CurrentLoc').doc(data.friendList[i]).get();
        temp.trainNo = result["TrainNo"];
        temp.name = result["ID"];
        data.friendData.add(temp);
      } catch (e) {
        temp.trainNo = -1;
        temp.name = "잘못된 친구 코드입니다.";
        temp.station = "None";
        data.friendData.add(temp);
      }
    }
    data.cur = await GetCurrentLoc(data.curTrainNo, data.friendData);
    if (data.cur == "None") {
      data.cur = "지하철 탑승중이 아닙니다.";
      box.put("CurrentTrain", -1);
    }
    return data;
  }
}
