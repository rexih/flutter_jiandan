import 'package:flutter/material.dart';
import 'package:flutter_jiandan/entity/response/json/resp_hot.dart';
import 'package:flutter_jiandan/widget/pic_item_adapter.dart';
import 'package:flutter_jiandan/entity/response/json/resp_get_pic_comments.dart';
import 'package:flutter_jiandan/network/http_manager.dart';

class HotPage extends StatefulWidget {
  String apiParam = "recent";

  HotPage(this.apiParam, {Key key}) : super(key: key); //initData

  @override
  State<StatefulWidget> createState() => _HotPageState(apiParam);
}

class _HotPageState extends State<HotPage> {
  String apiParam;
  String info;
  ScrollController _onPullUpListener;
  PicItemAdapter adapter;

  bool _isLoaded = false;

  _HotPageState(this.apiParam) {
    print(apiParam);
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

  void _initListener() {}

  /// 下拉的回调处理
  /// 注意RefreshIndicator的回调函数的声明，注意返回值要一致
  Future<void> _onPullDown() async {
    requestPicList();
  }

  @override
  Widget build(BuildContext context) {
    //initAnim
    //initUi
    //在build中update UI
    return _isLoaded
        ? RefreshIndicator(
            color: Color(0xFFFFE57B),
            child: _bindListUi(context),
            onRefresh: _onPullDown)
        : Center(child: Text("加载中"));
  }

  Widget _bindListUi(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: adapter.itemCount,
      itemBuilder: adapter.onBindView,
    );
  }

  requestPicList() async {
    // 拉取请求
    try {
      //http://api.moyu.today/jandan/hot?category=recent
      var response = await getDio()
          .get("http://api.moyu.today/jandan/hot", queryParameters: {
        "category": apiParam,
//        "page": _pageNo.toString()
      });

      print(response.data);

      var resp = RespHot.fromJsonMap(response.data);
      setState(() {
        _isLoaded = true;
        adapter.dataSet = resp.comments;
      });
    } catch (e) {
      //TODO 错误页面
      print(e);
    }
  }
}
