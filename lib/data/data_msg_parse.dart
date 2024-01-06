String parseString(String original, String where) {
  String rst, min;
  if (where.length > 5) {
    where = where.substring(0, 6);
  }
  if (original.substring(0, 1) == '[') {
    rst = original.substring(1, 3);
    if (rst.substring(1, 2) == ']') {
      rst = rst.substring(0, 1);
    }
    rst += "전 ${original.substring(original.indexOf(')') + 1)}${where}";
  } else if (original.contains("분")) {
    min = original.substring(0, original.indexOf("분") + 1);
    rst = '$min $where';
    // idx = rst.indexOf("후 ");
    // rst =  min + rst.substring(idx + 1)
  } else {
    rst = original;
  }
  return rst;
}

String parseAheadString(String original) {
  String rst;
  if (original.contains("특급")) {
    rst = '${original.substring(0, original.indexOf("특급") - 1)}특급';
  } else if (original.contains("급")) {
    rst = '${original.substring(0, original.indexOf("급") - 1)}급';
  } else if (original.contains("응암순환")) {
    rst = "순환";
  } else if (original.contains("(막차)")) {
    rst = '${original.substring(0, original.indexOf("("))}막';
  } else {
    rst = original;
  }
  return rst;
}

int parseStationId(String str) {
  if (str.contains("K2")) {
    return int.parse("10750${str.substring(1)}");
  } else if (str[0] == 'D') {
    return int.parse("10770${str.substring(1)}"); //신분
  } else if (str.contains("K1")) {
    //경의 중앙
    return int.parse("10630${str.substring(1)}");
  } else if (str.contains("K3")) {
    //경의 중앙
    return int.parse("10630${str.substring(1)}");
  } else if (str.contains("K4")) {
    //경강
    return int.parse("10810${str.substring(1)}");
  } else if (str.contains("P1")) {
    str = str.substring(1);
    if (int.parse(str) >= 142)
      return int.parse("10011$str"); //1호선
    else
      return int.parse("10670$str"); //경춘
  } else if (str[0] == '1') {
    return int.parse("10010$str");
  } else if (str[0] == '0' && str[1] == '9') {
    return int.parse("10010$str");
  } else if (str[0] == '2') {
    return int.parse("10020$str");
  } else if (str[0] == '3') {
    return int.parse("10030$str");
  } else if (str[0] == '4') {
    return int.parse("10040$str");
  } else if (str[0] == '5') {
    return int.parse("10050$str");
  } else if (str.contains("P5")) {
    str = str.substring(1);
    return int.parse("10051$str");
  } else if (str[0] == '6') {
    return int.parse("10060$str");
  } else if (str[0] == '7') {
    return int.parse("10070$str");
  } else if (str[0] == '8') {
    return int.parse("10080$str");
  }
  return 0;
}
