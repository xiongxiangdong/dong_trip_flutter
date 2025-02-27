import 'package:flutter/material.dart';

import '../model/home_model.dart';

class GridNavWidget extends StatelessWidget {
  const GridNavWidget({super.key, required this.gridNav});

  final GridNav gridNav;

  @override
  Widget build(BuildContext context) {
    ///裁切圆角
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
      child: PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: _gridItems(context),
        ),
      ),
    );
  }

  ///从上往下添加三个导航条
  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    items.add(_gridNavItem(context, gridNav.hotel!, true));
    items.add(_gridNavItem(context, gridNav.flight!, false));
    items.add(_gridNavItem(context, gridNav.travel!, false));
    return items;
  }

  ///添加导航条，first 是否为第一个导航条
  Widget _gridNavItem(BuildContext context, Hotel gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem!));

    //左右排列的item
    List<Widget> expandItems = [];
    for (var item in items) {
      //设置每个item评分间距
      expandItems.add(Expanded(flex: 1, child: item));
    }
    Color startColor = Color(int.parse('0xff${gridNavItem.startColor!}'));
    Color endColor = Color(int.parse('0xff${gridNavItem.endColor!}'));
    return Container(
      height: 88,
      margin: first ? null : const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        //线性渐变
        gradient: LinearGradient(colors: [startColor, endColor]),
      ),
      child: Row(children: expandItems),
    );
  }

  ///左侧大卡片
  Widget _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Image.network(model.icon!,
                fit: BoxFit.contain,
                height: 88,
                width: 121,
                alignment: AlignmentDirectional.bottomEnd),
            Container(
              margin: const EdgeInsets.only(top: 11),
              child: Text(
                model.title!,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            )
          ],
        ),
        model);
  }

  /*********************************************/
  _gridItems(BuildContext context) {
    List<Widget> items = [];
    items.add(_gridItem(context, gridNav.hotel!, true));
    items.add(_gridItem(context, gridNav.flight!, false));
    items.add(_gridItem(context, gridNav.travel!, false));
    return items;
  }

  Widget _gridItem(BuildContext context, Hotel gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(_main(context, gridNavItem.mainItem!));
    items.add(_doubleItem(context, gridNavItem.item1!, gridNavItem.item2!));
    items.add(_doubleItem(context, gridNavItem.item3!, gridNavItem.item4!));
    List<Widget> expandItems = [];
    for (var item in items) {
      //设置每个Item平分间距
      expandItems.add(Expanded(flex: 1, child: item));
    }
    Color startColor = Color(int.parse('0xff${gridNavItem.startColor!}'));
    Color endColor = Color(int.parse('0xff${gridNavItem.endColor!}'));
    return Container(
      height: 88,
      margin: first ? null : const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(
        children: expandItems,
      ),
    );
  }

  Widget _main(BuildContext context, CommonModel commonModel) {
    return _wrapGesture(
      context,
      Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Image.network(
            commonModel.icon!,
            fit: BoxFit.contain, //cover会变形
            height: 88,
            width: 121,
            alignment: AlignmentDirectional.bottomEnd,
          ),
          Container(
            margin: const EdgeInsets.only(top: 11),
            child: Text(
              commonModel.title!,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ],
      ),
      commonModel,
    );
  }

  Widget _doubleItem(
      BuildContext context, CommonModel top, CommonModel bottom) {
    return Column(
      children: [
        Expanded(child: _item(context, top, true)),
        Expanded(child: _item(context, bottom, false)),
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel commonModel, bool first) {
    BorderSide borderSide = const BorderSide(width: 0.8, color: Colors.white);
    return Container(
      decoration: BoxDecoration(
          border: Border(
        left: borderSide,
        bottom: first ? borderSide : BorderSide.none,
      )),
      child: _wrapGesture(
          context,
          Center(
            child: Text(
              commonModel.title!,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          commonModel),
    );
  }

  Widget _wrapGesture(
      BuildContext context, Widget widget, CommonModel commonModel) {
    return GestureDetector(
      onTap: () {},
      child: widget,
    );
  }
}
