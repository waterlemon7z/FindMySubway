import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:find_my_subway/entity/UserSubwayDataEntity.dart';

bool verifySearchData(UserSubwayDataEntity data, List<UserSubwayDataEntity> addList) {
  for(UserSubwayDataEntity iter in addList)
    {
      if(iter.id==data.id) {
      return false;
    }
  }
  return true;
}
