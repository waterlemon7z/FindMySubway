import 'package:find_my_subway/widgets/widget_appbar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars(titleName: "즐겨찾기"),
      backgroundColor: Color(0xff000000),
    );
  }
}
