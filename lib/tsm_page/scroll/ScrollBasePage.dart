import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../tsm_page_routes.dart';

class ScrollBasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> list = ["SingleChildScrollView", 'GridView',"ListView",'CustomScrollView'];
    return Scaffold(
      appBar: AppBar(
        title: Text('ScrollView 集合'),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemCount: list.length,
          separatorBuilder: (context,index)=>Divider(),
          itemBuilder: (context, index) => LayoutBuilder(
            builder: (context, cons) => SizedBox(
              width: cons.maxWidth,
              child: FlatButton(
                child: Text(list[index]),
                onPressed: () => clickItem(context, index),
              ),
            ),
          ),
        ),
      )
    );
  }

  void clickItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed(page_routes_single_child_scroll_view);
        break;
      case 1:
        Navigator.of(context).pushNamed(page_routes_grid_view);
        break;
      case 2:
        Navigator.of(context).pushNamed(page_routes_list_view);
        break;
      case 3:
        Navigator.of(context).pushNamed(page_routes_custom_scroll_view);
        break;
    }
  }
}
