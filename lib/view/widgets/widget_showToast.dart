import 'package:find_my_subway/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String msg, bool location) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: (FindMySubwayApp.themeNotifier.value == ThemeMode.light ? Colors.grey : Colors.white),
    toastLength: Toast.LENGTH_SHORT,
    gravity: (location ? ToastGravity.BOTTOM_RIGHT : ToastGravity.TOP),
    textColor: Colors.black,
  );
}
