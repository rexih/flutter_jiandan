import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';
import 'package:transparent_image/transparent_image.dart'
    show kTransparentImage;
import 'package:flutter_jiandan/entity/response/json/comments.dart';
import 'package:flutter_jiandan/entity/response/json/resp_get_pic_comments.dart';
import 'package:flutter_jiandan/network/http_manager.dart';

class PicPage extends StatefulWidget {
  PicPage({Key key}) : super(key: key); //initData

  @override
  State<StatefulWidget> createState() => _PicPageState();
}

class _PicPageState extends State<PicPage> {
  String info;
  ScrollController _onPullUpListener;
  PicItemAdapter adapter;

  bool _isLoaded = false;
  int _pageNo = 1;

  @override
  void initState() {
    super.initState();
    // 在initState里进行组件和监听器的初始化
    _initUi();
    _initListener();
    requestPicList();
  }

  void _initUi() {
    adapter = PicItemAdapter();
  }

  void _initListener() {
    _onPullUpListener = ScrollController()
      ..addListener(() {
        if (isListViewEnd(_onPullUpListener)) {
          // 处理上拉
          _onPullUp();
        }
      });
  }

  /// 下拉的回调处理
  /// 注意RefreshIndicator的回调函数的声明，注意返回值要一致
  Future<void> _onPullDown() async {
    _pageNo = 1;
    requestPicList();
  }

  /// 上拉的回调处理
  Future<void> _onPullUp() async {
    _pageNo++;
    requestPicList();
  }

  @override
  Widget build(BuildContext context) {
    //initAnim
    //initUi
    //在build中update UI
    return Scaffold(
        appBar: AppBar(title: Text("煎蛋 无聊图")),
        body: _isLoaded
            ? RefreshIndicator(
                child: _bindListUi(context), onRefresh: _onPullDown)
            : Center(child: Text("加载中")));
  }

  Widget _bindListUi(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: adapter.itemCount,
      itemBuilder: adapter.onBindView,
      controller: _onPullUpListener,
    );
  }

  bool isListViewEnd(ScrollController _onScrollListener) {
    var bottomOffset = _onScrollListener.position.maxScrollExtent;
    var currentOffset = _onScrollListener.position.pixels;
    return currentOffset >= bottomOffset;
  }

  requestPicList() async {
    // 拉取请求
    try {
      var response = await getDio().get("/", queryParameters: {
        "oxwlxojflwblxbsapi": "jandan.get_pic_comments",
        "page": _pageNo.toString()
      });

      print(response.data);

      var resp = RespGetPicComments.fromJsonMap(response.data);
      setState(() {
        _isLoaded = true;
        if (1 == _pageNo) {
          adapter.dataSet = resp.comments;
        } else {
          adapter.dataSet.addAll(resp.comments);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}

class PicItemAdapter {
  List<Comments> dataSet = <Comments>[];

  PicItemAdapter({this.dataSet});

  int get itemCount => dataSet.length;

  Widget onBindView(BuildContext context, int index) {
    Comments data = dataSet[index];

    var timeline = TimelineUtil.formatByDateTime(
        DateTime.tryParse(data.comment_date) ?? DateTime.now(),
        locale: 'zh');

    var offstage = (null==data.text_content||data.text_content.isEmpty);
    print(">>>offstage:${offstage}:content:${data.text_content}");
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
//                    Divider(height: 1,color: Colors.black),

                    Offstage(
                      offstage: offstage,
                      child: Container(
                          alignment: Alignment.centerLeft,
//                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            data.text_content,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.start,
                          )),
                    ),
//                    Divider(height: 1,color: Colors.red),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          foregroundDecoration: BoxDecoration(
                              //边框弧度
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                //边框颜色
                                color: Colors.blueGrey,
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
                                return FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: data.pics[picIndex] ?? "");
                              }),
                        )),
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
                            Icon(Icons.share, size: 16)
                          ],
                        ))
                  ],
                ))));
  }
}
