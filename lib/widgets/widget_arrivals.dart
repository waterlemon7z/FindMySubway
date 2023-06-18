import 'package:find_my_subway/data/data_hive.dart';
import 'package:find_my_subway/data/userData.dart';
import 'package:find_my_subway/widgets/widget_arrivals/widget_line_icon.dart';
import 'package:find_my_subway/widgets/widget_arrivals/widget_new_detail.dart';
import 'package:find_my_subway/widgets/widget_arrivals/widget_new_station_name.dart';
import 'package:flutter/material.dart';

class Arrivals extends StatefulWidget {
  final Map lineIcons = {
    "Bundang": Padding(padding: const EdgeInsets.all(8.0), child: IconBundang()),
  };
  final UserData udata;
  final List<List<List<String>>> upNdownTrain;
  final List<int> comingTrainNo;
  final HiveProvider mainHive;
  final Map<String, List<String>> staInfo;

  Arrivals({required this.udata, required this.upNdownTrain, required this.mainHive, required this.staInfo, required this.comingTrainNo});

  @override
  State<Arrivals> createState() => _ArrivalsState();
}

class _ArrivalsState extends State<Arrivals> {
  @override
  Widget build(BuildContext context) {
    // print(widget.staInfo["K"+(widget.udata.id + 1).toString()]![0]);
    // print("K"+widget.udata.id.toString());
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          NewStationName(
            stName: widget.udata.stName,
            prevName: widget.udata.id + 1 < 273 ?widget.staInfo["K" + (widget.udata.id + 1).toString()]![0] : "X",
            nextName: widget.udata.id - 1 > 208 ? widget.staInfo["K" + (widget.udata.id - 1).toString()]![0] : "X",
          ),
          NewStaDetail(
            upNdownTrain: widget.upNdownTrain,
            comingTrainNo: widget.comingTrainNo,
          ),
        ],
      ),
    );
  }
}
