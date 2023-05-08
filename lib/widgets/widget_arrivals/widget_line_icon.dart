import 'package:flutter/material.dart';

class IconBundang extends StatelessWidget {
  const IconBundang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
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
    );
  }
}

class SmallBundangIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 10,
      backgroundColor: Color(0xffFABE00),
      child:const Text(
        "수",
        style: TextStyle(
          color: Color(0xffffffff),
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}
