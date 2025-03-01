import 'package:flutter/material.dart';

/**
 * 定义三种样式
 */
enum SearchBarType { normal, home, homeLight }

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget(
      {super.key,
      this.searchBarType = SearchBarType.normal,
      this.hideLeft = true,
      this.hideRight = true,
      this.hit,
      this.defaultText,
      this.leftClick,
      this.rightClick,
      this.inputClick,
      this.change});

  final SearchBarType searchBarType;
  final bool hideLeft;
  final bool hideRight;
  final String? hit;
  final String? defaultText;
  final void Function()? leftClick;
  final void Function()? rightClick;
  final void Function()? inputClick;
  final ValueChanged<String>? change;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool showClear = false;
  final TextEditingController _textEditingController = TextEditingController();

  Widget get _home => Row(
        children: [
          _warp(
              Container(
                padding: const EdgeInsets.fromLTRB(6, 5, 10, 5),
                child: Row(
                  children: [
                    Text(
                      '北京',
                      style: TextStyle(color: _homeFontColor),
                    ),
                    Icon(
                      Icons.expand_more,
                      color: _homeFontColor,
                      size: 22,
                    )
                  ],
                ),
              ),
              widget.leftClick),
          Expanded(child: _inputBox),
          //Logout
          _warp(
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  "Logout",
                  style: TextStyle(fontSize: 12, color: _homeFontColor),
                ),
              ),
              widget.rightClick)
        ],
      );

  get _homeFontColor => widget.searchBarType == SearchBarType.homeLight
      ? Colors.black54
      : Colors.white;

  Widget get _normal => Row(
        children: [
          //左侧返回
          _warp(
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: _backBtn,
              ),
              widget.leftClick),
          Expanded(child: _inputBox),
          _warp(
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                ),
              ),
              widget.rightClick),
        ],
      );

  get _backBtn => widget.hideLeft
      ? null
      : const Icon(
          Icons.arrow_back_ios,
          color: Colors.grey,
          size: 26,
        );
  //=> ??
  get _inputBox {
    Color inputColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputColor = Colors.white;
    } else {
      inputColor = Color(0xffededed);
    }
    return Container(
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputColor,
        borderRadius: BorderRadius.circular(
            widget.searchBarType == SearchBarType.normal ? 5 : 15),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchBarType == SearchBarType.normal
                ? const Color(0xffa9a9a9)
                : Colors.blue,
          ),
          Expanded(child: _textField),
          if (showClear)
            _warp(
                Icon(
                  Icons.clear,
                  size: 22,
                  color: Colors.grey,
                ), () {
              setState(() {
                _textEditingController.clear();
              });
              _onChange('');
            })
          //清除按钮
        ],
      ),
    );
  }

  get _textField => widget.searchBarType == SearchBarType.normal
      ? TextField(
          controller: _textEditingController,
          cursorColor: Colors.blue,
          cursorHeight: 15,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w300, fontSize: 15),
          autofocus: true,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(left: 5, bottom: 15, right: 5),
            border: InputBorder.none,
            hintText: widget.hit,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
          ),
          onChanged: _onChange,
        )
      : _warp(
          Text(
            widget.defaultText ?? "",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          widget.inputClick);

  _onChange(String value) {
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

  @override
  void initState() {
    super.initState();
    if (widget.defaultText != null) {
      _textEditingController.text = widget.defaultText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal ? _normal : _home;
  }

  _warp(Widget? child, void Function()? callback) {
    return GestureDetector(
      onTap: callback,
      child: child,
    );
  }
}
