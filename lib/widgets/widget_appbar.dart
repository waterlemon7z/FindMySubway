import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:find_my_subway/data/get_data.dart';

class Appbars extends StatelessWidget with PreferredSizeWidget {
  final String titleName;

  Appbars({required this.titleName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff000000),
      centerTitle: false,
      elevation: 0,
      title: Text(
        titleName,
        style: TextStyle(
          color: Color(0xffffffff),
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

Future<List<String>> getAllStationName() async {
  Map <String, String> stationInfo = {};
  String apikey = "49647777496c656d39304a6d717744";
  // String apikey = "sample";
  Network net = Network("http://openapi.seoul.go.kr:8088/$apikey/json/SearchSTNBySubwayLineInfo/1/100/ / /수인분당선");
  var fetchData = await net.getJsonData();
  for (int i = 0; i < fetchData["SearchSTNBySubwayLineInfo"]["row"].length; i++) {
    stationInfo[fetchData["SearchSTNBySubwayLineInfo"]["row"][i]["FR_CODE"]] = fetchData["SearchSTNBySubwayLineInfo"]["row"][i]["STATION_NM"];
  }
  stationInfo = Map.fromEntries(
      stationInfo.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
  print(stationInfo.values.toList());
  return stationInfo.values.toList();
}

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
  final List<String> addedStation;

  SearchAppBar({required this.addedStation});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  @override
  String searchValue = '';

  Widget build(BuildContext context) {
    return EasySearchBar(
      title: Text(
        "즐겨찾는 지하철 역",
        style: TextStyle(
          color: Color(0xffffffff),
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      iconTheme: IconThemeData(
        color: Color(0xffffffff),
      ),
      searchTextStyle: TextStyle(
        color: Color(0xffffffff),
      ),
      elevation: 0,
      onSearch: (value) => setState(() {}),
      asyncSuggestions: (value) async => await getAllStationName(),
      backgroundColor: Color(0xff000000),
    );
  }
}
