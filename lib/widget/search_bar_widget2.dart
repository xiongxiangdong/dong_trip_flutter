import 'package:flutter/material.dart';

enum SearchBar2Type { normal, home, homeLight }

class SearchBarWidget2 extends StatefulWidget {
  const SearchBarWidget2(
      {super.key,
      this.defaultText,
      this.hit,
      this.hideLeft = false,
      this.hideRight = false,
      this.leftClick,
      this.rightClick,
      this.middleClick,
      this.change,
      this.searchBar2Type = SearchBar2Type.normal});

  final String? defaultText; //默认是文本
  final String? hit; //默认是输入框
  final bool hideLeft;
  final bool hideRight;
  final void Function()? leftClick;
  final void Function()? rightClick;
  final void Function()? middleClick;
  final ValueChanged<String>? change;
  final SearchBar2Type searchBar2Type;

  @override
  State<SearchBarWidget2> createState() => _SearchBarWidget2State();
}

class _SearchBarWidget2State extends State<SearchBarWidget2> {
  get _normal {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Icon(
            Icons.arrow_back_ios,
            size: 26,
            color: Colors.grey,
          ),
        ),
        Expanded(child: _inputText),
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text(
            "查询",
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        )
      ],
    );
  }

  get _home => null;

  get _inputText {
    Color inputBack = widget.searchBar2Type == SearchBar2Type.normal
        ? Color(0xffededed)
        : Colors.white;
    return Container(
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: inputBack),
      child: Row(children: [
        Icon(
          Icons.search,
          size: 15,
          color: widget.searchBar2Type == SearchBar2Type.normal
              ? const Color(0xffa9a9a9)
              : Colors.blue,
        ),
        //直接放外面不行，宽度没设置
        Expanded(
          child: TextField(
            onChanged: _onChange,
            autofocus: true,
            style: const TextStyle(fontSize: 15, color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.only(left: 5, bottom: 15, right: 5),
                hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
                hintText: widget.hit),
          ),
        )
        /**/
      ]),
    );
  }

  _wrap(Widget child, Function()? callback) {
    return GestureDetector(
      onTap: callback,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _normal; //widget.searchBar2Type == SearchBar2Type.normal ? _normal : _home;
  }

  bool showClear = false;

  void _onChange(String value) {
    if (value.isNotEmpty) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.change != null) {
      widget.change!(value);
    }
  }
}
