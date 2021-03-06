import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/tsm_page/anim/TsmColorAnimatedDecorated.dart';
import 'package:flutter_app1/utils.dart';

class TsmCustomScrollViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TsmCustomScrollViewState();
}

class _TsmCustomScrollViewState extends State<TsmCustomScrollViewPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),

        ///越界回弹效果
        slivers: [
          CupertinoSliverRefreshControl(
            refreshIndicatorExtent: 60,

            /// 刷新过程中悬浮高度
            refreshTriggerPullDistance: 100,

            ///触发刷新的距离
            /// 自定义布局
            builder: (context, buildRefreshindictor, pulledExtent,
                refreshTriggerPullDistance, refreshIndicatorExtent) {
              double opacitye = pulledExtent.round() / 200;
              if (opacitye > 1) {
                opacitye = 1;
              }
              ;
              ColorTween tween =
                  ColorTween(begin: Colors.green, end: Colors.redAccent);
              return TsmColorAnimatedDecorated(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: tween.transform(opacitye),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: AnimatedOpacity(
                      duration: Duration(
                        milliseconds: 300,
                      ),
                      //opacity: top == 80.0 ? 1.0 : 0.0,
                      opacity: getOpacity(
                          buildRefreshindictor, pulledExtent.round()),
                      child: Text(
                        getRefulshText(
                            buildRefreshindictor, pulledExtent.round()),
                        style: TextStyle(fontSize: 12.0),
                      )),
                ),
              );
            },

            ///触发刷新回调
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 3));
//              printString('CupertinoSliverRefreshControl   onRefresh');
            },
          ),

          SliverAppBar(
            centerTitle: true,
            titleSpacing: 0,
            title: Text(
              'CustomScrollView',
              style: TextStyle(color: Colors.black87),
            ),

            /// 停止拖动是否 继续响应拖动事件
            snap: false,

            /// 下滑过程中是否优先展开头部折叠部分 ,
            floating: false,

            ///pinned(固定的)  控制隐藏和展示的   false 就是可以随列表滑出屏幕外  true 不可以
            pinned: true,
            backgroundColor: Colors.blueAccent,
            expandedHeight: 200,

            ///展开后的高度
            flexibleSpace: LayoutBuilder(
              builder: (context, cons) {
                return FlexibleSpaceBar(
//              collapseMode: CollapseMode.pin,
                    background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/hor.jpg'), fit: BoxFit.fill),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '这个是头部',
                        style: TextStyle(color: Colors.pink),
                      ),
                      Text(
                        '这个是头部',
                        style: TextStyle(color: Colors.pink),
                      ),
                      Text(
                        '这个是头部',
                        style: TextStyle(color: Colors.pink),
                      ),
                      Text(
                        '这个是头部',
                        style: TextStyle(color: Colors.pink),
                      ),
                      Text(
                        '这个是头部',
                        style: TextStyle(color: Colors.pink),
                      ),
                    ],
                  ),
                ));
              },
            ),
          ),
//
          SliverPersistentHeader(
            floating: true,
            pinned: false,
            delegate: _SliverPersistenHeaderDelegate(
                minHeight: 50, maxHeight: 150, child: Text('1111')),
          ),
          SliverSafeArea(
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                          height: 50,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                          ),
                          child: Center(
                            child: Text(index.toString()),
                          ),
                        ),
                    childCount: 50)),
          )
        ],
      ),
    );
  }

  String getRefulshText(RefreshIndicatorMode buildRefreshindictor, int round) {
    switch (buildRefreshindictor) {
      case RefreshIndicatorMode.done:
        return '完成刷新';
      case RefreshIndicatorMode.armed:
        return '已拉动:${round}  松开刷新';
      case RefreshIndicatorMode.drag:
        return '已拉动:${round}  下拉刷新';
      case RefreshIndicatorMode.refresh:
        return '正在刷新';
      default:
        return '已拉动:${round} ';
    }
  }
}

double getOpacity(RefreshIndicatorMode buildRefreshindictor, int round) {
  printString(buildRefreshindictor);
  if (buildRefreshindictor == RefreshIndicatorMode.done ||
      buildRefreshindictor == RefreshIndicatorMode.refresh ||
      buildRefreshindictor == RefreshIndicatorMode.armed) {
    return 1;
  }
  if (buildRefreshindictor == RefreshIndicatorMode.drag) {
    double value = round / 60;
    if (value > 1) {
      value = 1;
    }
    printString(value);
    return value;
  }
  return 0;
}

class _SliverPersistenHeaderDelegate extends SliverPersistentHeaderDelegate {
  double maxHeight;
  double minHeight;
  Widget child;

  _SliverPersistenHeaderDelegate({this.maxHeight, this.minHeight, this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => max<double>(minHeight, maxHeight);

  @override
  // TODO: implement minExtent
  double get minExtent => min<double>(minHeight, maxHeight);

  @override
  bool shouldRebuild(_SliverPersistenHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
