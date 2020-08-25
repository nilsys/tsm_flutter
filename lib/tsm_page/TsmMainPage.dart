import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/utils.dart';
import 'package:flutter_app1/widget/ViewInflate.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_app1/tsm_extension/str_extension.dart';

import '../tsm_page_routes.dart';
import 'main/TsmScaffoldPage.dart';

class TsmMainPage extends StatefulWidget {
  @override
  _TsmMainState createState() => _TsmMainState();
}

class _TsmMainState extends State<TsmMainPage> {
  List<String> list;
  ScrollController _controller;

  var _direction = Axis.vertical;

  @override
  void dispose() {
    _controller?.removeListener(lis);
    super.dispose();
  }

  void lis() {
    printString(
        'offset:${_controller.offset}     positon:${_controller.position}');
  }

  @override
  void initState() {
    super.initState();
    _controller =
        ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
    _controller.addListener(lis);
    list = [
      'Scaffold 学习',
      'AppBar学习',
      'Container 学习',
      'Row and Column',
      'Text 拼接,与富文本',
      'TextField 输入框学习',
      'RaisedButton 学习',
      'Icon  学习',
      "Image 学习",
      '改变listView方向',
      'ScrollView  集合',
      '国航航班动态练习',
      'Icon  学习',
      'Icon  学习',
      'Icon  学习',
      'Icon  学习',
      'Icon  学习',
      'Icon  学习',
      'Icon  学习',
      'Icon  学习',
      'Icon  学习',
      'Icon  学习',
      'Icon  学习',
      'Icon  学习',
      'Icon  学习',
      'Icon  学习',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主页 ListView 属性'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: inflateText("跳跃", Colors.white, 15),
        onPressed: () {
          _controller.animateTo(100,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
      ),
      body: Container(
        color: Colors.white,
        child: Scrollbar(
          child: ListView.separated(
            ///类似ios 月结回弹的效果,但是需要列表的长度必须沾满他的viewport
            ///也就是子布局高度的总和必须大于listview 的实际高度度
            physics: BouncingScrollPhysics(),
            controller: _controller,

            ///看到 属性介绍primary 如果为真的时候即使他没有足够的高度来实际滚动他也会滚动,
            ///但是要求 controller 为 null ,但是我哦试验了一下没有作用
//          primary: true,
            separatorBuilder: (con, index) => Divider(),
            scrollDirection: _direction,
            itemBuilder: (BuildContext, int) => Container(
                child: FlatButton(
              child: Center(
                child: Text(
                  list[int],
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
              onPressed: () {
                _onPressedItem(context, int);
              },
            )),
            itemCount: list.length,
          ),
        ),
      ),
    );
  }

  Future<void> _onPressedItem(BuildContext context, int index) async {
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return TsmScaffoldPage();
        },settings: RouteSettings(arguments: 'value'))).then((value) => printString(value));
//        Navigator.of(context).pushNamed(page_routes_scaffold);
        break;
      case 1:
        Navigator.of(context).pushNamed(page_routes_appbar,arguments: 'test');
        break;
      case 2:
        Navigator.of(context).pushNamed(page_routes_container);
        break;
      case 3:
        Navigator.of(context).pushNamed(page_routes_row_and_column);
        break;
      case 4:
        Navigator.of(context).pushNamed(page_routes_text);
        break;
      case 5:
        Navigator.of(context).pushNamed(page_routes_text_field);
        break;
      case 6:
        Navigator.of(context).pushNamed(page_routes_raised_button);
        break;
      case 7:
        Navigator.of(context).pushNamed(page_routes_icon);
        break;
      case 8:
        [Permission.storage, Permission.camera].request()
          ..then((value) {
            if (value[Permission.storage].isGranted) {
              if (value[Permission.camera].isGranted) {
                Navigator.of(context).pushNamed(page_routes_iamge);
              }
            }
          });
        //还有一种写法是
//      var result = await Permission.storage.request();
//      if (result.isGranted) {
//        Navigator.of(context).pushNamed(page_routes_iamge);
//      }
        break;
      case 9:

        ///切换方向
        setState(() {
          if (_direction == Axis.vertical) {
            _direction = Axis.horizontal;
          } else {
            _direction = Axis.vertical;
          }
        });
        break;
      case 10:
        Navigator.of(context).pushNamed(page_routes_scroll_base);
        break;
      case 11:
        Navigator.of(context).pushNamed(page_routes_flight_dyn);
        break;
    }
  }
}
