import 'package:flutter_jiandan/page/main/page_pic.dart';

class OoxxPage extends PicPage {
  @override
  String get apiPath {
    // ?oxwlxojflwblxbsapi=jandan.get_ooxx_comments&page=1
    return "jandan.get_ooxx_comments";
  }
}