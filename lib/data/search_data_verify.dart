import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:find_my_subway/entity/UserSubwayDataEntity.dart';

bool verifySearchData(Pair<String, String> data, List<UserSubwayDataEntity> addList) {
  if (!addList.contains(data)) {
    return true;
  }
  return false;
}
