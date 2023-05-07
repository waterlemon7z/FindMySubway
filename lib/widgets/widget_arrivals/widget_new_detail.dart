import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_my_subway/widgets/widget_showToast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewStaDetail extends StatefulWidget {
  final List<List<List<String>>> upNdownTrain;
  final List<int> comingTrainNo;
  final SharedPreferences prefs;
  NewStaDetail({required this.upNdownTrain, required this.comingTrainNo, required this.prefs});

  @override
  State<NewStaDetail> createState() => _NewStaDetailState();
}

class _NewStaDetailState extends State<NewStaDetail> {
  @override
  final List<String> ahead = ["청량리", "인천"];
  final firestore = FirebaseFirestore.instance;
  late int uid;
  late int cur;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 0, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int dir = 0; dir < 2; dir++)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: GestureDetector(
                onLongPress: (){
                  if(widget.prefs.getBool("FriendFunc")!)
                    {
                      uid = widget.prefs.getInt("FriendCode")!;
                      cur = widget.comingTrainNo[dir];
                      firestore.collection("CurrentLoc").doc(uid.toString()).update(<String, dynamic>{"TrainNo": cur});
                    }
                  widget.prefs.setInt("CurrentTrain", widget.comingTrainNo[dir]);
                  showToast("해당 역으로 들어올 열차\n탑승완료", false);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  width: (MediaQuery.of(context).size.width - 36) / 2,

                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14.0,8,14,8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // textBaseline: TextBaseline.ideographic,
                          children: [
                            Text(
                              ahead[dir] + " 방면",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(),
                            // Icon(Icons.navigate_next,color: Colors.grey.shade300,),
                          ],
                        ),
                        Divider(),
                        for (int cur = 0; cur < widget.upNdownTrain[dir].length; cur++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.upNdownTrain[dir][cur][0]}",
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${widget.upNdownTrain[dir][cur][1]}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ],
                          ),
                        (widget.upNdownTrain[dir].length == 0
                            ? Text(
                                "정보 없음",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )
                            : SizedBox()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
