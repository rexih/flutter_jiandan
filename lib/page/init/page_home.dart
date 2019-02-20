import 'package:flutter/material.dart';
import 'package:flutter_jiandan/page/init/page_drawer.dart';
import 'package:flutter_jiandan/page/main/page_duan.dart';
import 'package:flutter_jiandan/page/main/page_ooxx.dart';
import 'package:flutter_jiandan/page/main/page_pic.dart';
import 'package:flutter_jiandan/page/main/page_top.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> _tabItems;
  List<String> _tabTitles;
  BottomNavigationBar _bottomNavigationBar;
  int _curIndex = 2;
  SubPageAdapter adapter;
  var _pageController;

  @override
  void initState() {
    super.initState();
    _initUi();
  }

  void _initUi() {
    _tabItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.explore), title: Text("新鲜事")),
      BottomNavigationBarItem(icon: Icon(Icons.wallpaper), title: Text("无聊图")),
      BottomNavigationBarItem(icon: Icon(Icons.whatshot), title: Text("热榜")),
      BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle), title: Text("随手拍")),
      BottomNavigationBarItem(
          icon: Icon(Icons.sentiment_very_satisfied), title: Text("段子")),
    ];
    _tabTitles = _tabItems.map((BottomNavigationBarItem tab) {
      return ((tab.title) as Text).data;
    }).toList();
    adapter = SubPageAdapter(_tabTitles);
    _pageController = new PageController(initialPage: _curIndex);
  }

  @override
  Widget build(BuildContext context) {
    _bottomNavigationBar = BottomNavigationBar(
      items: _tabItems,
      currentIndex: _curIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        _pageController.jumpToPage(index);
        setState(() {
          if (_curIndex != index) {
            _curIndex = index;
          }
        });
      },
    );

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFFFFE57B),
          title: Text(_tabTitles[_curIndex])),
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            if (_curIndex != index) {
              _curIndex = index;
            }
          });
        },
        itemCount: adapter.itemCount,
        itemBuilder: adapter.onBindView,
      ),
      bottomNavigationBar: _bottomNavigationBar,
      drawer: DrawerPage()
    );
  }
}

class SubPageAdapter {
  List<String> _tabTitles = [];

  SubPageAdapter(this._tabTitles);

  int get itemCount => 5;

  Widget onBindView(BuildContext context, int index) {
    var tabTitle = _tabTitles[index];
    if ("无聊图" == tabTitle) {
      return PicPage();
    } else if ("热榜" == tabTitle) {
      return TopPage();
    } else if ("新鲜事" == tabTitle) {
      return PicPage();
    } else if ("随手拍" == tabTitle) {
      return OoxxPage();
    } else if ("段子" == tabTitle) {
      return DuanPage();
    }
  }
}
