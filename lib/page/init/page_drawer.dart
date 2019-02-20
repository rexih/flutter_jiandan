import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrawerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  // TODO 账户信息
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("昵称"),
            accountEmail: Text("email"),
//            decoration: BoxDecoration(color: Color(0xFFFFE57B)),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.account_circle),
            ),
            otherAccountsPictures: <Widget>[
              CircleAvatar(
                child: Icon(Icons.settings),
              ),
              CircleAvatar(
                child: Icon(Icons.share),
              ),
              CircleAvatar(
                child: Icon(Icons.brightness_high),
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.category, color: Color(0xFFFFE57B)),
            title: Text('频道'),
            onTap: () {
              Navigator.pop(context); // close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark, color: Color(0xFFFFE57B)),
            title: Text('收藏'),
            onTap: () {
              Navigator.pop(context); // close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.face, color: Color(0xFFFFE57B)),
            title: Text('关于我'),
            onTap: () {
              Navigator.pop(context); // close the drawer
            },
          ),
          Divider(height: 0.5,),
          Container(
            color: Colors.white,
            alignment: Alignment.center,child: Image.asset("assets/images/logo-2018-2.gif"),),
          Divider(height: 0.5,),
          AboutListTile(
            icon: Image.asset('assets/images/favicon.ico'),
            child: Text("关于煎蛋flutter"),
//              applicationIcon: Image.asset('assets/images/favicon.ico'),
            applicationName: "煎蛋flutter",
            applicationVersion: "当前版本v0.0.1",
            //TODO 版本处理
            applicationLegalese: "仅供学习交流使用",
            aboutBoxChildren: <Widget>[
              Divider(),
              Text("检查新版本"), // TODO 版本检查
              Divider(),
              Text("投稿及反馈：TG@jandan.com"),
              Divider(),
              Text("Github源码"),
            ],
          ),

        ],
      ),
    );
  }
}
