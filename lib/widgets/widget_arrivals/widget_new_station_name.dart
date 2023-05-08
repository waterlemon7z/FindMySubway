import 'package:find_my_subway/widgets/widget_arrivals/widget_line_icon.dart';
import 'package:flutter/material.dart';

class NewStationName extends StatelessWidget {
  final String stName;
  final String prevName;
  final String nextName;

  NewStationName({required this.stName, required this.prevName, required this.nextName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 7.5, 0, 0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.navigate_before,
                          color: Color(0xffffffff),
                        ),
                        Text(
                           prevName,
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          nextName == null ? "X" : nextName,
                          style: TextStyle(
                            color: Color(0xffffffff),
                          ),
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: Color(0xffffffff),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: 30,
              decoration: BoxDecoration(
                color: Color(0xffFABE00),
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
          ),
          Center(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SmallBundangIcon(),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    stName,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),
                  ),
                ],
              ),
              width: 150,
              height: 45,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(40.0),
                border: Border.all(
                  color: Color(0xffFABE00),
                  width: 4,
                ),
                /*boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ]),*/
              ),
            ),
          ),
        ],
      ),
    );
  }
}
