import 'package:flutter/material.dart';

class StaDetail extends StatefulWidget {
  @override
  final List<List<List<String>>> upNdownTrain;

  StaDetail({required this.upNdownTrain});

  State<StaDetail> createState() => _StaDetailState();
}
class _StaDetailState extends State<StaDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          for (int dir = 0; dir < 2; dir++)
            Container(
              width: (MediaQuery.of(context).size.width - 16) / 2,
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  for (int cur = 0; cur < widget.upNdownTrain[dir].length; cur++)
                    Row(
                      children: [
                        Text(
                          "${widget.upNdownTrain[dir][cur][0]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "행 ${widget.upNdownTrain[dir][cur][1]}",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  (widget.upNdownTrain[dir].length == 0
                      ? Text(
                          "정보 없음",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )
                      : SizedBox()),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
