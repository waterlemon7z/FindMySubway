import 'package:flutter/material.dart';

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
