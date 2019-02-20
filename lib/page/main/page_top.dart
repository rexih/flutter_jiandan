import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jiandan/page/main/page_pic.dart';
import 'package:flutter_jiandan/page/top/page_hot.dart';

class TopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TopPageState();
  }
}

class _TopPageState extends State<TopPage> with SingleTickerProviderStateMixin {
  int _curIndex = 0;
  List<Tab> _tabs = [];
  List<String> _titles = [];
  TabController _tabController;
  var _pageController;
  TopChannelAdapter adapter;

  @override
  void initState() {
    super.initState();
    _initUi();
    _initListener();
  }

  void _initUi() {
    _tabs = <Tab>[
      Tab(text: "4小时"),
//      Tab(text: "吐槽"),
      Tab(text: "无聊图"),
      Tab(text: "随手拍"),
      Tab(text: "段子"),
      Tab(text: "优评"),
      Tab(text: "7日"),
    ];
    _titles = _tabs.map((Tab tab) {
      return tab.text;
    }).toList();

    adapter = TopChannelAdapter(_titles);
  }

  void _initListener() {
    _tabController = TabController(length: _tabs.length, vsync: this)
      ..addListener(() {
        var latestIndex = _tabController.index;
        _pageController.jumpToPage(latestIndex);
        setState(() {
          if (_curIndex != latestIndex) {
            _curIndex = latestIndex;
          }
        });
      });
    _pageController = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          padding: EdgeInsets.only(bottom: 8),
          child: TabBar(
              isScrollable: true, controller: _tabController, tabs: _tabs),
        ),
        Expanded(
            child: PageView.builder(
          controller: _pageController,
          onPageChanged: (int index) {
            _tabController.animateTo(index);
            setState(() {
              if (_curIndex != index) {
                _curIndex = index;
              }
            });
          },
          itemCount: adapter.itemCount,
          itemBuilder: adapter.onBindView,
        )),
      ],
    );
  }

  ///
//热榜-4小时 http://api.moyu.today/jandan/hot?category=recent
//热榜-吐槽 ？
//热榜-无聊图 http://api.moyu.today/jandan/hot?category=picture
//热榜-随手拍 http://api.moyu.today/jandan/hot?category=ooxx
//热榜-段子 http://api.moyu.today/jandan/hot?category=joke
//热榜-优评 http://api.moyu.today/jandan/hot?category=comment
//热榜-7日 http://api.moyu.today/jandan/hot?category=week
  ///
}

class TopChannelAdapter {
  List<String> _tabTitles = [];

  TopChannelAdapter(this._tabTitles);

  int get itemCount => _tabTitles.length;

  Widget onBindView(BuildContext context, int index) {
    var tabTitle = _tabTitles[index];
    if ("4小时" == tabTitle) {
      return HotPage("recent");
    } else if ("吐槽" == tabTitle) {
      return Center(child:Text(tabTitle));
    } else if ("无聊图" == tabTitle) {
      return HotPage("picture");
    } else if ("随手拍" == tabTitle) {
      return HotPage("ooxx");
    } else if ("段子" == tabTitle) {
      return HotPage("joke");
    } else if ("优评" == tabTitle) {
      return HotPage("comment");
    } else if ("7日" == tabTitle) {
      return HotPage("week");
    }
  }
}
