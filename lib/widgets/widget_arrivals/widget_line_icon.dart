import 'package:flutter/material.dart';

class IconBundang extends StatelessWidget {
  const IconBundang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 24,
        backgroundColor: Color(0xffFABE00),
        child: Text(
          "수인\n분당",
          style: TextStyle(
            color: Color(0xffffffff),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
