import 'package:flutter_jiandan/entity/response/json/comments.dart';

class RespGetPicComments {

  String status;
  int current_page;
  int total_comments;
  int page_count;
  int count;
  List<Comments> comments;

  RespGetPicComments.fromJsonMap(Map<String, dynamic> map): 
    status = map["status"],
    current_page = map["current_page"],
    total_comments = map["total_comments"],
    page_count = map["page_count"],
    count = map["count"],
    comments = List<Comments>.from(map["comments"].map((it) => Comments.fromJsonMap(it)));

}
