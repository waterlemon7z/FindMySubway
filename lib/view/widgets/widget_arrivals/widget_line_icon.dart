import 'package:flutter/material.dart';

class LineIcon {
  static Map<String, StatelessWidget> icons = {
    //Todo: Icon/Color Set
    "Line1": IconOriginal(text: "1", iconFontSize: 35, lineColor: colors["Line1"]!),
    "Line1small": IconSmall(text: "1", iconFontSize: 13, lineColor: colors["Line1"]!),
    "Line2": IconOriginal(text: "2", iconFontSize: 35, lineColor: colors["Line2"]!),
    "Line2small": IconSmall(text: "2", iconFontSize: 13, lineColor: colors["Line2"]!),
    "Line3": IconOriginal(text: "3", iconFontSize: 35, lineColor: colors["Line3"]!),
    "Line3small": IconSmall(text: "3", iconFontSize: 13, lineColor: colors["Line3"]!),
    "Line4": IconOriginal(text: "4", iconFontSize: 35, lineColor: colors["Line4"]!),
    "Line4small": IconSmall(text: "4", iconFontSize: 13, lineColor: colors["Line4"]!),
    "Line5": IconOriginal(text: "5", iconFontSize: 35, lineColor: colors["Line5"]!),
    "Line5small": IconSmall(text: "5", iconFontSize: 13, lineColor: colors["Line5"]!),
    "Line6": IconOriginal(text: "6", iconFontSize: 35, lineColor: colors["Line6"]!),
    "Line6small": IconSmall(text: "6", iconFontSize: 13, lineColor: colors["Line6"]!),
    "Line7": IconOriginal(text: "7", iconFontSize: 35, lineColor: colors["Line7"]!),
    "Line7small": IconSmall(text: "7", iconFontSize: 13, lineColor: colors["Line7"]!),
    "Line8": IconOriginal(text: "8", iconFontSize: 35, lineColor: colors["Line8"]!),
    "Line8small": IconSmall(text: "8", iconFontSize: 13, lineColor: colors["Line8"]!),
    "Line9": IconOriginal(text: "9", iconFontSize: 35, lineColor: colors["Line9"]!),
    "Line9small": IconSmall(text: "9", iconFontSize: 13, lineColor: colors["Line9"]!),
    "LineBundang": IconOriginal(text: "수인\n분당", iconFontSize: 15, lineColor: colors["LineBundang"]!),
    "LineBundangsmall": IconSmall(text: "수", iconFontSize: 13, lineColor: colors["LineBundang"]!),
    "LineShinBundang": IconOriginal(text: "신분당", iconFontSize: 15, lineColor: colors["LineShinBundang"]!),
    "LineShinBundangsmall": IconSmall(text: "신", iconFontSize: 13, lineColor: colors["LineShinBundang"]!),
    "LineGyeongui": IconOriginal(text: "경의\n중앙", iconFontSize: 15, lineColor: colors["LineGyeongui"]!),
    "LineGyeonguismall": IconSmall(text: "경", iconFontSize: 13, lineColor: colors["LineGyeongui"]!),
    "LineGyeongchun": IconOriginal(text: "경춘", iconFontSize: 19, lineColor: colors["LineGyeongchun"]!),
    "LineGyeongchunsmall": IconSmall(text: "경", iconFontSize: 13, lineColor: colors["LineGyeongchun"]!),
    "LineGyeonggang": IconOriginal(text: "경강", iconFontSize: 19, lineColor: colors["LineGyeonggang"]!),
    "LineGyeonggangsmall": IconSmall(text: "경", iconFontSize: 13, lineColor: colors["LineGyeonggang"]!),
  };
  static Map<String, Color> colors = {
    "Line1": Color(0xff0052A4),
    "Line2": Color(0xff00A84D),
    "Line3": Color(0xffEF7C1C),
    "Line4": Color(0xff00A4E3),
    "Line5": Color(0xff996CAC),
    "Line6": Color(0xffCD7C2F),
    "Line7": Color(0xff747F00),
    "Line8": Color(0xffE6186C),
    "Line9": Color(0xffBDB092),
    "LineBundang": Color(0xffFABE00),
    "LineShinBundang": Color(0xffD31145),
    "LineGyeongui": Color(0xff77C4A3),
    "LineGyeongchun": Color(0xff178C72),
    "LineGyeonggang": Color(0xff0054A6),
  };
}

class IconOriginal extends StatelessWidget {
  final String text;
  final double iconFontSize;
  final Color lineColor;

  const IconOriginal({super.key, required this.text, required this.iconFontSize, required this.lineColor});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: lineColor,
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xffffffff),
          fontWeight: FontWeight.bold,
          fontSize: iconFontSize,
        ),
      ),
    );
  }
}

class IconSmall extends StatelessWidget {
  final String text;
  final double iconFontSize;
  final Color lineColor;

  const IconSmall({super.key, required this.text, required this.iconFontSize, required this.lineColor});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 10,
      backgroundColor: lineColor,
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xffffffff),
          fontWeight: FontWeight.bold,
          fontSize: iconFontSize,
        ),
      ),
    );
  }
}

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
      child: const Text(
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

class Icon1 extends StatelessWidget {
  const Icon1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: Color(0xff0052A4),
      child: Text(
        "1",
        style: TextStyle(
          color: Color(0xffffffff),
          fontWeight: FontWeight.bold,
          fontSize: 35,
        ),
      ),
    );
  }
}

class Small1Icon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 10,
      backgroundColor: Color(0xff0052A4),
      child: const Text(
        "1",
        style: TextStyle(
          color: Color(0xffffffff),
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}
