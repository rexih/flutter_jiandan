import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jiandan/entity/response/json/comment.dart';

class PicItemAdapter {
  List<Comments> dataSet = <Comments>[];

  PicItemAdapter({this.dataSet});

  int get itemCount => dataSet.length;

  Widget onBindView(BuildContext context, int index) {
    Comments data = dataSet[index];

    var timeline = TimelineUtil.formatByDateTime(
        DateTime.tryParse(data.comment_date) ?? DateTime.now(),
        locale: 'zh');

    var noTextContent =
    ((null == data.text_content) || (data.text_content.trim().isEmpty));
    var noLink = ((null == data.parent_title) || (data.parent_title.trim().isEmpty));

    return Container(
        margin: EdgeInsets.all(6),
        child: Card(
            child: Padding(
                padding: EdgeInsets.fromLTRB(6, 16, 6, 16),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(data.comment_author,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                                fontWeight: FontWeight.bold)),
                        Text("@${timeline}",
                            style: TextStyle(
                              color: Colors.blueGrey,
                            )),
                      ],
                    ),
                    Offstage(
                      offstage: noTextContent,
                      child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            data.text_content.trim(),
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.start,
                          )),
                    ),
                    Divider(height: 8, color: Colors.transparent),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          foregroundDecoration: BoxDecoration(
                            //边框弧度
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                //边框颜色
                                color: Color(0xFF607D8B),
                                //边框粗细
                                width: 1,
                              )),
                          child: ListView.builder(
                            // 防止viewport错误找不到高度抛出异常
                              shrinkWrap: true,
                              // 禁止嵌套滚动
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                              null == data.pics ? 0 : data.pics.length,
                              itemBuilder: (context, picIndex) {
                                return CachedNetworkImage(
                                  fit: BoxFit.contain,
                                  imageUrl: data.pics[picIndex] ?? "",
                                  placeholder: Image.asset(
                                      'assets/images/gif_loading_chicken.gif'),
                                  errorWidget: Image.asset(
                                      'assets/images/gif_loading_chicken.gif'),
                                );
//                                return FadeInImage.assetNetwork(
//                                    fit: BoxFit.contain,
//                                    placeholder: 'assets/images/gif_loading_chicken.gif',
//                                    image: data.pics[picIndex] ?? "");
                              }),
                        )),
                    Offstage(
                      offstage: noLink,
                      child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          padding: EdgeInsets.all(16),
                          color: Color(0xffeeeeee),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.link),
                              Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    data.parent_title ?? "",
                                    style: TextStyle(
                                        fontSize: 16,
                                        decoration: TextDecoration.underline),
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          )),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text.rich(TextSpan(
                                text: 'OO',
                                style: new TextStyle(
                                  color: Colors.red,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "[${data.vote_positive}]",
                                      style: new TextStyle(
                                        color: Colors.black,
                                      ))
                                ])),
                            Text.rich(TextSpan(
                                text: 'XX',
                                style: new TextStyle(
                                  color: Colors.lightBlue,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "[${data.vote_negative}]",
                                      style: new TextStyle(
                                        color: Colors.black,
                                      ))
                                ])),
                            Text("吐槽[${data.vote_negative}]"),
                            Icon(
                              Icons.share,
                              size: 16,
                              color: Color(0x66000000),
                            )
                          ],
                        ))
                  ],
                ))));
  }
}