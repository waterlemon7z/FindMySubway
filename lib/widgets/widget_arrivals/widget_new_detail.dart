// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:find_my_subway/data/data_set.dart';
import 'package:find_my_subway/widgets/widget_showToast.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NewStaDetail extends StatefulWidget {
  final RealTimeEachStationArrival curStationInfo;
  // final List<int> comingTrainNo;
  NewStaDetail({required this.curStationInfo/*, required this.comingTrainNo*/});

  @override
  State<NewStaDetail> createState() => _NewStaDetailState();
}

class _NewStaDetailState extends State<NewStaDetail> {

  // final firestore = FirebaseFirestore.instance;
  // late int uid;
  late int cur;
  var box = Hive.box("Preferences");
  Widget build(BuildContext context) {
    final List<String> ahead = widget.curStationInfo.ahead;
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 0, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailBox(ahead: ahead[0], detailList: widget.curStationInfo.up),
          DetailBox(ahead: ahead[1], detailList: widget.curStationInfo.down),
        ],
      ),
    );
  }
}

class DetailBox extends StatelessWidget {
  const DetailBox({Key? key, required this.ahead, required this.detailList}) : super(key: key);
  final String ahead;
  final List<Pair<String, String>> detailList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
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
        child: Padding( ////
          padding: const EdgeInsets.fromLTRB(14.0,8,14,8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                // textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    ahead + " 방면",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(),
                  // Icon(Icons.navigate_next,color: Colors.grey.shade300,),
                ],
              ),
              Divider(),
              for (int cur = 0; cur < detailList.length; cur++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${detailList[cur].first}",
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "${detailList[cur].last}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              (detailList.length == 0
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
    );
  }
}

