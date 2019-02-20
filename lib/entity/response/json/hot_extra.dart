
class HotExtra {

  /// 标记热门的类型
  String category_type;
  String page_num;

  HotExtra.fromJsonMap(Map<String, dynamic> map):
    category_type = map["category_type"],
    page_num = map["page_num"];

}
