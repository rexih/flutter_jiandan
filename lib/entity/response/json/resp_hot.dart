import 'package:flutter_jiandan/entity/response/json/comment.dart';

class RespHot {

  String status;
  List<Comments> comments;

  RespHot.fromJsonMap(Map<String, dynamic> map): 
    status = map["status"],
    comments = List<Comments>.from(map["comments"].map((it) => Comments.fromJsonMap(it)));

}
