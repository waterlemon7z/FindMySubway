String secToStr(int seconds) {
  String temp, rst;

  temp = (seconds % 60).toString() + "초";
  seconds = (seconds.toDouble() / 60.0).toInt();
  rst = temp;

  temp = (seconds % 60).toString() + "분 ";
  seconds = (seconds.toDouble() / 60.0).toInt();
  rst = temp + rst;

  temp = (seconds % 60).toString() + "시간 ";
  seconds = (seconds.toDouble() / 60.0).toInt();
  rst = temp + rst;

  return rst;
}

String secToEverageStr(List<String> times) {
  int total = 0;
  if (times.isEmpty) return "데이터 없음";
  for (int i = 0; i < times.length; i++) {
    total += int.parse(times[i]);
  }
  total = (total.toDouble() / times.length).toInt();
  return secToStr(total);
}
