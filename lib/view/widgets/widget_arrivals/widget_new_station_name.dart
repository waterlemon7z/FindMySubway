import 'package:find_my_subway/view/widgets/widget_arrivals/widget_line_icon.dart';
import 'package:flutter/material.dart';

class NewStationName extends StatelessWidget {
  final String stName;
  final String prevName;
  final String nextName;
  final String line;

  NewStationName({required this.stName, required this.prevName, required this.nextName, required this.line});

  @override
  Widget build(BuildContext context) {
    StatelessWidget lineSmallIcon = LineIcon.icons[line + "small"]!;
    Color lineColor = LineIcon.colors[line]!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 7.5, 0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              decoration: BoxDecoration(
                color: lineColor,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.navigate_before,
                          color: Color(0xffffffff),
                        ),
                        Text(
                          prevName,
                          style: const TextStyle(color: Color(0xffffffff)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          nextName,
                          style: const TextStyle(
                            color: Color(0xffffffff),
                          ),
                        ),
                        const Icon(
                          Icons.navigate_next,
                          color: Color(0xffffffff),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 150,
              height: 45,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(40.0),
                border: Border.all(
                  color: lineColor,
                  width: 4,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  lineSmallIcon,
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    stName,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
