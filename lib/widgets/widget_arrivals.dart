import 'package:find_my_subway/data/database.dart';
import 'package:find_my_subway/data/get_data.dart';
import 'package:find_my_subway/pages/page_favorite.dart';
import 'package:find_my_subway/widgets/widget_arrivals/widget_detail_of_station.dart';
import 'package:find_my_subway/widgets/widget_arrivals/widget_line_icon.dart';
import 'package:find_my_subway/widgets/widget_arrivals/widget_station_name.dart';
import 'package:find_my_subway/widgets/widget_showToast.dart';
import 'package:flutter/material.dart';

class Arrivals extends StatefulWidget {
  final Map lineIcons = {
    "Bundang": Padding(padding: const EdgeInsets.all(8.0), child: IconBundang()),
  };
  final UserData udata;
  final List<List<List<String>>> upNdownTrain;
  final UsrDataProvider myDb;
  Arrivals({required this.udata, required this.upNdownTrain, required this.myDb});

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  widget.lineIcons["Bundang"],
                  StationName(
                    stName: '${widget.udata.stName}역',
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,20,0),
                child: IconButton(
                  icon : Icon(Icons.delete_forever),
                  // color: Color(0xffffffff),
                  onPressed: (){
                    widget.myDb.delete(UserData(id: widget.udata.id, stName: widget.udata.stName));
                    FavoritePageState? parent = context.findAncestorStateOfType<FavoritePageState>();
                    parent!.setState(() {
                      parent.infoList =  getSubwayInfo(widget.myDb);
                    });
                    showToast("삭제되었습니다", true);
                  },
                ),
              ),
            ],
          ),
          StaDetail(
            upNdownTrain: widget.upNdownTrain,
          ),
        ],
      ),
    );
  }
}
