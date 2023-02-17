import 'package:find_my_subway/data/data_set.dart';
import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  final StationInform data;
  SearchItem({required this.data});
  @override

  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
      ),
      child: Text(data.kName,style: TextStyle(color:Color(0xffffffff)),)
    );
  }
}
