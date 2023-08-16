import 'package:find_my_subway/data/data_hive.dart';
import 'package:find_my_subway/data/data_set.dart';
import 'package:find_my_subway/data/userData.dart';
import 'package:find_my_subway/widgets/widget_arrivals/widget_line_icon.dart';
import 'package:find_my_subway/widgets/widget_arrivals/widget_new_detail.dart';
import 'package:find_my_subway/widgets/widget_arrivals/widget_new_station_name.dart';
import 'package:flutter/material.dart';

class Arrivals extends StatefulWidget {
  final Map lineIcons = {
    "Bundang": Padding(padding: const EdgeInsets.all(8.0), child: IconBundang()),
  };
  final RealTimeEachStationArrival curStationInfo;
  final HiveProvider mainHive;
  Arrivals({required this.curStationInfo, required this.mainHive});

  @override
  State<Arrivals> createState() => _ArrivalsState();
}

class _ArrivalsState extends State<Arrivals> {
  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          NewStationName(
            stName: widget.curStationInfo.kName,
            prevName: widget.curStationInfo.prevName,
            nextName: widget.curStationInfo.nextName,
            line : widget.curStationInfo.line,
          ),
          NewStaDetail(
            curStationInfo: widget.curStationInfo,
          ),
        ],
      ),
    );
  }
}
