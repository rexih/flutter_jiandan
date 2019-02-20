import 'package:flutter_jiandan/page/main/page_pic.dart';

class DuanPage extends PicPage {
  @override
  String get apiPath {
    // ?oxwlxojflwblxbsapi=jandan.get_duan_comments&page=1
    return "jandan.get_duan_comments";
  }
}