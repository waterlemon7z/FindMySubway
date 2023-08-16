import 'package:analyzer_plugin/utilities/pair.dart';

bool verifySearchData(Pair<String, String> data, List<Pair<String, String>> addList)
{
    if(!addList.contains(data))
    {
      return true;
    }
  return false;

}
