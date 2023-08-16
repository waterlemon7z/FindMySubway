import 'package:find_my_subway/data/data_set.dart';
import 'package:find_my_subway/main.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SubwayLocationInfo extends StatelessWidget {
  late final List<StationInform> stData;
  late int curSt;
  late final Map<String, Map<int, StArrivalInfo>> stStatus;
  String subwayIcon = MyApp.themeNotifier.value == ThemeMode.light ? "subway" : "subway_white";

  SubwayLocationInfo(
      List<StationInform> stData, int curSt,Map<String, Map<int, StArrivalInfo>> stStatus) {
    this.stData = stData;
    this.curSt = curSt;
    this.stStatus = stStatus;
    if (this.curSt > 268) {
      this.curSt--;
    }
    this.curSt -= 209;
  }

  bool checkValidity(int i, String direction, String forState) {
    if (stStatus[direction]![curSt + 209 + i] == null || curSt + i < 0 || curSt + i > 62)
      return false;
    else if (stStatus[direction]![curSt + 209 + i]!.arrival == forState) return true;
    return false;
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        children: [
          Row(
            children: [
              for (int i = 3; i >= 0; i--)
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          child: Image.asset(
                            "assets/$subwayIcon.png",
                            width: MediaQuery.of(context).size.width / 11,
                          ),
                          visible: checkValidity(i, "up", "0"),
                          // 접근
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                        ),
                        Visibility(
                          child: Image.asset(
                            "assets/$subwayIcon.png",
                            width: MediaQuery.of(context).size.width / 11,
                          ),
                          visible: checkValidity(i, "up", "1"),
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 20,
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NormalLine(),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: Colors.grey,
                          size: 22,
                        ),
                        NormalLine(),
                      ],
                    ),
                    Text(
                      curSt + i < 0 || curSt + i > 62 ? "X" : stData[curSt + i].kName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              for (int i = 0; i < 4; i++)
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 20,
                        ),
                        Visibility(
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: Image.asset(
                              "assets/$subwayIcon.png",
                              width: MediaQuery.of(context).size.width / 11,
                            ),
                          ),
                          visible: checkValidity(i * (-1), "down", "1"),
                          // 도착
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                        ),
                        Visibility(
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: Image.asset(
                              "assets/$subwayIcon.png",
                              width: MediaQuery.of(context).size.width / 11,
                            ),
                          ),
                          visible: checkValidity(i * (-1), "down", "0"),
                          // 접근
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NormalLine(),
                        Icon(
                          Icons.navigate_before_rounded,
                          color: Colors.grey,
                          size: 22,
                        ),
                        NormalLine(),
                      ],
                    ),
                    Text(
                      curSt - i < 0 || curSt - i > 62 ? "X" : stData[curSt - i].kName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          )
        ],
      ),
    );
  }
}

class NormalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.centerLeft,
      color: Colors.grey,
      height: 2,
      width: MediaQuery.of(context).size.width / 11,
    );
  }
}