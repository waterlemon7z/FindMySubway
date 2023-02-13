import 'package:find_my_subway/widgets/widget_appbar.dart';
import 'package:flutter/material.dart';

class OptionPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars(titleName: "설정"),
      backgroundColor: Color(0xff000000),
    );
  }
}
