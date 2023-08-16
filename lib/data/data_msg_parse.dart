String parseString(String original) {
  String rst, min;
  int idx;
  if (original.substring(0, 1) == '[') {
    rst = original.substring(1, 3);
    if (rst.substring(1, 2) == ']') {
      rst = rst.substring(0, 1);
    }
    rst += "전 " + original.substring(original.indexOf('('));
  } else {
    rst = original;
  }

  idx = rst.indexOf("분 ");
  if (idx != -1) {
    min = rst.substring(0, idx + 1);
    idx = rst.indexOf("후 ");
    rst =  min + rst.substring(idx + 1);
  }

  return rst;
}

String parseAheadString(String original) {
  String rst;
  if (original.indexOf("급") != -1) {
    rst = original.substring(0, original.indexOf("급") - 1) + '급';
  } else {
    rst = original;
  }
  if (original.indexOf("응암순환") != -1) {
    rst = "순환";
    }

  return rst;
}

int parseStationId(String str) {
  if (str[0] == 'K') {
    return int.parse("10750" + str.substring(1));
  } else if (str[0] == '1') {
    return int.parse("10010" + str);
  } else if (str[0] == '2') {
    return int.parse("10020" + str);
  } else if (str[0] == '3') {
    return int.parse("10030" + str);
  } else if (str[0] == '4') {
    return int.parse("10040" + str);
  } else if (str[0] == '5') {
    return int.parse("10050" + str);
  } else if (str[0] == '6') {
    return int.parse("10060" + str);
  } else if (str[0] == '7') {
    return int.parse("10070" + str);
  } else if (str[0] == '8') {
    return int.parse("10080" + str);
  }
  return 0;
}
