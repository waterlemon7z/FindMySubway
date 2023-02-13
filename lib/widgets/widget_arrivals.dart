import 'package:find_my_subway/widgets/widget_arrivals/widget_detail_of_station.dart';
import 'package:find_my_subway/widgets/widget_arrivals/widget_line_icon.dart';
import 'package:find_my_subway/widgets/widget_arrivals/widget_station_name.dart';
import 'package:flutter/material.dart';

class Arrivals extends StatefulWidget {
  final Map lineIcons = {
    "Bundang": IconBundang(),
  };
  final station;
  final List<List<List<String>>> upNdownTrain;
  Arrivals({required this.station, required this.upNdownTrain});

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
          Row(
            children: [
              widget.lineIcons["Bundang"],
              StationName(
                stName: '${widget.station}역',
              ),
            ],
          ),
          StaDetail(
            upNdownTrain: widget.upNdownTrain,
          ),
        ],
      ),
      // color: Color(0xff555555),
    );
  }
}
