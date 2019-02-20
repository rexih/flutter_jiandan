import 'package:flutter/material.dart';
import 'package:flutter_jiandan/widget/pic_item_adapter.dart';
import 'package:flutter_jiandan/entity/response/json/resp_get_pic_comments.dart';
import 'package:flutter_jiandan/network/http_manager.dart';

class PicPage extends StatefulWidget {
  String apiPath = "jandan.get_pic_comments";

  PicPage({Key key}) : super(key: key); //initData

  @override
  State<StatefulWidget> createState() => _PicPageState(apiPath);
}

class _PicPageState extends State<PicPage> {
  String apiPath;
  String info;
  ScrollController _onPullUpListener;
  PicItemAdapter adapter;

  bool _isLoaded = false;
  int _pageNo = 1;

  _PicPageState(this.apiPath) {
    print(apiPath);
  }

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
    return /*Scaffold(
        appBar:
            AppBar(backgroundColor: Color(0xFFFFE57B), title: Text("煎蛋 无聊图")),
        body:*/
        _isLoaded
            ? RefreshIndicator(
                color: Color(0xFFFFE57B),
                child: _bindListUi(context),
                onRefresh: _onPullDown)
            : Center(child: Text("加载中"));
  }

  Widget _bindListUi(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: _onPullUpListener,
      itemCount: adapter.itemCount,
      itemBuilder: adapter.onBindView,
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
      var response = await getDio().get("https://i.jandan.net/", queryParameters: {
        "oxwlxojflwblxbsapi": apiPath,
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
      //TODO 错误页面
      print(e);
    }
  }
}


