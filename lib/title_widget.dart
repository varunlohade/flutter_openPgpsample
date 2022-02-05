import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TitleWidget extends StatelessWidget {
   TitleWidget(
    this.title, {
    Key? key,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return  Padding(padding: EdgeInsets.only(top: 10),
    child: Text(
      title,
    style: TextStyle(fontSize: 20),),
    );
  }
}
