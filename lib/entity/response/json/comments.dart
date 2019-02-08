
class Comments {

  String comment_ID;
  String comment_post_ID;
  String comment_author;
  String comment_date;
  String comment_date_gmt;
  String comment_content;
  String user_id;
  String vote_positive;
  String vote_negative;
  String sub_comment_count;
  String text_content;
  List<String> pics;

  Comments.fromJsonMap(Map<String, dynamic> map): 
    comment_ID = map["comment_ID"],
    comment_post_ID = map["comment_post_ID"],
    comment_author = map["comment_author"],
    comment_date = map["comment_date"],
    comment_date_gmt = map["comment_date_gmt"],
    comment_content = map["comment_content"],
    user_id = map["user_id"],
    vote_positive = map["vote_positive"],
    vote_negative = map["vote_negative"],
    sub_comment_count = map["sub_comment_count"],
    text_content = map["text_content"],
    pics = List<String>.from(map["pics"]);

}
