String parseString(String original){
  String rst;
  if(original.substring(0,1) =='[')
    {
      rst = original.substring(1,3);
      if(rst.substring(1,2) ==']')
        {
          rst = rst.substring(0,1);
        }
      rst += "전 " + original.substring(original.indexOf('('));
    }
  else
    rst = original;
  return rst;
}

String parseAheadString(String original)
{
  String rst;
  if(original.indexOf("급") != -1)
    {
      rst = original.substring(0,original.indexOf("급") - 1) + '급';
    }
  else
    {
      rst = original;
    }
  return rst;
}
