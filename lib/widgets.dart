import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef StringCallback = void Function(String);
typedef IntCallback = void Function(int);
typedef BoolCallback = void Function(bool);

final color_background = Color(0xFFF5F4F4);

Widget appbar(BuildContext context, String title,
    {back(),
    bool implyLeading = false,
    List<Widget> actions = null,
    TextStyle titleStyle = null,
    bool centerTitle = true}) {
  return AppBar(
    backgroundColor: color_background,
    centerTitle: centerTitle,
    title: Text(title,
        style: titleStyle != null
            ? titleStyle
            : TextStyle(fontSize: 19, color: Colors.black87)),
    elevation: 0,
    brightness: Brightness.light,
    automaticallyImplyLeading: false,
    leading: implyLeading
        ? null
        : IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              back == null ? Navigator.pop(context) : back();
            },
            color: Colors.black87,
          ),
    actions: actions,
  );
}
