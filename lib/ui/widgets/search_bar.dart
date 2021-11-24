import 'package:flutter/material.dart';

///自定义搜索 Bar，根据页面不同展示效果
class SearchBar extends StatefulWidget {
  final bool enable; //是否可点击
  final bool hideLeft; //是否隐藏左边的控件
  final bool autoFocus; //是否自动获取焦点
  final String? hint; //默认提示的文本
  final String defaultText; //默认搜索的文字
  final void Function() rightButtonClick; //右侧控件点击事件回调
  final void Function() leftButtonClick; //左侧控件点击事件回调
  final void Function() speakClick; //语音输入小图标点击回调
  final void Function() inputBoxClick; //输入框点击回调
  final ValueChanged<String> onChanged; //输入文本变化回调

  const SearchBar(
      {Key? key,
      this.enable = true,
      this.hideLeft = true,
      this.autoFocus = false,
      this.hint,
      required this.defaultText,
      required this.rightButtonClick,
      required this.leftButtonClick,
      required this.speakClick,
      required this.inputBoxClick,
      required this.onChanged})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  //是否显示右侧的清除按钮
  bool showClear = false;

  //输入文本框内容监听
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.defaultText;
  }

  @override
  Widget build(BuildContext context) {
    return _normalSearchStyle();
  }

  ///获取字体颜色
  Color get _homeFontColor {
    return Colors.white;
  }

  ///文本改变的回调,修改右侧清楚按钮的显示和隐藏
  void _onChanged(String text) {
    if (text.isNotEmpty) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    widget.onChanged(text);
  }

  /// 获取默认样式的搜索框
  Widget _normalSearchStyle() {
    return Row(
      children: [
        _wrapTap(
            Container(
              padding: const EdgeInsets.fromLTRB(6, 5, 10, 5),
              child: widget.hideLeft
                  ? null
                  : const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey,
                      size: 26,
                    ),
            ),
            widget.leftButtonClick),
        Expanded(
          flex: 1,
          child: _inputBox,
        ),
        _wrapTap(
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: const Text(
                '搜索',
                style: TextStyle(color: Colors.blue, fontSize: 17),
              ),
            ),
            widget.rightButtonClick)
      ],
    );
  }

  ///输入框 Widget
  Widget get _inputBox {
    return Container(
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const Icon(Icons.search, size: 20, color: Color(0xffa9a9a9)),
          Expanded(
              flex: 1,
              child: TextField(
                controller: _controller,
                onChanged: _onChanged,
                autofocus: widget.autoFocus,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                    left: 5,
                    bottom: 14,
                    right: 5,
                  ),
                  border: InputBorder.none,
                  hintText: widget.hint ?? '',
                  hintStyle: const TextStyle(fontSize: 15),
                ),
              )),
          showClear
              ? _wrapTap(
                  const Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.grey,
                  ), () {
                  setState(() {
                    _controller.clear();
                  });
                  _onChanged('');
                })
              : _wrapTap(
                  const Icon(Icons.mic, size: 22, color: Colors.blue),
                  widget.speakClick,
                )
        ],
      ),
    );
  }

  ///对需要点击的Widget进一步封装
  Widget _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
        onTap: () {
          callback();
        },
        child: child);
  }
}
