import 'package:flutter/material.dart';

import '../model/home_model.dart';

class SaleBoxWidget2 extends StatelessWidget {
  const SaleBoxWidget2({super.key, required this.salesBox});

  final SalesBox salesBox;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 0, 7, 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.white),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    List<Widget> items = [];
    items.add(_doubleItem(
        context, salesBox.bigCard1!, salesBox.bigCard2!, true, false));
    items.add(_doubleItem(
        context, salesBox.smallCard1!, salesBox.smallCard2!, false, false));
    items.add(_doubleItem(
        context, salesBox.smallCard3!, salesBox.smallCard4!, false, false));
    /*return Column(
      children: [
        Row(
          //??
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0, 1),
        ),
        Container(
          alignment: Alignment.center,
          child: _doubleItem(
              context, salesBox.bigCard1!, salesBox.bigCard2!, true, false),
        ),
      ],
    );*/
    return Column(
      children: [
        _titleItem(context),
        Row(
          //??
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0, 1),
        ),
        Row(
          //子 Widget 居中,MainAxisAlignment.spaceBetween —— 子 Widget 对齐起始和末端，其余空间平均分配。
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1, 2),
        ),
        Row(
          //??
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2, 3),
        )
      ],
    );
  }

  Widget _doubleItem(BuildContext context, CommonModel left, CommonModel right,
      bool big, bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _item(context, left, big, true),
        _item(context, right, big, false)
      ],
    );
  }

  _item(BuildContext context, CommonModel model, bool big, bool left) {
    BorderSide borderSide = const BorderSide(color: Colors.red, width: 0.8);
    double width = MediaQuery.of(context).size.width / 2 - 10;
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                left: left ? BorderSide.none : borderSide, bottom: borderSide)),
        child: Image.network(
          model.icon!,
          width: width,
          height: big ? 130 : 70,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _titleItem(BuildContext context) {
    return Container(
      height: 44,
      margin: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xfff2f2f2), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            salesBox.icon!,
            height: 15,
            fit: BoxFit.fill,
          ),
          _moreItem()
        ],
      ),
    );
  }

  _moreItem() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 1, 8, 1),
      margin: const EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
            colors: [Color(0xffff4e63), Color(0xffff6cc9)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
      ),
      child: GestureDetector(
        onTap: () {},
        child: const Text(
          '获取更多',
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }

  _title(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.network(salesBox.icon!),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: const LinearGradient(
                colors: [Color(0xffff4e63), Color(0xffff6cc9)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight),
          ),
          child: const Text(
            "获取更多",
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        )
      ],
    );
  }
}
